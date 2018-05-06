public class OpportunityTriggerOperations{
        
    public static void updateTotalPriceOnCampaigns(){
    System.debug('Calling the Main Class');
        Boolean contactChanged = false;
        Boolean amountChanged = false ;
        Set<Id> campaignIdSet = new Set<Id>();
        
        Map<id,list<opportunity>> campaignWitholdOpptlist = new Map<id,list<opportunity>>();
        Map<id,list<opportunity>> campaignWithnewOpplist = new Map<id,list<opportunity>>();
        Map<id,list<opportunity>> campaignWithOppList = new Map<id,list<opportunity>>();
        Set<id> contactsSets = new Set<id>();

        for(opportunity oppNew : (List<opportunity>) Trigger.new)
        {
            opportunity oldRec = (opportunity)Trigger.oldMap.get(oppNew.id) ; 
            //Different Scenario of Opportunity Update
            //            
            if((oppNew.Amount != oldRec.Amount) && oppNew.aura_beginner__Contact__c != null && oppNew.CampaignId != null){                
                amountChanged = true;
                if(campaignWithOppList.containskey(oppNew.CampaignId)){
                    list<opportunity> opList = new list<opportunity>();
                    opList = campaignWithOppList.get(oppNew.CampaignId);
                    opList.add(oppNew);
                    campaignWithOppList.put(oppNew.campaignId,opList);
                }else{
                    list<opportunity> opList = new list<opportunity>();
                    opList.add(oppNew);
                    campaignWithOppList.put(oppNew.campaignId,opList);
                }


            }else if((oppNew.aura_beginner__Contact__c != oldRec.aura_beginner__Contact__c)  || (oppNew.CampaignId != oldRec.CampaignId)   && oppNew.amount != null){

                 
                 contactsSets.add(oldRec.aura_beginner__Contact__c);
                 contactsSets.add(oppNew.aura_beginner__Contact__c);
                 campaignIdSet.add(oppNew.CampaignId);
                 campaignIdSet.add(oldRec.CampaignId);
                 contactChanged = true;

                 if(campaignWitholdOpptlist.containskey(oldRec.CampaignId)){
                    list<opportunity> opList = new list<opportunity>();
                    opList = campaignWitholdOpptlist.get(oldRec.CampaignId);
                    opList.add(oldRec);
                    campaignWitholdOpptlist.put(oldRec.campaignId,opList);
                }else{
                    list<opportunity> opList = new list<opportunity>();
                    opList.add(oldRec);
                    campaignWitholdOpptlist.put(oldRec.campaignId,opList);
                }

                if(campaignWithnewOpplist.containskey(oppNew.CampaignId)){
                    list<opportunity> opList = new list<opportunity>();
                    opList = campaignWithnewOpplist.get(oppNew.CampaignId);
                    opList.add(oppNew);
                    campaignWithnewOpplist.put(oppNew.campaignId,opList);
                }else{
                    list<opportunity> opList = new list<opportunity>();
                    opList.add(oppNew);
                    campaignWithnewOpplist.put(oppNew.campaignId,opList);
                }

              }
        }

   
        if(amountChanged){
            updateTotalPriceOnCampaignMembers(campaignWithOppList);
        }
        if(contactChanged){
            updateTotalPriceOnContactChange(campaignWithnewOpplist,campaignWitholdOpptlist,contactsSets,campaignIdSet);
        }
    }

    
    public static void updateTotalPriceOnContactChange(Map<id,list<opportunity>> campaignWithnewOpplist , Map<id,list<opportunity>> campaignWithnoldOpplist,set<id> contactsSets,set<id> campaignIdSet){

        list<campaignMember> cmList = new List<campaignMember>();
                
        for(campaignMember CM : [Select Id, aura_beginner__total_amount__c,campaignId,ContactId from campaignMember where campaignId IN : campaignIdSet AND ContactId != null AND contactId IN : contactsSets]){

            if(campaignWithnewOpplist.containsKey(CM.campaignId)){
                
                for(opportunity oppRec : campaignWithnewOpplist.get(CM.campaignId)){
                    if((oppRec.aura_beginner__Contact__c == CM.ContactId) && (oppRec.campaignId == CM.campaignId) ){
                        decimal oppAmount =  oppRec.Amount;
                        System.debug('CM.aura_beginner__total_amount__c::::'+CM.aura_beginner__total_amount__c);
                        System.debug('oppAmount::::'+oppAmount);
                        if(CM.aura_beginner__total_amount__c != null && oppAmount != null ){
                            CM.aura_beginner__total_amount__c = CM.aura_beginner__total_amount__c + oppAmount ;
                        }else if(oppAmount != null){
                            CM.aura_beginner__total_amount__c = oppAmount ;
                        }
                        cmList.add(CM);
                    }
                }
            }
            

            if(campaignWithnoldOpplist.containsKey(CM.campaignId)){                
                for(opportunity oppRec : campaignWithnoldOpplist.get(CM.campaignId)){
                    if((oppRec.aura_beginner__Contact__c == CM.ContactId) && (oppRec.campaignId == CM.campaignId) ){
                        decimal oppAmount =  oppRec.Amount;
                        if(CM.aura_beginner__total_amount__c != null){
                            CM.aura_beginner__total_amount__c = CM.aura_beginner__total_amount__c - oppAmount ;
                        }else{
                            CM.aura_beginner__total_amount__c = 0.0 ;
                        }
                        cmList.add(CM);
                    }
                }
            }
        
        }
        System.debug('cmList:::::'+cmList);
        if(!cmList.isEmpty()){
            update cmList ;
        }
        
    }
    
    public static void updateTotalPriceOnCampaignMembers(Map<id,list<opportunity>> campaignWithOppList ){

            
            Set<id> contactIds = new Set<Id>();
            for(id cmId : campaignWithOppList.keySet()){
                for(opportunity opp: campaignWithOppList.get(cmId)){
                    contactIds.add(opp.aura_beginner__Contact__c);
                }
            }

            System.debug('contactIds:::'+contactIds);
            Map<string,decimal> contactWithAmountMap = new Map<string,decimal>();
            for(opportunity op: [Select Id,Amount,CampaignId,aura_beginner__Contact__c from opportunity where campaignId IN : campaignWithOppList.keySet() AND aura_beginner__Contact__c IN : contactIds AND amount != null]){

                string uniqueStr = string.valueOf(op.campaignId) + string.valueOf(op.aura_beginner__Contact__c) ;

                if(contactWithAmountMap.containsKey(uniqueStr)){
                    decimal amt = contactWithAmountMap.get(uniqueStr);
                    amt = amt + op.amount;
                    contactWithAmountMap.put(uniqueStr,amt);
                }else{
                    decimal amt = op.amount ; 
                    contactWithAmountMap.put(uniqueStr,amt);
                }

            }

            System.debug('contactWithAmountMap:::'+contactWithAmountMap);

            Map<id,list<campaignMember>> campaignWithMemberMap = new Map<id,list<campaignMember>>();
            for(campaignMember CM : [Select Id, aura_beginner__total_amount__c,campaignId,ContactId from campaignMember where campaignId IN : campaignWithOppList.keySet() AND contactId IN : contactIds]){
               
                if(campaignWithMemberMap.containskey(CM.campaignId)){
                    list<campaignMember> cmList = new list<campaignMember>();
                     cmList = campaignWithMemberMap.get(CM.campaignId);
                    cmList.add(CM);
                    campaignWithMemberMap.put(CM.campaignId,cmList);
                }else{
                    list<campaignMember> cmList = new list<campaignMember>();
                    cmList.add(CM);
                    campaignWithMemberMap.put(CM.campaignId,cmList);
                }
            }    
        system.debug('campaignWithMemberMap:::::'+campaignWithMemberMap);
            list<campaignMember> campaignMemberList = new list<campaignMember>();

            for(id cmId : campaignWithMemberMap.keySet()){

                for(campaignMember cmMember : campaignWithMemberMap.get(cmId)){

                    string uniqKey = string.valueOf(cmMember.campaignId) + string.valueOf(cmMember.contactId) ;
                    system.debug('uniqKey:::::'+uniqKey);
                    if(contactWithAmountMap.containsKey(uniqKey)){
                        cmMember.aura_beginner__total_amount__c = contactWithAmountMap.get(uniqKey);
                        campaignMemberList.add(cmMember);
                    }

                }
            }

            if(!campaignMemberList.isEmpty()){
                update campaignMemberList ;
            }
    }
    
    
}
public class leadTriggerHandler {

    public static void beforeInsert(list<lead> leadList){

        for(lead newLead : leadList){
            String companyStr = newLead.company ;
            String[] arrCompany = companyStr.split(',');

            string uniqueCompany ;
            for(string str :arrCompany){
                string trimmedStr = str.Trim();
                if(uniqueCompany != null && uniqueCompany != ''){
                    uniqueCompany += trimmedStr.replaceAll('\\s+', '');
                }else{
                    uniqueCompany = trimmedStr.replaceAll('\\s+', '') ;
                }
            }
            newLead.UniqueCompany__c = uniqueCompany.trim();
        }
        leadTriggerHandler.findCompanyState(leadList);

    }

    public static void findCompanyState(list<lead> leadList){

        String stateValues = system.Label.states ;
        String[] arrState = stateValues.split(',');

        for(lead newLead : leadList){
            String companyStr = newLead.company ;
            String[] arrCompany = companyStr.split(',');
            Boolean stateFound= false;
            
            System.debug('arrCompany.size()---->'+arrCompany.size());

            if(arrCompany.size() > = 3) {
                String companyState = arrCompany[2].trim() ;
                System.debug('companyState--->'+companyState);
                for(string stateStr : arrState){
                System.debug('stateStr--->'+stateStr);
                    if(stateStr.contains(companyState)){
                    System.debug('Yes');
                        newLead.CompanyState__c = companyState;
                        //exit for;
                    }
                }
            }else{
            System.debug('Else');
                newLead.CompanyState__c = '';
            }
        }

    }

}
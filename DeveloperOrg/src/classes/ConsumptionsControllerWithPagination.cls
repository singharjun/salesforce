public class ConsumptionsControllerWithPagination {     

   // public List<aura_beginner__Consumption_Charges__b> consumptions{get;set;} 

    public aura_beginner__Billing_Account__c accounts {get;set;} 

    public aura_beginner__Billing_Account__c acc {get;set;} 
    
    //List to store all the contacts according to requirement
    public List<aura_beginner__Consumption_Charges__b> AllConsumption ;
    
    //List to show the limited records on the page
    public List<aura_beginner__Consumption_Charges__b> ConsumptionsToShow{get;set;}
    
    //Navigation variables
    Integer counter = 0;//TO track the number of records parsed
    Integer limitSize = 3;//Number of records to be displayed
    Integer totalSize =0; //To Store the total number of records available
    public boolean showAllRecords{get;set;}
     

    //Constructor 
    
    public ConsumptionsControllerWithPagination(ApexPages.StandardController controller) { 
    
    String showAll = System.currentPageReference().getParameters().get('showAll');
    
    System.debug('showAll>>>>'+showAll);
    showAllRecords = false;
    if(showAll == null || showAll == ''){
        showAllRecords = false;
    }else if (showAll.equalsIgnoreCase('True')){
        showAllRecords = true;
    }   
    
    

        acc = (aura_beginner__Billing_Account__c)controller.getRecord();      
        
        System.debug('acc>>>'+acc);

        accounts = [SELECT id FROM aura_beginner__Billing_Account__c WHERE id=: acc.id LIMIT 1]; 
        
        System.debug('accounts>>>'+accounts);
        AllConsumption = new list<aura_beginner__Consumption_Charges__b>();
        ConsumptionsToShow = new list<aura_beginner__Consumption_Charges__b>();

        AllConsumption = [SELECT id,aura_beginner__Billing_Account__c,aura_beginner__Billing_Account__r.name, aura_beginner__Billing_Frequency__c, aura_beginner__Status__c FROM aura_beginner__Consumption_Charges__b WHERE aura_beginner__Billing_Account__c = :accounts.id ];   

        System.debug('AllConsumption>>>'+AllConsumption);       
        
        System.debug('AllConsumption0Index>>>'+AllConsumption[0]);
        
        System.debug('AllConsumptionFirstIndex>>>'+AllConsumption[1]);
        
        //Store the total size
        totalSize = AllConsumption.size();
        
        //Intial adding of contacts to ConsumptionsToShow
        //check the total records are more than limitSize and assign the records
        if(!showAllRecords){
            if((counter+limitSize) <= totalSize){
                
                for(Integer i=0;i<limitSize;i++){
                    System.debug('i>>>>>>'+i);
                    ConsumptionsToShow.add(AllConsumption[i]);
                }
            }else{
                for(Integer i=0;i<totalSize;i++){
                    System.debug('i1>>>>>>'+i);
                    ConsumptionsToShow.add(AllConsumption[i]);
                }
            }
        }else{
            ConsumptionsToShow.addAll(AllConsumption);
        }   

    }
    
    public pageReference viewAllConsumption(){  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/consumptionCompWithPagination?showAll=True&id='+accounts.id);  

        return pageRef; 

    }

}
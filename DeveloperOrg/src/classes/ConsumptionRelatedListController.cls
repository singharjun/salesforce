public class ConsumptionRelatedListController { 
    public ConsumptionRelatedListController() {

    }


    public ConsumptionRelatedListController(ApexPages.StandardController controller) {

    }

    

   // public List<aura_beginner__Consumption_Charges__b> consumptions{get;set;} 

    public aura_beginner__Billing_Account__c accounts {get;set;} 

    public aura_beginner__Billing_Account__c acc {get;set;} 
    Public Integer size{get;set;}
    Public Integer noOfRecords{get; set;}

     

    //Constructor 
    /*
    public ConsumptionRelatedListController(ApexPages.StandardController controller) { 

        acc = (aura_beginner__Billing_Account__c)controller.getRecord();      

        accounts = [SELECT id FROM aura_beginner__Billing_Account__c WHERE id=: acc.id LIMIT 1]; 

        consumptions = [SELECT id,aura_beginner__Billing_Account__c,aura_beginner__Billing_Account__r.name, aura_beginner__Billing_Frequency__c, aura_beginner__Status__c FROM aura_beginner__Consumption_Charges__b WHERE aura_beginner__Billing_Account__c = :accounts.id ];     

} 

*/
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 10;
                string queryString = 'SELECT aura_beginner__Billing_Account__c,aura_beginner__Billing_Account__r.name, aura_beginner__Billing_Frequency__c, aura_beginner__Status__c FROM aura_beginner__Consumption_Charges__b';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }

    //This method is to create a new contact while clicking on the Add contact button 
/*
    public pageReference newConsumption(){  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/003/e?&retURL=' + accounts.id);  

        return pageRef; 

    } 
*/
    //This method is to edit the existing contact record while clicking the Edit link 

    /*
    public pageReference editConsumption(){  

        String contactId = Apexpages.currentpage().getParameters().get('contactId');  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + contactId + '/e?retURL=' + accounts.id);  

        return pageRef;  

    }    
*/

 //This method is to delete the contact record while clicking the Del link 

/*  
  public pageReference deleteConsumption(){  

        String contactId = Apexpages.currentpage().getParameters().get('contactId');  

        aura_beginner__Consumption_Charges__b contactList = [SELECT Id FROM aura_beginner__Consumption_Charges__b WHERE aura_beginner__Billing_Account__c = : contactId LIMIT 1]; 

        delete contactList; 

        String baseUrl = URL.getSalesforceBaseUrl().toExternalForm(); 

        PageReference redirectPage = new PageReference(baseUrl+'/'+accounts.id); 

        return redirectPage;  

    }   
    
*/  
    
    // Pagination with StandardSetController
    
    
    Public List<aura_beginner__Consumption_Charges__b> getConsumptions(){
        List<aura_beginner__Consumption_Charges__b> accList = new List<aura_beginner__Consumption_Charges__b>();
        for(aura_beginner__Consumption_Charges__b a : (List<aura_beginner__Consumption_Charges__b>)setCon.getRecords())
            accList.add(a);
        return accList;
    }
    
    public pageReference refresh() {
        setCon = null;
        getConsumptions();
        setCon.setPageNumber(1);
        return null;
    }
    
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
 
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
 
    public void first() {
        setCon.first();
    }
 
    public void last() {
        setCon.last();
    }
 
    public void previous() {
        setCon.previous();
    }
 
    public void next() {
        setCon.next();
    }

}
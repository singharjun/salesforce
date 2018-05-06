public class seasonControllerExtension{

//public list<trackWrapper> trackList{get;set;}
public string difficulty{get;set;}
Public Integer noOfRecords{get; set;}
Public Integer size{get;set;}
public aura_beginner__Season__c seasonRec{get;set;}

public ApexPages.StandardSetController setCon{
        get{
            if(setCon == null){
                size = 3;
                string queryString = 'select Name,Id,aura_beginner__Difficulty__c,aura_beginner__Location__c,aura_beginner__CircuitLengthKM__c from aura_beginner__Track__c';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
                
            }
            return setCon;
        }set;   
    }
    
    //This method uses a simple SOQL query to return a List of Contacts
    public List<trackWrapper> gettracks() {
        list<trackWrapper> trackList = new List<trackWrapper>();
       // if(trackList == null) {
            //trackList = new List<trackWrapper>();
            for(aura_beginner__Track__c c : (List<aura_beginner__Track__c>)setCon.getRecords()) {
                trackList.add(new trackWrapper(c));
            }
       // }
        return trackList;
    }

    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select One','Select One'));
        options.add(new SelectOption('Noob','Noob'));
        options.add(new SelectOption('Easy','Easy'));
        options.add(new SelectOption('Moderate','Moderate'));
        options.add(new SelectOption('Hard','Hard'));
        options.add(new SelectOption('Insane','Insane'));
        return options;
    }
    
    public class trackWrapper {
        public aura_beginner__Track__c track {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public trackWrapper(aura_beginner__Track__c c) {
            track = c;
            selected = false;
        }
    }
}
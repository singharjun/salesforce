public class retrieveContacts {
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id,Name,Account.name,MobilePhone FROM contact]));
            }
            return setCon;
        }
        set;
    }
    public List<contact> getcontacts() {
        return (List<contact>) setCon.getRecords();
    }
}
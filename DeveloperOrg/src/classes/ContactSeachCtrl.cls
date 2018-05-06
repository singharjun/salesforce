public with sharing class ContactSeachCtrl {

@RemoteAction
    public static list<contact> searchCustomer(string searchString){
        String CustomerName = '%' + String.escapeSingleQuotes(searchString) + '%' ;
        
        
        return [select Id ,FirstName,LastName,Email,Phone,Account.name from contact where name like :CustomerName];
    }
    
}
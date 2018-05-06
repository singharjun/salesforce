public with sharing class ContactController {
    
    @AuraEnabled
    public static list<contact> SearchContacts(){
        
        return[Select Id, Name, Phone from Contact limit 10];
    }
    
    @AuraEnabled
    public static list<contact> searchquery(string searchquery){
        string name = '%'+searchquery+'%';
        
        return[Select Id, Name, Phone From Contact where name LIKE: name limit 10];
    }
    
    @AuraEnabled
    public static contact findbyid(string contactId){
        return [Select Id, Name, Phone, mobilephone, Title, Account.Name From Contact where Id =: contactId];
    }

}
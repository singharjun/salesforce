public with sharing class uploadController {
    public Attachment newAttachment {get;set;}
    public Attachment myString {get;set;}
    public account newApplication{get;set;}
    public uploadController(){
        System.debug('Inside Controller');
    }
    
    public void myTest() {
        System.debug('Inside Action');
    System.debug('VARIABLE myString------' + myString);
  }
    
    public PageReference save(){
        
        newApplication = new Account();
        newApplication.name ='TestAccount';
        insert newApplication ;
        return null;
    }
}
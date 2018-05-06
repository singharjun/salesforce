trigger RaceEntryTrigger on Race_Entry__c (before update,before delete,after undelete) {

    RaceEntryTriggerHelper.RaceEntryIsertMethod(trigger.new);

}
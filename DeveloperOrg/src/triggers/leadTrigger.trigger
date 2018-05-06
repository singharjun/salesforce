trigger leadTrigger on Lead (before insert,before update) {

    List<lead> leadList = new List<lead>();

    for(lead leadObj : trigger.new){
        if(leadObj.company != null && leadObj.company != '')
            leadList.add(leadObj);
    }

    if(!leadList.isEmpty())
    leadTriggerHandler.beforeInsert(leadList);
}
trigger campaignTrigger on Campaign (after update) {

   System.debug('trigger.new>>>'+trigger.new);
    set<id> cId = new Set<Id>();
    for(Campaign c : trigger.new){
        cId.add(c.Id);
    }
    feedCommentController.postfeedComment(cId);
}
trigger feedItemTrigger on Feeditem (after insert) {

   System.debug('Feed item trigger.new>>>'+trigger.new);
    
    //feedCommentController.postfeedComment(trigger.new);
}
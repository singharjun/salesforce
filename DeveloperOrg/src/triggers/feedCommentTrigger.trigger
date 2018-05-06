trigger feedCommentTrigger on FeedComment (after update) {

   
    System.debug('Feed Comment Trigger');
    //feedCommentController.postfeedComment(trigger.new);
}
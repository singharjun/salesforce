trigger opportunityTiggers on Opportunity (After Insert,After Update) {
	System.debug('Inside the Trigger');
	if(Trigger.isUpdate && Trigger.isAfter){
        System.debug('Calling the Method');
        new OpportunityTriggerSequenceController().afterUpdate();
    }

}
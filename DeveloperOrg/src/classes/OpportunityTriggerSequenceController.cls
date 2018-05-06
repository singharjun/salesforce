public class OpportunityTriggerSequenceController{
    
    /**
    * Name: afterInsert
    * @description: To call Business class method for after insert trigger event.
    * @parameter: NA
    * @return: NA
    **/
    public void afterUpdate(){
        System.debug('Calling the Sequence Class');
        OpportunityTriggerOperations.updateTotalPriceOnCampaigns();
        
    }
}
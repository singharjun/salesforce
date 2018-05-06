/*
    Type:       Batch Class <br>
    Purpose:    Apex batch for <complete this> <br>  
<br>
    ---------------------------------------------------------------<br>
    History:<br>
<br>
    dd-MMM-yyyy Dev Name        Created<br>    
*/

global with sharing class RunLocalTestMethodsBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    public String batchJobId ;
          
    public RunLocalTestMethodsBatch(String batchJobId) {
        batchJobId = batchJobId;
     }  
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('start');
        return Database.getQueryLocator('SELECT ID FROM Contact LIMIT 1'); // have to return something - need to look up whether we can run batch job without
    }
    

    global void execute(Database.BatchableContext BC, List<sObject> objectList){
        System.debug('objectList:' + objectList);
         System.debug('batchJobId:::' + batchJobId);
        // check for batchJobId
        //  If we have one then check the status, otherwise kick off the process
        if(batchJobId == null){
            batchJobId = 'xyz';
            System.debug('batchJobId:' + batchJobId);
            if(batchJobId != null){
                // schedule to run again in 10 minutes
                
                // Commenting this code to reschedule same job again                            
                //AutomatedTestingJobSchedular s = new AutomatedTestingJobSchedular();
                /*
                RunLocalTestMethodsScheduler s = new RunLocalTestMethodsScheduler(); 
                String cron = '0 03 * * * ?';
                System.schedule('TestClassSchedular', cron, s);*/

                System.schedule('testClassRunMethod', '0 47 18 * * ?', new Dummy_Schedulable_Class(batchJobId));
                
            }
        }
        else {
            // check the status.
            // if not complete then schedule to check in 10 minutes
            // if it is complete then send an email with the results 
        }
        
        
    }
    
    
    
   
    global void finish(Database.BatchableContext BC){
        
    }
}
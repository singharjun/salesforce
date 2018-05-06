public with sharing class RaceEntryTriggerHelper{

    public static void RaceEntryIsertMethod(list<Race_Entry__c> raceList){
    
        Map<Id,Id> TrackWithSeasonIsMap = new Map<Id,Id>();
        Map<Id,aura_beginner__Track__c> TrackRecordMap = new Map<Id,aura_beginner__Track__c>();
        Map<Id,aura_beginner__Season__c> SeasonRecordMap = new Map<Id,aura_beginner__Season__c>();
        List<aura_beginner__Season__c> seasonList = new List<aura_beginner__Season__c>();
        for(Race_Entry__c raceEntry :raceList){
            TrackWithSeasonIsMap.put(raceEntry.aura_beginner__Season__c, raceEntry.aura_beginner__Track__c);
        }
        
        for(aura_beginner__Track__c trackRecord : [Select Id ,aura_beginner__Difficulty__c from aura_beginner__Track__c where Id IN : TrackWithSeasonIsMap.values()]){
            TrackRecordMap.put(trackRecord.Id,trackRecord);
            
        }
        
        for(aura_beginner__Season__c seasonRecord : [Select Id ,aura_beginner__Primary_Difficulty_Level__c from aura_beginner__Season__c where Id IN : TrackWithSeasonIsMap.keySet()]){
            
            SeasonRecordMap.put(seasonRecord.Id,seasonRecord);
        }
        
        for(Id seasonId : SeasonRecordMap.keySet()){
            
            
            if(TrackWithSeasonIsMap.containsKey(seasonId)){
                Id TrackId = TrackWithSeasonIsMap.get(seasonId);
                
                if(TrackRecordMap.containsKey(TrackId)){
                    aura_beginner__Track__c trackInstance = TrackRecordMap.get(TrackId);
                    aura_beginner__Season__c seasonInstance = SeasonRecordMap.get(seasonId);
                    
                    seasonInstance.aura_beginner__Primary_Difficulty_Level__c = trackInstance.aura_beginner__Difficulty__c ;
                    seasonList.add(seasonInstance);
                }
            }
            
        }
        
        if(!seasonList.isEmpty())
            database.update(seasonList, false);
        
    }
}
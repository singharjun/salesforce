/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class EventbriteOrderSyncBatch implements Database.AllowsCallouts, Database.Batchable<Integer>, Database.Stateful, System.HttpCalloutMock {
    global EventbriteOrderSyncBatch(Boolean isSingleEvent, String eventId) {

    }
    global EventbriteOrderSyncBatch(Boolean isSingleEvent, String eventId, Set<String> ebIds) {

    }
    global void execute(Database.BatchableContext info, List<Integer> scope) {

    }
    global void finish(Database.BatchableContext info) {

    }
    global static Integer getExecutesNeeded(String singleEventId) {
        return null;
    }
    global static Integer getOrdersFromEventbriteCount(String singleEventId) {
        return null;
    }
    global System.Iterable start(Database.BatchableContext info) {
        return null;
    }
    global Id startBatch() {
        return null;
    }
}

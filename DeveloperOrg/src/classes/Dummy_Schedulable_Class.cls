global class Dummy_Schedulable_Class implements Schedulable{

global String methodName;

global void execute(SchedulableContext SC) {
    if(methodName=='xyz'){
        //testScheduleClassMethod1();
        
        System.debug('Yes Coming here');
    }else{
        testScheduleClassMethod2();
    }
}

public void testScheduleClassMethod1(){
    //TO DO
}
public void testScheduleClassMethod2(){
    //TO DO
}
public Dummy_Schedulable_Class ( String mName) {
    methodName = mName;
}
}
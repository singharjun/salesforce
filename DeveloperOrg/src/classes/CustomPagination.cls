public class CustomPagination {
    
    //List to store all the contacts according to requirement
    public List<aura_beginner__Consumption_Charges__b> AllConsumption = new list<aura_beginner__Consumption_Charges__b>();
    
    //List to show the limited records on the page
    public List<aura_beginner__Consumption_Charges__b> ConsumptionsToShow{get;set;}
    
    //Navigation variables
    Integer counter = 0;//TO track the number of records parsed
    Integer limitSize = 10;//Number of records to be displayed
    Integer totalSize =0; //To Store the total number of records available
    
    //Constructor
    public CustomPagination(){
        
         ConsumptionsToShow = new list<aura_beginner__Consumption_Charges__b>();
        
        //Get all the contacts which are from Public realations lead source
        AllConsumption = [SELECT aura_beginner__Billing_Account__c,aura_beginner__Billing_Account__r.name, aura_beginner__Billing_Frequency__c, aura_beginner__Status__c FROM aura_beginner__Consumption_Charges__b limit 2];
        //Store the total size
        totalSize = AllConsumption.size();
        
        //Intial adding of contacts to ConsumptionsToShow
        //check the total records are more than limitSize and assign the records
        if((counter+limitSize) <= totalSize){
            for(Integer i=0;i<limitSize;i++){
                ConsumptionsToShow.add(AllConsumption.get(i));
            }
        }else{
            for(Integer i=0;i<totalSize;i++){
                ConsumptionsToShow.add(AllConsumption.get(i));
            }
        }
        
    }
    
    //Navigation methods
    
    
    public void beginning(){
   
        ConsumptionsToShow.clear();
        counter=0;
        if((counter + limitSize) <= totalSize){
       
            for(Integer i=0;i<limitSize;i++){
                ConsumptionsToShow.add(AllConsumption.get(i));
            }   
           
        } else{
       
            for(Integer i=0;i<totalSize;i++){
                ConsumptionsToShow.add(AllConsumption.get(i));
            }       
           
        }
       
    }
   
    public void next(){
   
        ConsumptionsToShow.clear();
        counter=counter+limitSize;
       
        if((counter+limitSize) <= totalSize){
            for(Integer i=counter-1;i<(counter+limitSize);i++){
                ConsumptionsToShow.add(AllConsumption.get(i));
            }
        } else{
            for(Integer i=counter;i<totalSize;i++){
                ConsumptionsToShow.add(AllConsumption.get(i));
            }
        }
    }
   
    public void previous(){
   
        ConsumptionsToShow.clear();

        counter=counter-limitSize;       
       
        for(Integer i=counter;i<(counter+limitSize); i++){
            ConsumptionsToShow.add(AllConsumption.get(i));
        }
    }

    public void last (){
   
        ConsumptionsToShow.clear();
       
        if(math.mod(totalSize , limitSize) == 0){
            counter = limitSize * ((totalSize/limitSize)-1);
        } else if (math.mod(totalSize , limitSize) != 0){
            counter = limitSize * ((totalSize/limitSize));
        }
       
        for(Integer i=counter-1;i<totalSize-1;i++){
                ConsumptionsToShow.add(AllConsumption.get(i));
        }
       
    }
   
    public Boolean getDisableNext(){
   
        if((counter + limitSize) >= totalSize )
            return true ;
        else
            return false ;
    }
   
    public Boolean getDisablePrevious(){
   
        if(counter == 0)
            return true ;
        else
            return false ;
    } 
}
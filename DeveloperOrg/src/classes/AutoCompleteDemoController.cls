public class AutoCompleteDemoController{
    public list<contact> getcontactList(){
        return [select id,name from contact limit 25];
    }
}
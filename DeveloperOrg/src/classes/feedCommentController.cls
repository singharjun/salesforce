public class feedCommentController{
    
    @future
    public static void postfeedComment(Set<Id> flist){
        
       /* set<id> campaignSetId = new Set<id>();
        for(Feeditem fc :flist ){
            if(fc.type == 'TrackedChange'){
                campaignSetId.add(fc.parentId);
            }
        }*/
        
        Map<Id,string> campaignWithNameMap = new Map<Id,String>();      
        
        for(Campaign camp : [Select id , name from Campaign where id IN : flist]){
            campaignWithNameMap.put(camp.Id, camp.name);
        }
        
        
        List<String> feedString =new  List<String>();
        Map<id,CampaignFeed> campaignWithFeedList = new Map<id,CampaignFeed>();
        //System.debug('campaignSetId>>>'+campaignSetId);
        for(CampaignFeed objFeed : [SELECT Id,Body,CommentCount,ParentId,createdDate,
                                  (SELECT Id,
                                          FieldName,
                                          OldValue,
                                          NewValue
                                   FROM FeedTrackedChanges )
                           FROM CampaignFeed
                           WHERE Type = 'TrackedChange' and ParentId IN : campaignWithNameMap.keySet() order by createdDate desc ])
{ 
    System.debug('objFeed.createdDate >>> '+objFeed.createdDate);
    System.debug('objFeed.Id >>> '+objFeed.Id);
    for(FeedTrackedChange fd :objFeed.FeedTrackedChanges ){
        System.debug('fd >>> '+fd.id);
        //System.debug('fd >>> '+fd.createdDate);
        System.debug('CurrentOldValue >>> '+fd.OldValue);
        System.debug('CurrentNewValue >>> '+fd.NewValue);
        System.debug('CurrentFieldName >>> '+fd.FieldName);
        
        //string str = 'Changed ' + fd.FieldName.substringAfter('.') + ' from ' + fd.OldValue + ' to' + fd.NewValue ;
        
        //feedString.add(str);
    }
    
    if(!campaignWithFeedList.containsKey(objFeed.ParentId)){        
        campaignWithFeedList.put(objFeed.ParentId,objFeed);
        
    }
    
    /*   
   System.debug('feedString>>>'+ feedString);
   
   FeedItem post = new FeedItem();
   
   post.ParentId = '0F90I000000byXe';
   post.Body =feedString[0];
   
   system.debug('post>>>>'+ post);
   
   insert post;*/
}
System.debug('campaignWithFeedList>>>>'+campaignWithFeedList);
    list<FeedItem> feedItemList = new list<FeedItem>();
    for(id campParentId : campaignWithFeedList.keySet()){
        
        CampaignFeed campFeed = campaignWithFeedList.get(campParentId);
        
        String CampName ;
        System.debug('Inside Outer Loop');
        
        Boolean campaignLoop = false;
        if(campaignWithNameMap.containsKey(campParentId)){
            CampName = campaignWithNameMap.get(campParentId);
            integer i = 0 ;
            
            for(FeedTrackedChange fd :campFeed.FeedTrackedChanges ){
                System.debug('campFeed>>>>'+campFeed);
                System.debug('Loop Number');
                System.debug('fd >>> '+fd.id);
                System.debug('fd.OldValue >>> '+fd.OldValue);
                System.debug('fd.NewValue >>> '+fd.NewValue);
                System.debug('fd.FieldName >>> '+fd.FieldName);
                System.debug('i>><<<<'+ i);
                if(i < 1){
                    System.debug('i>>>'+ i) ;
                    string str = 'For ' + CampName +  ' Changed ' + fd.FieldName.substringAfter('.') + ' from ' + fd.OldValue + ' to ' + fd.NewValue  ;
                    
                    FeedItem post = new FeedItem();
       
                    post.ParentId = '0F90I000000byXe';
                    post.Body =str;
                    feedItemList.add(post);
                    
                    i = 1  ;
                    
                    System.debug('iAfterChange'+i);
                }
                
            }   
            
        }
        
    }
    
    System.debug('feedItemList>>>>'+feedItemList);
    
    if(!feedItemList.isEmpty()){
        insert feedItemList ;
    }

        
    }
}
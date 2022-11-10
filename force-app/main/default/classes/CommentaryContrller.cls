public with sharing class CommentaryContrller {
    @AuraEnabled
    public static Commentary__c saveNewCommentary(String commentId, String comment, Decimal rating, String productId){
        
        Commentary__c newObject = 
        commentId == ''? new Commentary__c() : 
        new Commentary__c(
            Id = commentId
        );
      
        newObject.Commentary__c = comment;
        newObject.rating__c = rating;
        newObject.Product__c = productId;
        newObject.Approval__c = false;
        
        upsert newObject;
        return newObject;
    }

    @AuraEnabled(cacheable=true)
    public static List<Commentary__c> getCommentList(String productId){
        List<Commentary__c> productComment = [SELECT Id, OwnerId, Name, CreatedById, LastModifiedDate, Product__c,
         CreatedBy.Name, rating__c, Commentary__c, Approval__c
        FROM Commentary__c Where Product__c = :productId];
        return productComment;
    }
}

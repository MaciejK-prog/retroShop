public with sharing class PhotoUploadController {

        @AuraEnabled
        public static void addMainPhoto(Id productId, Id photoId) {

            Product2 productTobeUpdated = new Product2(Id = productId, Main_Photo__c = photoId);

            update productTobeUpdated;

        }
}

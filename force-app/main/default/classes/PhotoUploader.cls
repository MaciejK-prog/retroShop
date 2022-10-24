public with sharing class PhotoUploader {

    @AuraEnabled
    public static List<ContentDocumentLink> getIdsOfDocumentContentVersion(String productId) {


        List<ContentDocumentLink> contentVersionOfUploadedPhotos = [SELECT ContentDocument.LatestPublishedVersionId 
                                                                    FROM ContentDocumentLink 
                                                                    WHERE LinkedEntityId =: productId];



        return contentVersionOfUploadedPhotos;

    }

    @AuraEnabled
    public static void deletePhoto(String productId, String productToDelete) {



        ContentVersion photoToDelte = [SELECT ContentDocumentId
                                    FROM ContentVersion
                                    WHERE Id =: productToDelete];



        delete New ContentDocument(id=photoToDelte.ContentDocumentId);

    }

    

    @AuraEnabled
    public static void setPhotoAsMain(Id idOfPRoduct, String idOfPhoto){
        try { 

            Product2 productToUpdate = [SELECT Id, Main_Photo__c
                                            FROM Product2
                                            WHERE Id =: idOfPRoduct ];

            productToUpdate.Main_Photo__c = idOfPhoto;

            upsert productToUpdate;

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Product2 getProduct(Id idOfPRoduct){
        try {

            Product2 productToDisplay = [SELECT Id, Main_Photo__c
                                           FROM Product2
                                        WHERE Id=: idOfPRoduct ];

            return productToDisplay;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

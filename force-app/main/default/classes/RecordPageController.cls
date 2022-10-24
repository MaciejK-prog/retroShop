public with sharing class RecordPageController {
    
    @AuraEnabled(cacheable=true)
    public static ProductService.Product recieveRecordData(Id recordIdToDisplay) {
        try {


            
            PricebookEntry pricebookEntryOfProduct = [SELECT Id, UnitPrice, Product2Id, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
                                                     FROM PricebookEntry
                                                     WHERE Product2.Id =: recordIdToDisplay AND Pricebook2.IsStandard = TRUE];
 

            ProductService.Product wrapperToDisplay = new ProductService.Product(pricebookEntryOfProduct);



            return wrapperToDisplay;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled(cacheable=true)
    public static List<ContentDocumentLink> getIdsOfDocumentContentVersion(String productId) {


        List<ContentDocumentLink> contentVersionOfUploadedPhotos = [SELECT ContentDocument.LatestPublishedVersionId 
                                                                    FROM ContentDocumentLink 
                                                                    WHERE LinkedEntityId =: productId];



        return contentVersionOfUploadedPhotos;

    }

    @AuraEnabled(cacheable=true)
    public static List<Auction__c> checkIfProductIsOnAuction(Id idOfProduct){
        try {

            System.debug(idOfProduct);

        List <Auction__c> auctionToBeChecked = [SELECT End_Date__c, Start_Date__c, Start_Price__c, Status__c, UserId__c
                                                FROM Auction__c
                                                WHERE Product__c =: idOfProduct];

        System.debug(auctionToBeChecked);

        return auctionToBeChecked;

                
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void updatePriceAfterAuction(Id idOfProduct, Decimal newPrice, Id idOfUser){
        try {
        
            PricebookEntry pricebookEntryOfProductToPriceChange = [SELECT Id, UnitPrice, Product2Id, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
                                                                  FROM PricebookEntry
                                                                  WHERE Product2.Id =: idOfProduct AND Pricebook2.IsStandard = TRUE];

            Auction__c auctionToBeUpdated = [SELECT Id
                                            FROM Auction__c
                                            WHERE Product__c =: idOfUser];

        pricebookEntryOfProductToPriceChange.UnitPrice = newPrice;

        auctionToBeUpdated.UserId__c = idOfUser;

        update auctionToBeUpdated;

        update pricebookEntryOfProductToPriceChange;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

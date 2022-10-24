public with sharing class DiscountManagerCalculatorController {

    @AuraEnabled
    public static List<ProductSaveResult> createNewEntries(String selectedProductsString, Double discountValue, String discountType, String pricebookType, Datetime endDate, Datetime startDate){


        try {

            List<DiscountManagerController.ProductWrapper> selectedProducts = (List<DiscountManagerController.ProductWrapper>) JSON.deserialize(selectedProductsString, List<DiscountManagerController.ProductWrapper>.class);

            List<PricebookEntry> pricebookEntriesToInsert = new List<PricebookEntry>();

                 Pricebook2 selectedPriceBook =  [SELECT Id, (SELECT Id, Product2Id FROM PricebookEntries)
                                    FROM Pricebook2 
                                    WHERE Name =: pricebookType LIMIT 1];


                Map<Id, PricebookEntry> pricebookEntryByProductId = new Map<Id, PricebookEntry>();

                for(PricebookEntry pbe : selectedPriceBook.PricebookEntries) {
                    pricebookEntryByProductId.put(pbe.Product2Id, pbe);
                }

                 List<String> productIdsToCheck = new List<String>();

                List<ProductSaveResult> entriesToReject = new List<ProductSaveResult>();
                List<ProductSaveResult> acceptedEntries = new List<ProductSaveResult>();
                 
            for(DiscountManagerController.ProductWrapper productToProcess : selectedProducts) {

                if( discountType == 'precentage' && discountValue <= 100) {
                        
                pricebookEntriesToInsert.add(pricebookEntryInsert(productToProcess.id, selectedPriceBook.Id, productToProcess.productCode,
                countPrecentageDiscount(productToProcess.price, discountValue), startDate,  endDate));

                ProductSaveResult succesResult = new ProductSaveResult();
                succesResult.isSucces = true;
                succesResult.productId = productToProcess.id;
                succesResult.errorMessage = '';

                acceptedEntries.add(succesResult);

                } else if (discountType == 'currency' && countCurrencyDiscount(productToProcess.price, discountValue) >= 0) {

                pricebookEntriesToInsert.add(pricebookEntryInsert(productToProcess.id, selectedPriceBook.Id, productToProcess.productCode,
                countCurrencyDiscount(productToProcess.price, discountValue), startDate,  endDate));

                ProductSaveResult succesResult = new ProductSaveResult();
                succesResult.isSucces = true;
                succesResult.productId = productToProcess.id;
                succesResult.errorMessage = '';

                acceptedEntries.add(succesResult);

                } else {

                    ProductSaveResult rejectedResult = new ProductSaveResult();
                    rejectedResult.isSucces = false;
                    rejectedResult.productId = productToProcess.id;
                    rejectedResult.errorMessage = Label.Invalid_Discount;

                    entriesToReject.add(rejectedResult);
                }

            }

            List <ProductSaveResult> allResultsList = new List<ProductSaveResult>();

            allResultsList.addAll(entriesToReject);
            allResultsList.addAll(acceptedEntries);

            
            for(PricebookEntry pricebookCheck : pricebookEntriesToInsert) {
               if(pricebookEntryByProductId.containsKey(pricebookCheck.Product2Id)) {
                pricebookCheck.Id = pricebookEntryByProductId.get(pricebookCheck.Product2Id).Id;
               }
            }

            upsert pricebookEntriesToInsert;

            return allResultsList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    

    @AuraEnabled
    public static Decimal countPrecentageDiscount(Decimal productValue, Double discountValue){
        try {

            Decimal precentageDiscountValue = 1 - (discountValue/100);

            Decimal valueAfterDiscount = productValue * precentageDiscountValue;

            return valueAfterDiscount;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Decimal countCurrencyDiscount(Decimal productValue, Double discountValue) {
        try {

            Decimal valueAfterDiscount = productValue - discountValue;

            return valueAfterDiscount;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Pricebook2> getPricebookList(){
    
        try {
            List<Pricebook2> getPricebooks = [SELECT Id, Name
                                            FROM Pricebook2
                                            WHERE Discount_Manager__c = true];

            return getPricebooks;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static PricebookEntry pricebookEntryInsert(String productId, String pricebookId, String productCode, Decimal price, Datetime startDate, Datetime endDate){
        try {

            PricebookEntry pricebookEntry = new PricebookEntry();
            pricebookEntry.Product2Id = productId;
            pricebookEntry.Pricebook2Id = pricebookId;
            pricebookEntry.UnitPrice = price;
            pricebookEntry.isActive = true;
            pricebookEntry.EndDate__c = endDate;
            pricebookEntry.Start_Date__c = startDate;
            pricebookEntry.UseStandardPrice  = false;

            return pricebookEntry;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class ProductSaveResult {
        @AuraEnabled
        public Boolean isSucces;
        @AuraEnabled
        public String productId;
        @AuraEnabled
        public String errorMessage;

    }
}

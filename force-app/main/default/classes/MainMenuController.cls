public with sharing class MainMenuController {


    @AuraEnabled(cacheable = true)
    public static List<ProductService.Product> searchHotDealsProducts(){
        try {

            List<PricebookEntry> pricebookEntries = [SELECT Id, UnitPrice, Product2Id, Product2.Description, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
                                                    FROM PricebookEntry
                                                    WHERE Product2.Status__c = 'Hot Deal'
                                                    AND (Pricebook2.Name = 'Hot Deals Price Book' OR Pricebook2.IsStandard = TRUE)];

            Map<Id,ProductService.Product> product = new Map<Id, ProductService.Product> ();

            for(PricebookEntry entryToMap : pricebookEntries) {

                if(product.containsKey(entryToMap.Product2Id)){
                    ProductService.Product newProduct = product.get(entryToMap.Product2Id);

                    if(entryToMap.Pricebook2.IsStandard) {
                        newProduct.price = entryToMap.UnitPrice;
                    } else {
                        newProduct.discountedPrice = entryToMap.UnitPrice;
                    }


                } else {
                    ProductService.Product productToMap = new ProductService.Product(entryToMap);
                    product.put(entryToMap.Product2Id, productToMap);
                }
                

            }


            return product.values();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled(cacheable = true)
    public static List<ProductService.Product> searchSalesProducts(){
        try {

            
            List<PricebookEntry> pricebookEntries = [SELECT Id, UnitPrice, Product2Id, Product2.Main_Photo__c, Product2.Custom_Description__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
                                                    FROM PricebookEntry
                                                    WHERE Product2.Status__c = 'Sale'
                                                    AND (Pricebook2.Name = 'Sale Price Book' OR Pricebook2.IsStandard = TRUE)];
            
     Map<Id,ProductService.Product> product = new Map<Id, ProductService.Product> ();

        for(PricebookEntry entryToMap : pricebookEntries) {
                                        
            if(product.containsKey(entryToMap.Product2Id)){
                ProductService.Product newProduct = product.get(entryToMap.Product2Id);
                                        
                if(entryToMap.Pricebook2.IsStandard) {
                    newProduct.price = entryToMap.UnitPrice;
                } else {
                    newProduct.discountedPrice = entryToMap.UnitPrice;
                }
            
                                        
                                        
            } else {
                ProductService.Product productToMap = new ProductService.Product(entryToMap);
                product.put(entryToMap.Product2Id, productToMap);
            }
        }


        return product.values();
            
        } catch (Exception e) {

            throw new AuraHandledException(e.getMessage());
        }
    
}
}

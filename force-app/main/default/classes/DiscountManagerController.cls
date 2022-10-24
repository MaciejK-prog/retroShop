public with sharing class DiscountManagerController {


    @AuraEnabled
    public static List<ProductWrapper> getProducts(){
        try {

            List<Product2> allProducts = [SELECT Id, Name, Family, ProductCode, Description, QuantityUnitOfMeasure FROM Product2 WHERE isActive = true ];


            

            Map<Id, PricebookEntry> pricebookEntryByProductId = getStandardPricebookEntriesByProductsIds();


            List<ProductWrapper> listOfWrappers = new List<ProductWrapper>();
            for(Product2 product : allProducts) {

                if(pricebookEntryByProductId.containsKey(product.id)) {
                ProductWrapper productWrapper = new ProductWrapper(product).setStandardPrice(pricebookEntryByProductId.get(product.Id).UnitPrice);
                listOfWrappers.add(productWrapper);
                }
            }

            return listOfWrappers;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static Map<Id, PricebookEntry> getStandardPricebookEntriesByProductsIds() {
        List<PricebookEntry> allPricebookEntries = [SELECT Pricebook2Id, Product2Id, ProductCode, UseStandardPrice, UnitPrice
                                             FROM PricebookEntry WHERE Pricebook2.IsStandard = true AND isActive = true];


        Map<Id, PricebookEntry> pricebookEntryByProductId = new Map<Id, PricebookEntry>();
        for (PricebookEntry pbe : allPricebookEntries) {
            pricebookEntryByProductId.put(pbe.Product2Id, pbe);
        }

        return pricebookEntryByProductId;
    }

        
    public class ProductWrapper {
        @AuraEnabled
        public String name;
        @AuraEnabled
        public String description;
        @AuraEnabled
        public String family;
        @AuraEnabled
        public String productCode;
        @AuraEnabled
        public Decimal price;
        @AuraEnabled
        public Id id;

        public ProductWrapper(){ 
            
        }

        public ProductWrapper(Product2 product) {

            this.name = product.Name;
            this.family = product.Family;
            this.productCode = product.ProductCode;
            this.description = product.Description;
            this.id = product.Id;
        }

        public ProductWrapper setStandardPrice(Decimal unitPrice) {
            this.price = unitPrice;
            return this;
        }
    
}
}

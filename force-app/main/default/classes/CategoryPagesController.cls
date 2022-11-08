public with sharing class CategoryPagesController {


    @AuraEnabled(cacheable = true)
    public static List<ProductService.Product> getConsoleCategoryProducts(){
        try {

            List<PricebookEntry> pricebookEntries = [SELECT Id, UnitPrice, Product2Id, Product2.Description, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
            FROM PricebookEntry
            WHERE Product2.Family = 'Console'];

            List<ProductService.Product> listOfConsoles = new List<ProductService.Product>();

            

            for(PricebookEntry entries : pricebookEntries) {
                ProductService.Product productToDisplay = new ProductService.Product(entries);
                listOfConsoles.add(productToDisplay);
            }

            return listOfConsoles;
            
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable = true)
    public static List<ProductService.Product> getToysCategoryProducts(){
        try {

            List<PricebookEntry> pricebookEntries = [SELECT Id, UnitPrice, Product2Id, Product2.Description, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
            FROM PricebookEntry
            WHERE Product2.Family = 'Toy'];

            List<ProductService.Product> listOfToys = new List<ProductService.Product>();

            for(PricebookEntry entries : pricebookEntries) {
                ProductService.Product productToDisplay = new ProductService.Product(entries);
                listOfToys.add(productToDisplay);
            }

            return listOfToys;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable = true)
    public static List<ProductService.Product> getAccesoriesCategoryProducts(){
        try {

            List<PricebookEntry> pricebookEntries = [SELECT Id, UnitPrice, Product2Id, Product2.Description, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
            FROM PricebookEntry
            WHERE Product2.Family = 'Accesories' OR Product2.Family = 'Jewelry'];

            List<ProductService.Product> listOfAccesories = new List<ProductService.Product>();

            for(PricebookEntry entries : pricebookEntries) {
                ProductService.Product productToDisplay = new ProductService.Product(entries);
                listOfAccesories.add(productToDisplay);
            }

            return listOfAccesories;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable = true)
    public static List<ProductService.Product> getPhonesCategoryProducts(){
        try {

            List<PricebookEntry> pricebookEntries = [SELECT Id, UnitPrice, Product2Id, Product2.Description, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
            FROM PricebookEntry
            WHERE Product2.Family = 'Phone'];

            List<ProductService.Product> listOfPhones = new List<ProductService.Product>();

            for(PricebookEntry entries : pricebookEntries) {
                ProductService.Product productToDisplay = new ProductService.Product(entries);
                listOfPhones.add(productToDisplay);
            }

            return listOfPhones;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

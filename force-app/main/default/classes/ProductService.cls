public with sharing class ProductService {

    public class Product {
        @AuraEnabled
        public String id;
        @AuraEnabled
        public String name;
        @AuraEnabled
        public String category;
        @AuraEnabled
        public double price;
        @AuraEnabled
        public double discountedPrice;
        @AuraEnabled
        public String status;
        @AuraEnabled
        public String image;
        @AuraEnabled
        public String description;
        @AuraEnabled
        public String providedCurrency;

        @AuraEnabled
        public Id pricebookEntryId;

        public Product(PricebookEntry entryOfProduct) {
            this.pricebookEntryId = entryOfProduct.Id;
            this.id = entryOfProduct.Product2.Id;
            this.name = entryOfProduct.Product2.Name;
            this.category = entryOfProduct.Product2.Family;
            this.price = entryOfProduct.UnitPrice;
            this.discountedPrice = entryOfProduct.UnitPrice;
            this.status = entryOfProduct.Product2.Status__c;
            this.image = entryOfProduct.Product2.Main_Photo__c;
            this.description = entryOfProduct.Product2.Custom_Description__c;
            this.providedCurrency = entryOfProduct.CurrencyIsoCode;
        }

        public OrderItem getOrderItem(Id orderId) {
            return new OrderItem(
                PricebookEntryId = this.pricebookEntryId,
                OrderId = orderId,
                Product2Id = this.id,
                UnitPrice = this.price,
                Quantity = 1
            );
        }
}
}

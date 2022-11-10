public with sharing class cartController {
    
    @AuraEnabled(cacheable=true)
    public static List<ProductService.Product> getProducts(List<String> productIds) {

        
        List<PricebookEntry> productsEntries = [SELECT Id, UnitPrice, CurrencyIsoCode, Product2Id, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
                                        FROM PricebookEntry
                                        WHERE Product2.Id IN :productIds AND Pricebook2.IsStandard = TRUE];
        List<ProductService.Product> productsInCart = new List<ProductService.Product>();


        for(PricebookEntry entriesToWrap : productsEntries) {
            ProductService.Product productWrapper  = new ProductService.Product(entriesToWrap);
            productsInCart.add(productWrapper);
        }

        System.debug('products in cart' + productsInCart);

        return productsInCart;

    }

    @AuraEnabled
    public static OrderWrapper getOrder(Id orderId){
        try {
            Order order = [SELECT Id, Status, EffectiveDate, OrderNumber FROM Order WHERE Id = :orderId];

            OrderItem[] orderItems = [SELECT Id, Product2Id, Product2.Name, Product2.Main_Photo__c, (SELECT Id FROM Cases__r) FROM OrderItem WHERE OrderId = :orderId];
    
            return new OrderWrapper(order, orderItems);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class OrderWrapper {
        @AuraEnabled
        public Order data;
        @AuraEnabled
        public OrderItem[] OrderItems;

        public OrderWrapper(Order order, OrderItem[] orderItems) {
            this.data = order;
            this.OrderItems = orderItems;
        }
    }

    @AuraEnabled
    public static Case recieveCaseBody(Id caseId){
        try {


            System.debug(caseId);
            
            Case caseToDisplay = [SELECT Subject, Description, Status
                                FROM Case
                                WHERE Id =: caseId ];

        System.debug(caseToDisplay);

        return caseToDisplay;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Id saveOrderDetails(String orderDetailJson){
        try {

            OrderDetail orderDetail = (cartController.OrderDetail) JSON.deserialize(orderDetailJson, OrderDetail.class);

            System.debug(orderDetail);

            Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE IsStandard = TRUE];
            Order order = orderDetail.data.getOrder();
            order.Pricebook2Id = pb.Id;
            insert order;
            
            OrderItem[] orderItems = new OrderItem[]{};
            for (ProductService.Product item : orderDetail.items) {
                orderItems.add(item.getOrderItem(order.Id));
            }

            insert orderItems;

            return order.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Case createACase(String subject, String reason, Id idOfProduct, Id idOfOrderItem){
        try {

            System.debug(idOfProduct);

            Case caseToCreate = new Case(Subject = subject,
                                         Description = reason,
                                         ProductId = idOfProduct,
                                         Order_Product__c = idOfOrderItem,
                                         Origin = 'Web',
                                         Status = 'New');

            insert caseToCreate;

            return caseToCreate;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class OrderDetail {
        @AuraEnabled
        public OrderData data;
        @AuraEnabled
        public ProductService.Product[] items;
    }

    public class OrderData {
        public String BillingCountry;
        public String BillingCity;
        public String TotalAmount;

        public Order getOrder() {
            User loggedUser = [SELECT Id, Contact.AccountId
                                FROM User 
                                WHERE Id =: UserInfo.getUserId()];
            System.debug(loggedUser.Contact.AccountId);
             
            return new Order(
                AccountId = loggedUser.Contact.AccountId,
                EffectiveDate = Date.today(),
                Status = 'Draft',
                BillingCountry = this.BillingCountry,
                BillingCity = this.BillingCity
            );

           
        }
    }

}

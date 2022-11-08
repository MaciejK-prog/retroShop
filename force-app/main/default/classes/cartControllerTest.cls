
@IsTest
public with sharing class cartControllerTest {


    @TestSetup
    static void prepareData(){

        Account accountForTest = new Account();
        accountForTest.Name = 'test';

        insert accountForTest;

        Product2 productForTest = new Product2();
        productForTest.Name = 'test';
        productForTest.ProductCode ='1234';
        productForTest.Family ='Phone';
        productForTest.Status__c ='Normal';
        productForTest.IsActive = true;

        insert productForTest;


        Product2 productForTestBatch = new Product2();
        productForTestBatch.Name = 'test33';
        productForTestBatch.ProductCode ='1234';
        productForTestBatch.Family ='Accesories';
        productForTestBatch.Status__c ='Normal';
        productForTestBatch.IsActive = true;

        insert productForTestBatch;

        Product2 productForTestFalse = new Product2();
        productForTestFalse.Name = 'test2';
        productForTestFalse.ProductCode = null;
        productForTestFalse.Family ='Toy';
        productForTestFalse.Status__c =null;
        productForTestFalse.IsActive = false;

        insert productForTestFalse;

        Product2 productForTestHotDeal = new Product2();
        productForTestHotDeal.Name = 'test3';
        productForTestHotDeal.ProductCode ='1234';
        productForTestHotDeal.Family ='Toy';
        productForTestHotDeal.Status__c ='Hot Deal';
        productForTestHotDeal.IsActive = true;

        insert productForTestHotDeal;

        Product2 productForTestSale = new Product2();
        productForTestSale.Name = 'test4';
        productForTestSale.ProductCode ='1234';
        productForTestSale.Family ='Console';
        productForTestSale.Status__c ='Sale';
        productForTestSale.IsActive = true;

        insert productForTestSale;

        

        Id pricebookId = Test.getStandardPricebookId();

        Pricebook2 standardPricebook = new Pricebook2();
        standardPricebook.Id = Test.getStandardPricebookId();
        standardPricebook.IsActive = true;

        update standardPricebook;


        
        PricebookEntry standardForTestBatch = new PricebookEntry();
        standardForTestBatch.Product2Id = productForTestBatch.Id;
        standardForTestBatch.Pricebook2Id = standardPricebook.Id;
        standardForTestBatch.IsActive = true;
        standardForTestBatch.CurrencyIsoCode = 'EUR';
        standardForTestBatch.UnitPrice = 10.00;
        standardForTestBatch.IsActive = true;
        standardForTestBatch.EndDate__c = Date.today() - 1;

    
        insert standardForTestBatch;


        PricebookEntry standardForTest = new PricebookEntry();
        standardForTest.Product2Id = productForTest.Id;
        standardForTest.Pricebook2Id = standardPricebook.Id;
        standardForTest.IsActive = true;
        standardForTest.CurrencyIsoCode = 'EUR';
        standardForTest.UnitPrice = 10.00;
        standardForTest.IsActive = true;
    
        insert standardForTest;

        Pricebook2 pricebookForTest = new Pricebook2();
        pricebookForTest.Name = 'test';
        pricebookForTest.IsActive = true;

        insert pricebookForTest;

        PricebookEntry entryForTest = new PricebookEntry();
        entryForTest.Product2Id = productForTest.Id;
        entryForTest.Pricebook2Id =  pricebookForTest.Id;
        entryForTest.IsActive = true;
        entryForTest.CurrencyIsoCode = 'EUR';
        entryForTest.UnitPrice = 11.00;
    
        insert entryForTest;

        PricebookEntry entryForTestUSD = new PricebookEntry();
        entryForTestUSD.Product2Id = productForTestSale.Id;
        entryForTestUSD.Pricebook2Id =  standardPricebook.Id;
        entryForTestUSD.IsActive = true;
        entryForTestUSD.CurrencyIsoCode = 'USD';
        entryForTestUSD.UnitPrice = 11.00;
        standardForTest.IsActive = true;
    

        insert entryForTestUSD;

        PricebookEntry entryForTestPLN = new PricebookEntry();
        entryForTestPLN.Product2Id = productForTestHotDeal.Id;
        entryForTestPLN.Pricebook2Id =  standardPricebook.Id;
        entryForTestPLN.IsActive = true;
        entryForTestPLN.CurrencyIsoCode = 'PLN';
        entryForTestPLN.UnitPrice = 11.00;
        standardForTest.IsActive = true;

        insert entryForTestPLN;

        PricebookEntry entryForTestPLN2 = new PricebookEntry();
        entryForTestPLN2.Product2Id = productForTestSale.Id;
        entryForTestPLN2.Pricebook2Id =  pricebookForTest.Id;
        entryForTestPLN2.IsActive = true;
        entryForTestPLN2.CurrencyIsoCode = 'USD';
        entryForTestPLN2.UnitPrice = 11.00;

        insert entryForTestPLN2;

        PricebookEntry entryForTestUSD2 = new PricebookEntry();
        entryForTestUSD2.Product2Id = productForTestHotDeal.Id;
        entryForTestUSD2.Pricebook2Id =  pricebookForTest.Id;
        entryForTestUSD2.IsActive = true;
        entryForTestUSD2.CurrencyIsoCode = 'PLN';
        entryForTestUSD2.UnitPrice = 11.00;
    

        insert entryForTestUSD2;


        Auction__c auctionForTest = new Auction__c();
        auctionForTest.Product__c = productForTest.Id;
        auctionForTest.Status__c = true;
        auctionForTest.End_Date__c = date.today();
        auctionForTest.Start_Date__c = date.today();
        auctionForTest.Start_Price__c = 10.00;

        insert auctionForTest;

        Order orderForTest = new Order();
        orderForTest.Pricebook2Id = pricebookForTest.Id;
        orderForTest.Name = 'test';
        orderForTest.AccountId = accountForTest.Id;
        orderForTest.Status = 'Draft';
        orderForTest.EffectiveDate = Date.today();
        orderForTest.CurrencyIsoCode = 'EUR';


        insert orderForTest;


        Order orderForTestFalse = new Order();
        orderForTestFalse.Pricebook2Id = pricebookForTest.Id;
        orderForTestFalse.Name = 'test2';
        orderForTestFalse.AccountId = accountForTest.Id;
        orderForTestFalse.Status = 'Draft';
        orderForTestFalse.EffectiveDate = Date.today();
        orderForTestFalse.CurrencyIsoCode = null;

        insert orderForTestFalse;

        Commentary__c commentToTest = new Commentary__c();
        commentToTest.Commentary__c = 'test';
        commentToTest.Name = 'test';
        commentToTest.Product__c = 'test';

        insert commentToTest;


        Case caseForTest = new Case();
        caseForTest.AccountId = accountForTest.Id;
        caseForTest.Subject = 'test';
        caseForTest.Description = 'test';

        insert caseForTest;

        OrderItem orderItemForTest = new OrderItem();
        orderItemForTest.Quantity = 1;
        orderItemForTest.OrderId = orderForTest.Id;
        orderItemForTest.UnitPrice = 10.00;
        orderItemForTest.ListPrice = 11.00;
        orderItemForTest.Product2Id = productForTest.Id;
        orderItemForTest.PricebookEntryId = entryForTest.Id;

        insert orderItemForTest;



    }


    @IsTest
    static void testMethodGetProducts(){

        Product2 productTotestMethod = [SELECT Id 
                                      FROM Product2 WHERE Name = 'test'];

        Product2 productTotestMethodFalse = [SELECT Id 
                                       FROM Product2 WHERE Name = 'test2'];

        
        Test.startTest();

            cartController.getProducts(new List<String>{productToTestMethod.Id} );
            cartController.getProducts(new List<String>{productTotestMethodFalse.Id} );
        
        Test.stopTest();
        
    }

    @IsTest
    static void testMethodGetOrder() {
        Order orderToTest = [SELECT Id
                            FROM Order WHERE Name='test'];
        Order orderToTestToFail = [SELECT Id
                            FROM Order WHERE Name='test2'];

        Test.startTest();

        cartController.getOrder(orderToTest.Id);
        cartController.getOrder(orderToTestToFail.Id);

        Test.stopTest();
    }

    @IsTest
    static void testRecieveRecord() {
        Product2 productToTest = [SELECT Id
                                 FROM Product2 WHERE Name='test'];

        List<PricebookEntry> pricebookEntryOfProduct = [SELECT Id, CurrencyIsoCode, Product2.CurrencyIsoCode, UnitPrice, Product2Id, Product2.Custom_Description__c, Product2.Main_Photo__c, Pricebook2.IsStandard, Product2.Name,Product2.Family, Product2.Status__c
        FROM PricebookEntry
        WHERE PriceBook2.IsStandard = true];


        Test.startTest();

        RecordPageController.recieveRecordData(productToTest.Id);


        Test.stopTest();
    }


    @IsTest
    static void updatePriceTest() {
        Product2 productToTest = [SELECT Id
        FROM Product2 WHERE Name='test'];

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];

        User u2 = new User(Alias = 'newUser', Email='newuser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles', UserName='newuser@testorg.com');


        Test.startTest();

        RecordPageController.updatePriceAfterAuction(productToTest.Id, 30.00, u2.Id);

        Test.stopTest();
    }

    @IsTest
    static void isOnAuctionTest() {

        Product2 productToTest = [SELECT Id
        FROM Product2 WHERE Name='test'];

        test.startTest();

        RecordPageController.checkIfProductIsOnAuction(productToTest.Id);

        Test.stopTest();

    }



    

    @IsTest
    static void testMethodrecieveCaseBody() {
       Case caseToTest = [SELECT Id
                            FROM Case];

        Test.startTest();

        cartController.recieveCaseBody(caseToTest.Id);

        Test.stopTest();
    }

    @IsTest
    static void svaeOrderDetailsTest() {
        Order orderToSerialize = [SELECT Id FROM Order LIMIT 1];

        String serializedOrder = JSON.serialize(orderToSerialize);

        Test.startTest();
        cartController.saveOrderDetails(serializedOrder);
        Test.stopTest();

    }

    @IsTest
    static void testMethodOrderData() {

        cartController.OrderData controller = new cartController.OrderData();

        Test.startTest();

        controller.getOrder();

        Test.stopTest();
    }



    @IsTest
    static void createCaseTest() {

        Product2 productTest = [SELECT Id 
                                FROM Product2 WHERE Name='test'];

        OrderItem itemTest = [SELECT Id
                             FROM OrderItem];
        

        Test.startTest();

        cartController.createACase('omnomnom', 'test', productTest.Id, itemTest.Id);

        Test.stopTest();
    }

    @IsTest
    static void getConsoleTest() {

        Test.startTest();

       CategoryPagesController.getConsoleCategoryProducts();

        Test.stopTest();
    }

    

    @IsTest
    static void getToysTest() {

        Test.startTest();

       CategoryPagesController.getToysCategoryProducts();

        Test.stopTest();
    }

    @IsTest
    static void getAccesoriesTest() {

        Test.startTest();

       CategoryPagesController.getAccesoriesCategoryProducts();

        Test.stopTest();
    }

    @IsTest
    static void getPhonesTest() {

        Test.startTest();

       CategoryPagesController.getPhonesCategoryProducts();

        Test.stopTest();
    }

    @IsTest
    static void saveCommentTest() {

        Product2 productToComment = [SELECT Id FROM Product2 WHERE Name='test'];

        Commentary__c commentToRecieve = [SELECT Id FROM Commentary__c];

        String idOfComment = (String)productToComment.Id;
        String idOfCommentary = (String)commentToRecieve.Id;

        Test.startTest();

       CommentaryContrller.saveNewCommentary(idOfCommentary, 'test', 4.00, idOfComment);

        Test.stopTest();
    }


    @IsTest
    static void getCommentListTest() {

        Product2 productsToRecieveComments = [SELECT Id FROM Product2 WHERE Name='test'];

        String idofProduct = (String)productsToRecieveComments.Id;

        Test.startTest();

        CommentaryContrller.getCommentList(idOfProduct);

        Test.stopTest();


    }

    @IsTest
    static void countDiscountPrecentageTest() {

        Test.startTest();

        DiscountManagerCalculatorController.countPrecentageDiscount(100.00 , 20);
        DiscountManagerCalculatorController.countPrecentageDiscount(100.00 , 200);

        Test.stopTest();
    }

    @IsTest
    static void createEntryTest() {

        Datetime dateToTest = Date.today();


        Product2 productToWrap = [SELECT Id, Name , Family , Description, ProductCode  FROM Product2 WHERE Name = 'test'];

       
        DiscountManagerController.ProductWrapper wrapper  = new DiscountManagerController.ProductWrapper(productToWrap);

        wrapper.setStandardPrice(30.00);


        List<DiscountManagerController.ProductWrapper> listOfWrappers  = new List<DiscountManagerController.ProductWrapper>{wrapper};

        String serializedProduct = JSON.serialize(listOfWrappers);

        Test.startTest();

        DiscountManagerCalculatorController.createNewEntries(serializedProduct, 20 , 'currency', 'test', dateToTest, dateToTest);
        DiscountManagerCalculatorController.createNewEntries(serializedProduct, 20 , 'precentage', 'test', dateToTest, dateToTest);

        Test.stopTest();
    }


    @IsTest
    static void countDiscountCurrencyTest() {

        Test.startTest();

        DiscountManagerCalculatorController.countCurrencyDiscount(100.00, 20);
        DiscountManagerCalculatorController.countCurrencyDiscount(100.00, 500);

        Test.stopTest();
    }

    @IsTest
    static void getPricebookListTest() {

        Test.startTest();

        DiscountManagerCalculatorController.getPricebookList();

        Test.stopTest();
    }


    @IsTest
    static void pricebookEntryInsertTest() {

        Product2 idToInsert = [SELECT Id, ProductCode  FROM Product2 WHERE Name='test'];


        PriceBook2 idToInsertPB = [SELECT Id FROM PriceBook2 LIMIT 1];

        String id1 = (String)idToInsert.Id;
        String id2 =  (String)idToInsertPb.Id;

        Test.startTest();

        DiscountManagerCalculatorController.pricebookEntryInsert(id1, id2, idToInsert.ProductCode, 100.00, Date.TODAY(), Date.TODAY() );

        Test.stopTest();
    }

    @IsTest
    static void getProductsTest() {

        Test.startTest();

        DiscountManagerController.getProducts();

        Test.stopTest();
    }

    @IsTest
    static void getStandardPricebookEntriesByProductsIdsTest() {

        Test.startTest();

        DiscountManagerController.getStandardPricebookEntriesByProductsIds();

        Test.stopTest();
    }

    @IsTest
    static void searchHotDealsProductsTest() {

        Test.startTest();

        MainMenuController.searchHotDealsProducts();

        Test.stopTest();
    }

    @IsTest
    static void searchSalesProductsTest() {

        Test.startTest();

        MainMenuController.searchSalesProducts();

        Test.stopTest();
    }

    @IsTest
    static void getIdsOfDocumentContentVersionTest() {

        Product2 productsToRecieve = [SELECT Id FROM Product2 WHERE Name='test'];

        String idOfPricebook = (String) productsToRecieve.Id;

        Test.startTest();

        PhotoUploader.getIdsOfDocumentContentVersion(idOfPricebook);

        Test.stopTest();


    }

    @IsTest
    static void getProductTest() {

        Product2 productsToRecieve = [SELECT Id FROM Product2 WHERE Name='test'];

        Test.startTest();

        PhotoUploader.getProduct(productsToRecieve.Id);

        Test.stopTest();


    }


    @IsTest
    static void setPhotoAsMainTest() {

        Product2 productsToRecieve = [SELECT Id FROM Product2 WHERE Name='test'];

        Test.startTest();

        PhotoUploader.setPhotoAsMain(productsToRecieve.Id, '123456789012345');

        Test.stopTest();


    }

    @IsTest
    static void makeDatacanCreateUser(){

        Auth.UserData data  = new Auth.UserData(null, null, null, null, null, null,null, null, null, null, null);


        AutocreatedRegHandler1662634123186 handler = new AutocreatedRegHandler1662634123186();

        
        Test.startTest();

        handler.canCreateUser(data);

        Test.stopTest();
        
    }


    @IsTest
    static void makeDataCreateUser(){

        Map<String,String> attributeMap = new Map<String,String>();

        Auth.UserData data  = new Auth.UserData(null, 'test', 'test', 'test test', 'test@test.com','franek', 'janek', 'google', null, null, attributeMap);

        Auth.UserData data2  = new Auth.UserData(null, 'test', 'test', 'test test', 'test@test.com', null,null, null, null, null, attributeMap);

        Id portalId = null;

        AutocreatedRegHandler1662634123186 handler = new AutocreatedRegHandler1662634123186();

        
        Test.startTest();

        handler.createUser(portalId, data);

        handler.createUser(portalId, data2);

        Test.stopTest();
        
    }



    @IsTest
    static void makeDataUpdateUser(){

        Map<String,String> attributeMap = new Map<String,String>();


        Auth.UserData data  = new Auth.UserData(null, 'test', 'test', 'test test', 'test@test.com', null,null, null, null, null, attributeMap);
        
        
        Id portalId = null;

        Id userId = UserInfo.getUserId();

        AutocreatedRegHandler1662634123186 handler = new AutocreatedRegHandler1662634123186();
        

        
        Test.startTest();

        handler.updateUser(userId, portalId, data);
 

        Test.stopTest();
        
    }


    @IsTest
    static void batchTest() {

        

        Test.startTest();

       discountManagerBatch batch = new discountManagerBatch();
       Database.executeBatch(batch);

        Test.stopTest();


    }


    @IsTest
    static void batchScheduleTest() {

        

        Test.startTest();

       batchScheduler.scheduler();
        
        Test.stopTest();


    }


    @IsTest
    static void productWrapperTest() {

        Product2 productToTest = [SELECT Id, Name, Family, ProductCode, Description  FROM Product2 WHERE Name ='test'];

        

        Test.startTest();

       DiscountManagerController.ProductWrapper wrapper  = new DiscountManagerController.ProductWrapper(productToTest);
        
        Test.stopTest();


    }

}

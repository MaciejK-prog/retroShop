
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
        productForTest.Family ='test';
        productForTest.Status__c ='Normal';
        productForTest.IsActive = true;

        insert productForTest;

        Product2 productForTestFalse = new Product2();
        productForTestFalse.Name = 'test2';
        productForTestFalse.ProductCode = null;
        productForTestFalse.Family =null;
        productForTestFalse.Status__c =null;
        productForTestFalse.IsActive = false;

        insert productForTestFalse;

        Id pricebookId = Test.getStandardPricebookId();


        PricebookEntry standardForTest = new PricebookEntry();
        standardForTest.Product2Id = productForTest.Id;
        standardForTest.Pricebook2Id = pricebookId;
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
        entryForTest.Pricebook2Id = pricebookForTest.Id;
        entryForTest.IsActive = true;
        entryForTest.CurrencyIsoCode = 'EUR';
        entryForTest.UnitPrice = 11.00;
    

        insert entryForTest;

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

        Test.startTest();

        cartController.getOrder(orderToTest.Id);

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

        PriceBook2 idToInsertPB = [SELECT Id FROM PriceBook2];

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

        String idofProduct = (String)productsToRecieve.Id;

        Test.startTest();

        PhotoUploader.getIdsOfDocumentContentVersion(idOfProduct);

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

        Auth.UserData data  = new Auth.UserData(null, null, null, null, null, null,null, null, null, null, null);
       
        Id portalId = null;

        AutocreatedRegHandler1662634123186 handler = new AutocreatedRegHandler1662634123186();

        
        Test.startTest();

        handler.createUser(portalId, data);

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

}

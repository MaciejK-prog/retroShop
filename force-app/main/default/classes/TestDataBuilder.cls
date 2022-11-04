@Istest
public class TestDataBuilder {

    public static String username = 'username@name.dajmispokoj';
    
    public static List<Product2> createProducts(Integer numberOfProducts) {
        List<Product2> pr = new List<Product2>();
        for(Integer i=0; i < numberOfProducts; i++) {
            pr.add(new BuilderProduct()
            .setName('test name ' + i)
            .setCarbohydrates(i + 1.5)
            .setEnergy(i + 1.5)
            .setFat(i + 1.5)
            .setProtein(i + 1.5)
            .setRating(Math.mod(i,5) + 1)
            .setProducent('producent')
            .setIngredients('ingredients')
            .setDescription('description')
            .setDefaultPhotoId('photoId'+i)
            .setFamily(Math.mod(i, 2)==0 ? 'Pasta' : 'Sauces')
            .setProductGroup(Math.mod(i, 2)==0 ? 'Rice noodles' : null)
            .getObject());
        }
        insert pr;
        return pr;
    }

    public static List<PricebookEntry> createPricebookWithNameAndEntries(String name, List<Product2> products) {
        Pricebook2 pb = new BuilderPricebook()
            .setName(name)
            .setIsActice(true)
            .setStartDate(Date.today())
            .setExpirationDate(Date.today().addMonths(1))
            .setDescription('description')
            .getObject();
        insert pb;

        insertStandardPricebookValues(products);

        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        for(Integer i=0; i < products.size(); i++) {
            pbeList.add(new BuilderPricebookEntry()
                .setIsDiscount(Math.mod(i,2) == 0 ? true : false)
                .setPricebookId(pb.Id)
                .setProductId(products[i].Id)
                .setStandardPrice(10)
                .setUnitPrice(Math.mod(i,2) == 0 ? 5 : 10)    
                .getObject());
        }
        insert pbeList;

        return pbeList;
    }

    private static void insertStandardPricebookValues(List<Product2> products) {
        Id pbId = Test.getStandardPricebookId();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        for(Integer i=0; i < products.size(); i++) {
            pbeList.add(new BuilderPricebookEntry()
                .setIsDiscount(false)
                .setPricebookId(pbId)
                .setProductId(products[i].Id)
                .setUnitPrice(10)    
                .getObject());
        }
        insert pbeList;
    }

    public static Account createAccount() {
        Account acc = new BuilderAccount()
            .setFirstName('Test')
            .setLastName('Jest')
            .getObject();

        insert acc;
        return acc;
    }

    public static User createUserWithPersonAccount(Account acc, String profile) {
        Id contactId = [SELECT Id FROM Contact WHERE AccountId=:acc.Id].get(0).Id;

        User u = new BuilderUser()
            .setContactId(contactId)
            .setFirstName('User')
            .setLastName('Test')
            .setIsActive(true)
            .setAlias('alias')
            .setEmail('mail@mail.com')
            .setEmailEncodingKey('UTF-8')
            .setLanguageLocaleKey(UserInfo.getLanguage())
            .setLocaleSidKey(UserInfo.getLocale())
            .setProfile(profile)
            .setTimeZoneSidKey('Europe/Berlin')
            .setUsername(username)
            .getObject();

        insert u;
        return u;
    }

    public static void createOrdersWithItems(Integer numberOfOrders, List<PricebookEntry> pricebookEntriesForEachItem, String accountId, String contactId, String pricebookId) {
        List<Order> orderList = new List<Order>();
        for(Integer i=0; i<numberOfOrders; i++) {
            orderList.add(
                new BuilderOrder()
                    .setAccountId(accountId)
                    .setBillToContactId(contactId)
                    .setShipToContactId(contactId)
                    .setPricebookId(pricebookId)
                    .setHasActiveComplaint(Math.mod(i,2) == 0 ? true : false)
                    .setEndDate(Date.today().addDays(7))
                    .setEffectiveDate(Date.today())
                    .setStatus('Draft')
                    .getObject()
            );    
        }

        insert orderList;
        
        List<OrderItem> orderItemList = new List<OrderItem>();
        for(Order o : orderList) {
            for(PricebookEntry pbe : pricebookEntriesForEachItem) {
                orderItemList.add(
                    new BuilderOrderItem()
                        .setEndDate(Date.today().addDays(7))
                        .setOrderId(o.Id)
                        .setProductId(pbe.Product2Id)
                        .setPricebookEntryId(pbe.Id)
                        .setQuantity(4)
                        .setListPrice(pbe.UnitPrice)
                        .setUnitPrice(pbe.UnitPrice)
                        .getObject()
                );
            }
        }

        insert orderItemList;
    }

    public static List<Case> createUserCases(User userContactAccount, List<Order> ordersForCases) {
        List<Case> newCases = new List<Case>();
        for(Order o : ordersForCases) {
            newCases.add(
                new BuilderCase()
                    .setContactId(userContactAccount.ContactId)
                    .setAccountId(userContactAccount.Contact.AccountId)
                    .setDescription('description') 
                    .setSubject('subject')   
                    .setStatus('New')
                    .setPriority('Medium')
                    .setReason('Product not as described')
                    .setOrderId(o.Id)
                    .getObject()
            );
        }

        insert newCases;
        return newCases;
    }

    public static List<Product_Opinion__c> createOpinionsForProduct(Integer numberOfOpinions, String productId) {
        List<Product_Opinion__c> poList = new List<Product_Opinion__c>();
        for(Integer i=0; i<numberOfOpinions; i++) {
            poList.add(
                new BuilderProductOpinion()
                    .setApprovalStatus('Approved')
                    .setComment('comment')
                    .setIsEdited(false)
                    .setProductId(productId)
                    .setRate(Math.mod(1,5) + 1)
                    .getObject()
            );
        }

        insert poList;
        return poList;
    }

    public static Auth.UserData createValidUserData(Boolean isCommunity) {
        Map<String,String> attributeMap = new Map<String,String>();
        if(isCommunity) {
            attributeMap.put('sfdc_networkid', 'jakas wartosc');
        }
        
        Auth.UserData data = new Auth.UserData(
            null, //identifier
            'test2', //firstname
            'test2', //lastname
            'test test2', //fullname
            'mail2@mail.com', //email
            null, //link
            null, //username
            null, //locale
            null, //provider
            null, //siteLoginUrl
            attributeMap //attributeMap
        );
        return data;
    }

    public static Auth.UserData createEmptyUserData() {
        Auth.UserData data = new Auth.UserData(
            null, //identifier
            null, //firstname
            null, //lastname
            null, //fullname
            null, //email
            null, //link
            null, //username
            null, //locale
            null, //provider
            null, //siteLoginUrl
            null //attributeMap
        );
        return data;
    }
}
@Istest
private class AutocreatedRegHandler1662634123186Test {
    
    @Istest
    static void testCreateUserWithInvalidData() {
        Auth.UserData data = TestDataBuilder.createEmptyUserData();
        Test.startTest();
            User resultUser = new AutocreatedRegHandler1662634123186().createUser(null, data);
        Test.stopTest();

        System.assertEquals(null, resultUser);
    }

    @Istest
    static void testCreateUserAsCommunityUser() {
        Auth.UserData data = TestDataBuilder.createValidUserData(true);
        Test.startTest();
            User resultUser = new AutocreatedRegHandler1662634123186().createUser(null, data);
        Test.stopTest();

        String profileId = [SELECT Id FROM Profile WHERE Name = 'Person Account Profile'].get(0).Id;

        System.assertNotEquals(null, resultUser);
        System.assertNotEquals(new User(), resultUser);
        System.assertEquals(data.firstName, resultUser.FirstName);
        System.assertEquals(data.lastName, resultUser.LastName);
        System.assertEquals(data.email, resultUser.Email);
        System.assertEquals(profileId, resultUser.ProfileId);
    }

    @Istest
    static void testCreateUserAsStandardUser() {
        Auth.UserData data = TestDataBuilder.createValidUserData(false);
        Test.startTest();
            User resultUser = new AutocreatedRegHandler1662634123186().createUser(null, data);
        Test.stopTest();

        String profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].get(0).Id;

        System.assertNotEquals(null, resultUser);
        System.assertNotEquals(new User(), resultUser);
        System.assertEquals(data.firstName, resultUser.FirstName);
        System.assertEquals(data.lastName, resultUser.LastName);
        System.assertEquals(data.email, resultUser.Email);
        System.assertEquals(profileId, resultUser.ProfileId);
    }

    @Istest
    static void testUpdateUser() {
        User adminUser = [SELECT Id, ProfileId FROM User WHERE Profile.Name = 'System Administrator'].get(0);
        User dumpUser;
        System.runAs(adminUser) {
            Account acc = TestDataBuilder.createAccount();
            String profile = [SELECT Id FROM Profile WHERE Name = 'Person Account Profile'].get(0).Id;
            dumpUser = TestDataBuilder.createUserWithPersonAccount(acc, profile);
        }

        Auth.UserData data = TestDataBuilder.createValidUserData(true);
        
        Test.startTest();
            new AutocreatedRegHandler1662634123186().updateUser(dumpUser.Id, null, data);
        Test.stopTest();

        User resultUser = [SELECT Id, FirstName, LastName, Email FROM User WHERE Id = :dumpUser.Id].get(0);

        System.assertNotEquals(new User(), resultUser);
        System.assertEquals(dumpUser.Id, resultUser.Id);
        System.assertNotEquals(dumpUser.FirstName, resultUser.FirstName);
        System.assertEquals(data.firstName, resultUser.FirstName);
        System.assertNotEquals(dumpUser.LastName, resultUser.LastName);
        System.assertEquals(data.lastName, resultUser.LastName);
        System.assertNotEquals(dumpUser.Email, resultUser.Email);
        System.assertEquals(data.email, resultUser.Email);
    }
}
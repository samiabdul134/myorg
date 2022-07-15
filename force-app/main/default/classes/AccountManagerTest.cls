@IsTest
private class AccountManagerTest {
    @isTest static void testGetRecord() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://login.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }
    static Id createTestRecord() {
        // Create test record
        Account AccountTest = new Account(
            Name='Test record',
            Phone='1234569787');
            
        insert AccountTest;
        return AccountTest.Id;
    }     
}
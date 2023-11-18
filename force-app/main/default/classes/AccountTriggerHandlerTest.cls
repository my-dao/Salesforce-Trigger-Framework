@isTest
private class AccountTriggerHandlerTest {
    /**
     * Tests the 'before insert' functionality of the AccountTriggerHandler.
     */
    @isTest
    static void testBeforeInsert() {
        // Create a new Account for testing
        Account testAccount = new Account(Name = 'Test Account');

        // Start the test execution context
        Test.startTest();

        // Insert the Account to trigger the 'before insert' logic
        insert testAccount;

        // Stop the test execution context
        Test.stopTest();

        // Query the inserted Account to verify the changes made by the trigger
        Account insertedAccount = [SELECT Description FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(
            'Hello Trigger Framework',
            insertedAccount.Description,
            'The description should be updated by the trigger.'
        );
    }

    /**
     * Tests the 'before update' functionality of the AccountTriggerHandler.
     */
    @isTest
    static void testBeforeUpdate() {
        // Create and insert an Account for testing
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Update the Account to trigger the 'before update' logic
        testAccount.Name = 'Updated Test Account';

        Test.startTest();

        // Update the Account
        update testAccount;

        Test.stopTest();

        // Query the updated Account to verify the changes made by the trigger
        Account updatedAccount = [SELECT Description FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(
            'Hello Trigger Framework',
            updatedAccount.Description,
            'The description should be updated by the trigger.'
        );
    }

    // Additional test methods can be added here for other trigger events like 'before delete', 'after insert', etc.
}

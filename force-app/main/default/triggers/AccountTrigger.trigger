/**
 * @description: Trigger for Account object.
 * This trigger handles all DML operations (insert, update, delete, undelete) on the Account object.
 * It delegates the processing logic to the AccountTriggerHandler class, which contains the specific
 * business logic for each trigger event.
 */
trigger AccountTrigger on Account(
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete
) {
    // Create an instance of AccountTriggerHandler and execute the trigger logic.
    new AccountTriggerHandler().execute();
}

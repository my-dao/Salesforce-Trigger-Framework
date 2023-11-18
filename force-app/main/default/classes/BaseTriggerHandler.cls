/**
 * Represents a generic trigger handler.
 * This virtual class provides a structured framework for handling different DML operations
 * in Salesforce triggers. It includes methods for initialization, handling specific trigger events,
 * finalization, and exception handling. Subclasses should override the virtual methods to provide
 * specific logic for different sObject types.
 */
public virtual class BaseTriggerHandler {
    // Represents the sObjectType for the current trigger context.
    protected Schema.sObjectType objectType;

    // A set of sObjectTypes that should bypass the trigger execution.
    private static Set<Schema.sObjectType> bypassedHandlers = new Set<Schema.sObjectType>();

    /**
     * Adds an sObjectType to the bypass set. Triggers for this sObjectType will be skipped.
     * @param objectType The sObjectType to bypass.
     */
    public static void bypass(Schema.sObjectType objectType) {
        bypassedHandlers.add(objectType);
    }

    /**
     * Removes an sObjectType from the bypass set, re-enabling trigger execution for it.
     * @param objectType The sObjectType to re-enable.
     */
    public static void clearBypass(Schema.sObjectType objectType) {
        bypassedHandlers.remove(objectType);
    }

    /**
     * Checks if an sObjectType is currently set to be bypassed.
     * @param objectType The sObjectType to check.
     * @return Boolean indicating if the sObjectType is bypassed.
     */
    public static Boolean isBypassed(Schema.sObjectType objectType) {
        return bypassedHandlers.contains(objectType);
    }

    /**
     * Clears all sObjectTypes from the bypass set, re-enabling triggers for all sObjectTypes.
     */
    public static void clearAllBypasses() {
        bypassedHandlers.clear();
    }

    /**
     * Determines the sObjectType in the current trigger context.
     * @return The sObjectType for the current trigger context, or null if not available.
     */
    protected Schema.sObjectType getSObjectType() {
        if (Trigger.new != null && !Trigger.new.isEmpty()) {
            return Trigger.new[0].getSObjectType();
        } else if (Trigger.old != null && !Trigger.old.isEmpty()) {
            return Trigger.old[0].getSObjectType();
        }
        // Edge case handling or logging can be added here
        return null;
    }

    /**
     * Main method to execute the trigger logic. This method checks for trigger context,
     * bypasses if necessary, and calls the respective event handling methods.
     * It should be called from the actual trigger.
     */
    public void execute() {
        verifyExecutionContext();
        if (objectType == null) {
            objectType = getSObjectType();
        }
        if (isBypassed(objectType))
            return;
        try {
            initialize();
            executeEventHandler();
            finalize();
        } catch (Exception ex) {
            handleException(ex);
        }
    }

    /**
     * Verifies if the execution context is correct (i.e., within a trigger or a test execution).
     * Throws an exception if the context is invalid.
     */
    private void verifyExecutionContext() {
        if (!Trigger.isExecuting && !System.Test.isRunningTest()) {
            throw new TriggerException('Method must be called from a trigger.');
        }
    }

    /**
     * Executes the appropriate event handler based on the trigger operation type.
     * Subclasses should override the specific event handling methods.
     */
    protected void executeEventHandler() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                handleBeforeInsert();
            }
            when BEFORE_UPDATE {
                handleBeforeUpdate();
            }
            when BEFORE_DELETE {
                handleBeforeDelete();
            }
            when AFTER_INSERT {
                handleAfterInsert();
            }
            when AFTER_UPDATE {
                handleAfterUpdate();
            }
            when AFTER_DELETE {
                handleAfterDelete();
            }
            when AFTER_UNDELETE {
                handleAfterUndelete();
            }
        }
    }

    /**
     * Initializes the trigger handler. Subclasses can override this method to perform
     * any setup before the event handling methods are called.
     */
    public virtual void initialize() {
    }

    // virtual methods for each trigger event. These can be implemented by subclasses.
    /**
     * Handles the 'before insert' event.
     */
    public virtual void handleBeforeInsert() {
    }

    /**
     * Handles the 'before update' event.
     */
    public virtual void handleBeforeUpdate() {
    }

    /**
     * Handles the 'before delete' event.
     */
    public virtual void handleBeforeDelete() {
    }

    /**
     * Handles the 'after insert' event.
     */
    public virtual void handleAfterInsert() {
    }

    /**
     * Handles the 'after update' event.
     */
    public virtual void handleAfterUpdate() {
    }

    /**
     * Handles the 'after delete' event.
     */
    public virtual void handleAfterDelete() {
    }

    /**
     * Handles the 'after undelete' event.
     */
    public virtual void handleAfterUndelete() {
    }

    /**
     * Finalizes the trigger handler. Subclasses can override this method to perform
     * any cleanup after the event handling methods are executed.
     */
    public virtual void finalize() {
    }

    /**
     * Handles exceptions that occur during trigger execution.
     * This method can be overridden by subclasses to implement custom exception handling.
     * @param ex The exception that occurred.
     */
    public virtual void handleException(Exception ex) {
        System.debug('Exception in TriggerHandler: ' + ex.getMessage());
        throw ex;
    }

    public class TriggerException extends Exception {
    }
}

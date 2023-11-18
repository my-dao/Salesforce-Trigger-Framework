/**
 * @description: Generic trigger handler
 **/
public virtual class TriggerHandler {
    public Schema.sObjectType objectType;

    // List of sobjecttypes to be bypassed
    private static Set<Schema.sObjectType> bypassedHandlers = new Set<Schema.sObjectType>();

    //=============================================================================================
    // Static methods used to avoid recursion
    //=============================================================================================
    public static void bypass(Schema.sObjectType objectType) {
        bypassedHandlers.add(objectType);
    }

    public static void clearBypass(Schema.sObjectType objectType) {
        bypassedHandlers.remove(objectType);
    }

    public static Boolean isBypassed(Schema.sObjectType objectType) {
        return bypassedHandlers.contains(objectType);
    }

    public static void clearAllBypasses() {
        bypassedHandlers.clear();
    }

    //=============================================================================================
    // Utility methods
    //=============================================================================================
    /**
     * Get sObjectType in the current context
     */
    public Schema.sObjectType getSObjectType() {
        if (Trigger.new != null) {
            return Trigger.new.get(0).getSObjectType();
        } else if (Trigger.old != null) {
            return Trigger.old.get(0).getSObjectType();
        }
        return null;
    }

    //=============================================================================================
    // Handling methods
    //=============================================================================================
    // Main flow for all 'main' trigger
    public void execute() {
        //checks if the code is not executing within the context of a trigger
        // and  the code is not running as part of a test execution.
        if (!Trigger.isExecuting && !System.Test.isRunningTest()) {
            throw new TriggerException('This method must be called from a trigger.');
        }

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

    public void executeEventHandler() {
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

    public virtual void initialize() {
    }

    // Hanlde Before Insert
    public virtual void handleBeforeInsert() {
    }

    // Hanlde Before Update
    public virtual void handleBeforeUpdate() {
    }

    // Hanlde Before Delete
    public virtual void handleBeforeDelete() {
    }

    // Hanlde After Insert
    public virtual void handleAfterInsert() {
    }

    // Hanlde After Update
    public virtual void handleAfterUpdate() {
    }

    // Hanlde After Delete
    public virtual void handleAfterDelete() {
    }

    // Hanlde After Undelete
    public virtual void handleAfterUndelete() {
    }

    public virtual void finalize() {
    }

    public virtual void handleException(Exception ex) {
        throw ex;
    }

    public class TriggerException extends Exception {
    }
}

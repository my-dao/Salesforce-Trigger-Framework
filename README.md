# Salesforce Trigger Framework

This repository contains a simple Salesforce Trigger Framework designed to streamline the process of handling triggers in Salesforce. It follows best practices in Salesforce development, emphasizing clean, maintainable, and efficient code. Although there are more intricate trigger frameworks, I've found that this one works well enough for the projects I've worked on.

The framework is divided into three key components:

1. `BaseTriggerHandler`: The virtual base class that defines the structure and template methods for handling triggers. It includes methods for initialization, handling specific trigger events, finalization, and exception handling.
2. `AccountTriggerHandler`: A specific implementation of the `BaseTriggerHandler` for handling triggers related to the Account object.
3. `AccountTrigger`: A trigger on the Account object that delegates the processing logic to the `AccountTriggerHandler`.

## Usage

The trigger framework is designed to be easily extensible and reusable across different sObjects. To use this framework for a specific sObject:

1. Extend the `BaseTriggerHandler` class to create a handler for your sObject (similar to `AccountTriggerHandler.cls`).
2. Implement the logic for each trigger event (insert, update, delete, etc.) in your custom handler class.
3. Create a trigger for your sObject and delegate the processing logic to your custom handler class (similar to `AccountTrigger.trigger`).

## Consideration: Using a Helper Class

When designing trigger handlers in Salesforce, one approach to consider is the use of a ‘helper’ class. This can keep the trigger handler clean and clear, which is helpful for code review and documentation of the trigger logic. In scenarios where the trigger logic is complex or reusable, encapsulating it within a helper class can make the handler more readable and maintainable. Below is an example that illustrates this approach:

```apex
private AccountTriggerHelper helper;

public override void initialize() {
    newList = (List<Account>) Trigger.new;
    oldMap = (Map<Id, Account>) Trigger.oldMap;
    helper = new AccountTriggerHelper();
}

// Handle Before Insert event
public override void handleBeforeInsert() {
    // Tasks delegated to the helper class
    helper.doTask1(newList, oldMap);
    helper.doTask2(newList, oldMap);
}
```

This example demonstrates how `AccountTriggerHelper` can be utilized to manage specific tasks, thereby keeping the `AccountTriggerHandler` focused on managing the overall flow of the trigger. Such separation of concerns can enhance the clarity and manageability of your code.

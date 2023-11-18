# Salesforce Trigger Framework

This repository contains a simple Salesforce Trigger Framework designed to streamline the process of handling triggers in Salesforce. It follows best practices in Salesforce development, emphasizing clean, maintainable, and efficient code. Although there are more intricate trigger frameworks, I've found that this one works well enough for the projects I've worked on.

The framework is divided into three key components:

1. `BaseTriggerHandler`: A base class providing a structured approach to handle different DML operations in Salesforce.
2. `AccountTriggerHandler`: A specific implementation of the `BaseTriggerHandler` for handling triggers related to the Account object.
3. `AccountTrigger`: A trigger on the Account object that delegates the processing logic to the `AccountTriggerHandler`.

## Files in the Repository

-   `BaseTriggerHandler.cls`: The virtual base class that defines the structure and template methods for handling triggers. It includes methods for initialization, handling specific trigger events, finalization, and exception handling.
-   `AccountTriggerHandler.cls`: An extension of `BaseTriggerHandler` specifically for the Account object. It overrides methods to provide specific logic for various trigger events like insert, update, and delete.
-   `AccountTrigger.trigger`: The actual trigger for the Account object. It makes use of `AccountTriggerHandler` to process trigger events.

## Usage

The trigger framework is designed to be easily extensible and reusable across different sObjects. To use this framework for a specific sObject:

1. Extend the `BaseTriggerHandler` class to create a handler for your sObject (similar to `AccountTriggerHandler.cls`).
2. Implement the logic for each trigger event (insert, update, delete, etc.) in your custom handler class.
3. Create a trigger for your sObject and delegate the processing logic to your custom handler class (similar to `AccountTrigger.trigger`).

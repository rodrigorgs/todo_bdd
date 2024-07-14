
Feature: Change task status

    Scenario: Mark a task as completed
        Given the app is running
            And I add a task {"Buy milk"}
        When I mark the task {"Buy milk"} as {'completed'}
        Then the task {"Buy milk"} is {'completed'}

    Scenario: Mark a task as pending
        Given the app is running
            And I add a task {"Buy milk"}
            And I mark the task {"Buy milk"} as {'completed'}
        When I mark the task {"Buy milk"} as {'pending'}
        Then the task {"Buy milk"} is {'pending'}

Feature: Add task
    
        Scenario: Add a task
            Given the app is running
            When I add a task {"Buy milk"}
            Then I see {"Buy milk"} text
            And the task {"Buy milk"} is {'pending'}

Feature: List tasks

    Scenario: Empty list
        Given the app is running
        Then I see {"No tasks found"} text

Feature: Delete task

    Scenario: Delete a task
        Given the app is running
            And I add a task {"Workout"}
            And I add a task {"Buy milk"}
            And I add a task {"Sleep"}
        When I delete the task {"Buy milk"}
        Then I don't see {"Buy milk"} text

Feature: Add task

    Scenario: Add a task
    
        Given the app is running
        When I add a task {"Buy milk"}
        Then I see {"Buy milk"} text

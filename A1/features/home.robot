*** Settings ***
Resource  ../support/imports.robot

Test Setup  Initialize Test

*** Test Cases ***
Scenario: Welcome message is shown on home page
    [Documentation]  Rule: A positive message should be shown on the home page
    When the client checks the home page
    Then the home page main message should be: "Welcome to Geek Pizza!"

Scenario: Only active pizza menu items are listed on the menu page
    [Documentation]  Rule: Inactive pizzas should not be listed
    Given the menu has been configured to contain 5 active and 2 inactive pizzas
    When the client checks the menu page
    Then there should be 5 pizzas listed

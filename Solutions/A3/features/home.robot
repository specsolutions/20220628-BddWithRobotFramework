*** Settings ***
Resource  ../support/imports.robot

Test Setup  Initialize Test

*** Test Cases ***
Scenario: Welcome message is shown on home page
    [Documentation]  Rule: A positive message should be shown on the home page
    When the client checks the home page
    Then the home page main message should be: "Welcome to Geek Pizza!"

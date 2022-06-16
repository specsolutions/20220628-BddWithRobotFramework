*** Settings ***
Resource  ../support/imports.robot

Test Setup  Initialize Test

*** Test Cases ***
Scenario: Customer registers successfully
    [Documentation]  Rule: Should be able to register with user name and password
    When the client attempts to register with user name "Trillian" and password "139139"
    Then the registration should be successful

Scenario: User name was not provided
    [Documentation]  Rule: The user name is mandatory
    When the client attempts to register with  userName=${EMPTY}
    Then the registration should fail with "Name must be provided"

Scenario: Password was not provided
    [Documentation]  Rule: The password should be valid and verified
    When the client attempts to register with  password=${EMPTY}  passwordReEnter=${EMPTY}
    Then the registration should fail with "Password and password re-enter must be provided"

Scenario: The re-entered password is different
    [Documentation]  Rule: The password should be valid and verified
    When the client attempts to register with  password=139139  passwordReEnter=different
    Then the registration should fail with "Re-entered password is different"

Scenario: Password is too short
    [Documentation]  Rule: The password should be valid and verified
    When the client attempts to register with  password=123  passwordReEnter=123
    Then the registration should fail with "Password must be at least 4 characters long"

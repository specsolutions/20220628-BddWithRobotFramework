*** Settings ***
Resource  ../support/imports.robot

Test Setup  Initialize Test

*** Test Cases ***
Scenario: Customer registers successfully
    [Documentation]  Rule: Should be able to register with user name and password
    When the client attempts to register with user name "Trillian" and password "139139"
    Then the registration should be successful

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


Scenario Outline: The password should be valid and verified
    [Template]  Verify Password
    Password was not provided              ${EMPTY}   ${EMPTY}   Password and password re-enter must be provided
    The re-entered password is different   139139     different  Re-entered password is different
    Password is too short                  123        123        Password must be at least 4 characters long

# Alternative approach
Scenario Outline: Registration data should be validated
    [Template]  Verify Registration Data
	User name was not provided             userName          ${EMPTY}    Name must be provided                          
    Password was not provided              password          ${EMPTY}    Password and password re-enter must be provided
    The re-entered password is different   passwordReEnter   different   Re-entered password is different
    Password is too short                  passwords         123         Password must be at least 4 characters long    

*** Keywords ***
Verify Password
    [Arguments]  ${description}  ${password}  ${password_re_enter}  ${error_message}
    Initialize Test
    When the client attempts to register with  password=${password}  passwordReEnter=${password_re_enter}
    Then the registration should fail with "${error_message}"


# Alternative approach
Verify Registration Data
    [Arguments]     ${description}  ${field}  ${value}  ${error_message}
    Given the client provides registration details as    
    ...  userName=Trillian  password=139139  passwordReEnter=139139
    But the registration field "${field}" is set to "${value}"
    When the client attempts to register
    Then the registration should fail with "${error_message}"

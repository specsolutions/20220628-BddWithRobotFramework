*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
Register User
    [Arguments]  &{register_input}
    Attempt Register User ${register_input}
    Assert Registration Success

Attempt Register User
    [Arguments]  ${register_input}
    ${response}=  POST On Session  user_session  /api/user  json=${register_input}  expected_status=Anything
    Set Test Variable  $register_response  ${response}

Assert Registration Success
    Status Should Be  200  ${register_response}

Assert Registration Failed
    [Arguments]  ${error_message}
    Status Should Be  400  ${register_response}
    ${body}=  Convert To String  ${register_response.content}
    Should Be Equal  ${body}  ${error_message}

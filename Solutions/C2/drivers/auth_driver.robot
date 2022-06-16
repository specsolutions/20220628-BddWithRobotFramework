*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
Login User
    [Arguments]  &{login_input}
    Attempt Login User  ${login_input}
    Assert Login Success

Attempt Login User
    [Arguments]  ${login_input}
    ${response}=  POST On Session  user_session  /api/auth  json=${login_input}  expected_status=Anything
    Set Test Variable  $register_response  ${response}

Assert Login Success
    Status Should Be  200  ${register_response}

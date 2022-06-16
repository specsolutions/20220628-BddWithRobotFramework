*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The client attempts to register with user name "${user_name}" and password "${password}"
    &{body}=  Create Dictionary  userName=${user_name}  password=${password}  passwordReEnter=${password}
    ${response}=  POST On Session  user_session  /api/user  json=${body}  expected_status=Anything
    Set Test Variable  $register_response  ${response}

The registration should be successful
    Status Should Be  200  ${register_response}

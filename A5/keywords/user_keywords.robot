*** Settings ***
Resource    ../support/imports.robot

*** Variables ***
&{default_register_intput}      userName=Trillian  password=139139  passwordReEnter=139139

*** Keywords ***
The client attempts to register with user name "${user_name}" and password "${password}"
    &{body}=  Create Dictionary  userName=${user_name}  password=${password}  passwordReEnter=${password}
    ${response}=  POST On Session  user_session  /api/user  json=${body}  expected_status=Anything
    Set Test Variable  $register_response  ${response}

The client attempts to register with
    [Arguments]  &{register_input}
    Apply DataTable Row Defaults  ${register_input}  ${default_register_intput}
    ${response}=  POST On Session  user_session  /api/user  json=${register_input}  expected_status=Anything
    Set Test Variable  $register_response  ${response}

The registration should be successful
    Status Should Be  200  ${register_response}

The registration should fail with "${error_message}"
    Status Should Be  400  ${register_response}
    ${body}=  Convert To String  ${register_response.content}
    Should Be Equal  ${body}  ${error_message}

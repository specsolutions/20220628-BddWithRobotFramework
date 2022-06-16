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


# Alternative approach

The client provides registration details as
    [Arguments]  &{register_input}
    Apply DataTable Row Defaults  ${register_input}  ${default_register_intput}
    Set Test Variable  $register_input_data  ${register_input}

The registration field "${field}" is set to "${value}"
    IF  '${field}' == 'passwords'
        Update DataTable Row  ${register_input_data}  password  ${value}
        Update DataTable Row  ${register_input_data}  passwordReEnter  ${value}
    ELSE
        Update DataTable Row  ${register_input_data}  ${field}  ${value}
    END

The client attempts to register
    Log Dictionary    ${register_input_data}
    &{header}=  Create Dictionary  Cache-Control=no-cache
    ${response}=  POST On Session  user_session  /api/user  json=${register_input_data}  headers=${header}  expected_status=Anything
    Set Test Variable  $register_response  ${response}

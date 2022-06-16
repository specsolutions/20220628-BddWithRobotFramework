*** Settings ***
Resource    ../support/imports.robot

*** Variables ***
&{default_register_intput}      userName=Trillian  password=139139  passwordReEnter=139139

*** Keywords ***
The client attempts to register with user name "${user_name}" and password "${password}"
    &{register_input}=  Create Dictionary  userName=${user_name}  password=${password}  passwordReEnter=${password}
    user_driver.Attempt Register User  ${register_input}

The client attempts to register with
    [Arguments]  &{register_input}
    Apply DataTable Row Defaults  ${register_input}  ${default_register_intput}
    user_driver.Attempt Register User  ${register_input}

The registration should be successful
    user_driver.Assert Registration Success

The registration should fail with "${error_message}"
    user_driver.Assert Registration Failed    ${error_message}

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
    user_driver.Attempt Register User  ${register_input_data}

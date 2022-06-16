*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The client attempts to register with user name "${user_name}" and password "${password}"
    &{body}=  Create Dictionary  userName=${user_name}  password=${password}  passwordReEnter=${password}
    #TODO: complete keyword

The registration should be successful
    #TODO: complete keyword


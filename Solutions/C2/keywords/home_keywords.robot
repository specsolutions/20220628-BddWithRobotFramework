*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The client checks the home page
    home_driver.Get Home Page Model

The home page main message should be: "${expected_message}"
    Should be equal  ${home_page_model}[mainMessage]  ${expected_message}

The user name of the client should be on the home page
    Should be equal  ${home_page_model}[userName]  Marvin

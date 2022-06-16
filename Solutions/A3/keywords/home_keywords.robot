*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The client checks the home page
    ${response}=  GET On Session  user_session  /api/home/
    Set Test Variable  $home_response  ${response}

The home page main message should be: "${expected_message}"
    Should be equal  ${home_response.json()}[mainMessage]  ${expected_message}

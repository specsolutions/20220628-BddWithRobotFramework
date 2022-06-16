*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
Get Home Page Model
    ${response}=  GET On Session  user_session  /api/home/
    Set Test Variable  $home_page_model  ${response.json()}
    [Return]  ${response.json()}

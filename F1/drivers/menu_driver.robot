*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
Get Menu Page Model
    ${response}=  GET On Session  user_session  /api/menu/
    Set Test Variable  $menu_page_model  ${response.json()}
    [Return]  ${response.json()}

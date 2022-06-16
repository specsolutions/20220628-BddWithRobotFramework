*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
Update Menu
    [Arguments]  ${menuItems}
    Ensure Admin Login
    ${response}=  POST On Session  admin_session  /api/admin/UpdateMenu  json=${menuItems}
    Status Should Be  204  ${response}

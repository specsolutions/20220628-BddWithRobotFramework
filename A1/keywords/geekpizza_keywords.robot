*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The menu has been configured to contain ${active_pizzas} active and ${inactive_pizzas} inactive pizzas
    Admin Login
    @{menuItems}=  Create List
    FOR  ${i}  IN RANGE  0  ${active_pizzas}
        &{menuItem}=  Create Dictionary  name=Pizza ${i}  ingredients=default ingredients  calories=1000  inactive=${False}
        Append To List  ${menuItems}  ${menuItem}
    END
    FOR  ${i}  IN RANGE  0  ${inactive_pizzas}
        &{menuItem}=  Create Dictionary  name=Old pizza ${i}  ingredients=default ingredients  calories=1000  inactive=${True}
        Append To List  ${menuItems}  ${menuItem}
    END
    ${response}=  POST On Session  admin_session  /api/admin/UpdateMenu  json=${menuItems}
    Status Should Be  204  ${response}


The client checks the home page
    ${response}=  GET On Session  user_session  /api/home/
    Set Test Variable  $home_response  ${response}

The home page main message should be: "${expected_message}"
    Should be equal  ${home_response.json()}[mainMessage]  ${expected_message}
#Alternative ways to assert:
#1:  Should be equal  ${home_response.json()["mainMessage"]}  ${expected_message}
#2:  ${messageList}=  Get Value From Json  ${home_response.json()}  mainMessage
#    Should be equal  ${messageList}[0]  ${expected_message}

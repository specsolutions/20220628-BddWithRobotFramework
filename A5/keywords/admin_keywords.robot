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

The menu has been configured to contain the following pizzas
    [Arguments]  @{cell_list}
    ${table} =  Create DataTable  @{cell_list}
    Admin Login
    ${default_pizza} =  Create Dictionary  ingredients=default ingredients  calories=1000  inactive=${False}
    Apply DataTable Defaults  ${table}  ${default_pizza}
    @{menuItems}=  Create List
    FOR  ${menuItem}  IN  @{table}
        Append To List  ${menuItems}  ${menuItem}
    END
    ${response}=  POST On Session  admin_session  /api/admin/UpdateMenu  json=${menuItems}
    Status Should Be  204  ${response}

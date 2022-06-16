*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The client checks the menu page
    menu_driver.Get Menu Page Model

There should be ${expected_count} pizzas listed
    Length Should Be  ${menu_page_model}[items]  ${expected_count}

The following pizzas should be listed in this order
    [Arguments]  @{cell_list}
    ${expected_menu_items} =  Create DataTable  @{cell_list}
    Set Local Variable  $actual_menu_items  ${menu_page_model}[items]
    ${expected_count} =  Get Length  ${expected_menu_items}
    Length Should Be  ${actual_menu_items}  ${expected_count}
    FOR  ${expected_menu_item}  ${actual_menu_item}  IN ZIP  ${expected_menu_items}  ${actual_menu_items}
        Dictionary Should Contain Sub Dictionary  ${actual_menu_item}  ${expected_menu_item}
    END

*** Settings ***
Resource  ../support/imports.robot

Test Setup  Initialize Test

*** Test Cases ***
Scenario: Welcome message is shown on home page
    [Documentation]  Rule: A positive message should be shown on the home page
    When the client checks the home page
    Then the home page main message should be: "Welcome to Geek Pizza!"

Scenario: Only active pizza menu items are listed on the menu page
    [Documentation]  Rule: Inactive pizzas should not be listed
    Given the menu has been configured to contain 5 active and 2 inactive pizzas
    When the client checks the menu page
    Then there should be 5 pizzas listed

Scenario: The pizzas are listed in alphabetically on the menu page
    [Documentation]  Rule: Pizzas on menu should be listed alphabetically by name
    # Ignore the incidental details in the next step for now
    Given the menu has been configured to contain the following pizzas
    ...  :name             :ingredients                                          :calories
    ...  Margherita        tomato slices, oregano, mozzarella                    1920
    ...  Fitness           sweetcorn, broccoli, feta cheese, mozzarella          1340
    ...  BBQ               BBQ sauce, bacon, chicken breast strips, onions       1580
    ...  Mexican           taco sauce, bacon, beans, sweetcorn, mozzarella       2340
    ...  Quattro formaggi  blue cheese, parmesan, smoked mozzarella, mozzarella  2150
    When the client checks the menu page
    Then the following pizzas should be listed in this order
    ...  :name
    ...  BBQ
    ...  Fitness
    ...  Margherita
    ...  Mexican
    ...  Quattro formaggi

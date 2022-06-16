*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The client is logged in
    auth_driver.Login User  name=Marvin  password=1234

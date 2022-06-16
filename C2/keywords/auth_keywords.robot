*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
The client is logged in
    &{body}=  Create Dictionary  name=Marvin  password=1234
    ${response}=  POST On Session  user_session  /api/auth  json=${body}
    Status Should Be  200  ${response}  # sanity check

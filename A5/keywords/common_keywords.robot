*** Settings ***
Resource    ../support/imports.robot

*** Keywords ***
Init API
    [Documentation]  Creates a session for HTTP requests
    Create Session  user_session  ${APP_URL}

Admin Login
    Create Session  admin_session  ${APP_URL}  verify=true
    &{body}=  Create Dictionary  name=admin  password=secret
    ${admin_login_response}=  POST On Session  admin_session  /api/auth  json=${body}
    Status Should Be  200  ${admin_login_response}

Initialize Test
    [Documentation]  Generic initialization steps required for all tests
    Init API
  
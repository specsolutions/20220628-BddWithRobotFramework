@pushd %~dp0
@set DEMOAPP_PORT=5000
@set DEMOAPP_PACKAGE=DemoApp-win-x64.zip
@set DEMOAPP_FOLDER=%~dp0..\DemoApp
@set DEMOAPP_BIN=%DEMOAPP_FOLDER%\bin

@if exist %DEMOAPP_BIN%\* (
  echo DemoApp already extracted...
) else (
  echo Extracting DemoApp...
  powershell Expand-Archive %DEMOAPP_FOLDER%\%DEMOAPP_PACKAGE% -DestinationPath %DEMOAPP_BIN%
)

cd %DEMOAPP_BIN%
start "GeekPizza DemoApp" BddWithSpecFlow.GeekPizza.Web.exe --urls=http://localhost:%DEMOAPP_PORT% --tutorial=A1
start http://localhost:%DEMOAPP_PORT%

@popd
@EXIT /b

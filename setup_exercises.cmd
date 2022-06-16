@pushd %~dp0

py -m venv env
call env\Scripts\activate.bat
py -m pip install -r .\requirements.txt
@IF ERRORLEVEL 1 GOTO error

call env\Scripts\deactivate.bat

@echo.
@echo Python dependencies installed! In order to run robot framework tests from a command line, invoke:
@echo  - activate python virtual env
@echo    .\env\Scripts\activate
@echo  - step into the exercise folder (e.g. A5)
@echo    cd A5
@echo  - start demo app
@echo    start-demoapp.cmd
@echo  - run tests
@echo    py -m robot .\features
@echo.
@echo To finish working with the exercises, invoke:
@echo  - deactivate python virtual env
@echo    deactivate
@echo  - stop demo app: close the window titled "GeekPizza DemoApp"

@goto end

:error
@echo.
@echo Exercise setup failed! Please contact courses@specsolutions.eu if you cannot fix the problem.

:end

@popd

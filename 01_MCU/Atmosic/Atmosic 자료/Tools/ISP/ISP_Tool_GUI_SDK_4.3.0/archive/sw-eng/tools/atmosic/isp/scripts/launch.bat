@echo off
setlocal
call :clear_platform_vars
set SCRIPT_DIR=%~dp0
set ISP=%SCRIPT_DIR:~0,-1%\..
set SW_ENG_TOOLS=%ISP%\..\..
set PROJDIR2=%SW_ENG_TOOLS%\..\..
set SPARSE_SDK_ROOT=%PROJDIR2%\atmosic_sdk
set OPENOCD_DIR=%SPARSE_SDK_ROOT%\tools\openocd-0.10.0
set PATH=%OPENOCD_DIR%\bin\Windows_NT;%OPENOCD_DIR%\bin\Windows_NT\.stash;%PATH%
set ERASE_UPGRADE_DATA=1

call :reset_target
for /D %%d IN (%SPARSE_SDK_ROOT%\platform\*) DO CALL :find_platform %%d
if "%PLATFORM_DIR%" equ "" (call :handle_no_platform; exit /b 1)
if errorlevel 1 goto :eof
@echo Launching browser
set HTTP_APP=1
::set WEB_SVR=localhost:3000
set APP_URL=%ISP%\build\index.html
if "%APP_URL%" neq "" ( @echo "Using user provided %APP_URL%"
) else ( if "%WEB_SVR%" neq "" ( set APP_URL=http://%WEB_SVR%/%ATM_ISP_URI%
) else ( @echo "Either APP_URL or WEB_SVR has to be defined in the environment"; exit /b 1))
cd %ISP%
start %START% %APP_URL%
call :run_openocd -c "source [find http/openocd_http.tcl]"

:find_platform
for /D %%d IN (%1\*) DO call :try_platform %~n1\%%~nd
exit /b

:try_platform
if "%PLATFORM_DIR%" neq "" exit /b
set PLATFORM_DIR=%SPARSE_SDK_ROOT%\platform\%1
set PLATFORM_OPENOCD_DIR=%PLATFORM_DIR%\openocd
if not exist %PLATFORM_OPENOCD_DIR%\ goto :clear_platform_vars
@echo Trying as platform %1
set PLATFORM_CFG=
for %%f in (%PLATFORM_OPENOCD_DIR%\*_openocd.cfg) do call :set_platform_cfg %%f
if %PLATFORM_CFG% equ "" ( @echo "Could not find a config file in directory '%PLATFORM_OPENOCD_DIR%'"; exit 1 )
call :run_openocd -c "init; verify_rom_version; exit"
if %ERRORLEVEL% equ 0 exit /b
:clear_platform_vars
set PLATFORM_DIR=
set PLATFORM_OPENOCD_DIR=
set PLATFORM_CFG=
exit /b

:run_openocd_http
set HTTP_NVDS_TOOL=%PLATFORM_DIR%\tools\bin\Windows_NT\nvds_tool.exe
set OPENOCD_HTTP_DIR=%PLATFORM_DIR%\openocd\http
call :run_openocd -c "source [find http/openocd_http.tcl]"
exit /b

:run_openocd
openocd.exe -s %OPENOCD_DIR%\tcl -s %PLATFORM_OPENOCD_DIR% -f %PLATFORM_CFG% %1 %2
exit /b

:set_platform_cfg
if "%PLATFORM_CFG%" neq "" ( @echo Platform config file not unique: have '%PLATFORM_CFG%' and '%~nx1' in '%PLATFORM_OPENOCD_DIR%'; exit 1 )
set PLATFORM_CFG=%~nx1
exit /b

:handle_no_platform
@echo Could not determine platform
@echo Did you forget to replace the driver for the interface board (USB1, Interface 0) with WinUSB?
@echo If you did indeed install WinUSB for the interface board, then this tool distribution does not support the platform you are using.
pause
exit /b

:reset_target
set FTDI_BENIGN_BOOT=1
set FTDI_HARD_RESET=1
call :run_openocd -c "init; exit"
set FTDI_HARD_RESET=0
call :run_openocd -c "init; exit"
set FTDI_HARD_RESET=
call :run_openocd -c "init; set_normal_boot; exit"
if not errorlevel 0 (
   timeout 2
   call :run_openocd -c "init; set_normal_boot; exit"
)
set FTDI_BENIGN_BOOT=
exit /b

endlocal

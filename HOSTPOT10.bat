@echo off
rem V1.01
title HOSPOT10

echo [*] Checking if your device support wirless hospot...

rem CHECKING PROPS
openfiles >nul
if errorlevel 1 echo [*] Closing... & timeout 3 >nul & exit
REM this 'find' may need to be modify if your not english.
(netsh wlan show drivers | find /i "yes")
if not %errorlevel%==0 (
echo [!] Your Wireless Network Adapter is not supported or non-existent. & echo [*] Closing... & timeout 3 >nul & exit)
) 
echo [*] OK

::-------------------------------------------------------------
if not %1.==. echo '%1:%2' && if not %2.==. set ssid=%1 && set pass=%2 && call :confho %ssid% %pass% && call :ho && (set running=running) && goto :menu
::----CHECK ARG
echo.
echo Welcome to HOSPOT10
echo Assembled by @DOKA
echo.

echo.

set /p ssid=SSID     : 
set /p pass=Password : 
echo.
echo [*] Starting hospot...
echo.

call :confho %ssid% %pass%
if %errorlevel%==0 (
echo [*] Hospot configured...
echo.)

call :ho
if not %errorlevel%==0 (
echo [*] Error!
) else (echo [*] Hospot started succefully.) & (set running=running)

timeout 3 >nul
call :menu

exit

:confho
NETSH WLAN set hostednetwork mode=allow ssid=%ssid% key=%pass%
exit /b %errorlevel%


:ho
NETSH WLAN start hostednetwork
exit /b %errorlevel%

:menu
REM May add an CLS to clear checking message.
echo.
echo Welcome to HOSPOT10
echo Assembled by @DOKA
echo.
echo [*] Wifi "%ssid%" is currently : %running%
echo.
echo Press any key to stop the service.
pause > nul
NETSH WLAN stop hostednetwork
echo Goodbye!
timeout 2 >nul
exit


pause

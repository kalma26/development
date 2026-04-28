@echo off
title Git Update Menu
color 0A

REM Go to your project folder
cd /d "D:\01_RFDEV\update\"

:MENU
cls
echo ==================================
echo         GIT UPDATE MENU 
echo dev: MasterDoom , eD
echo ==================================
echo.
echo [1] Check Co Dev Update
echo [2] Update From You
echo [0] Exit
echo.

set /p choice=Enter option number: 

if "%choice%"=="1" goto PULL
if "%choice%"=="2" goto PUSH
if "%choice%"=="0" goto EXIT

echo Invalid option!
pause
goto MENU

:PULL
echo.
echo Running: git pull
git pull
if %ERRORLEVEL% neq 0 (
    echo Error during git pull
    pause
    goto MENU
)

echo.
echo Update checked successfully!
pause
goto MENU

:PUSH
echo.
echo Running: git add *
git add *
if %ERRORLEVEL% neq 0 (
    echo Error during git add
    pause
    goto MENU
)

REM Commit with current date and time
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do set DATE=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set TIME=%%a-%%b
set MSG=%DATE% %TIME%

echo Running: git commit -m "%MSG%"
git commit -m "%MSG%"
if %ERRORLEVEL% neq 0 (
    echo Error during git commit
    pause
    goto MENU
)

echo Running: git push
git push
if %ERRORLEVEL% neq 0 (
    echo Error during git push
    pause
    goto MENU
)

echo.
echo All Git commands completed successfully!
pause
goto MENU

:EXIT
exit
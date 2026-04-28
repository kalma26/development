@echo off
title Git Update Menu
color 0A
setlocal enabledelayedexpansion

REM Current folder
cd /d "%~dp0"

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
git pull
pause
goto MENU


:PUSH
git add .

REM Get updated files
set FILES=
for /f "delims=" %%f in ('git diff --cached --name-only') do (
    if "!FILES!"=="" (
        set FILES=%%f
    ) else (
        set FILES=!FILES!, %%f
    )
)

if "!FILES!"=="" (
    echo No changes detected.
    pause
    goto MENU
)

REM Get Date
for /f "delims=" %%a in ('powershell -command "Get-Date -Format yyyy-MM-dd"') do set GITDATE=%%a

REM Get Time
for /f "delims=" %%a in ('powershell -command "Get-Date -Format HH:mm:ss"') do set GITTIME=%%a

REM Final commit message format
set MSG=[Date: !GITDATE! ^| Time: !GITTIME!] Updated: !FILES!

echo.
echo !MSG!
echo.

git commit -m "!MSG!"
git push

pause
goto MENU


:EXIT
exit
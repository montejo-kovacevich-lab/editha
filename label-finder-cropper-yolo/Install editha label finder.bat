@echo off
rem One-time installer for the editha label finder (Windows).
rem Creates a private Python environment in the ".venv" folder next to this file
rem and installs everything the app needs. Nothing is installed system-wide.

setlocal
cd /d "%~dp0"

echo === editha label finder: installer ===
echo.

rem --- 1. Find a suitable Python (3.10 or newer) ---
set "PY="
where py >nul 2>&1
if not errorlevel 1 (
  py -3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)" >nul 2>&1
  if not errorlevel 1 set "PY=py -3"
)
if not defined PY (
  where python >nul 2>&1
  if not errorlevel 1 (
    python -c "import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)" >nul 2>&1
    if not errorlevel 1 set "PY=python"
  )
)
if not defined PY (
  echo ERROR: Python 3.10 or newer was not found.
  echo Download it from https://www.python.org/downloads/ and run the installer.
  echo IMPORTANT: tick "Add Python to PATH" on the first screen of the installer.
  echo Then double-click this file again.
  goto :fail
)
echo Using Python: %PY%

rem --- 2. Create the private environment ---
if not exist ".venv\Scripts\python.exe" (
  echo.
  echo Creating the environment...
  %PY% -m venv .venv
  if errorlevel 1 (
    echo ERROR: Could not create the Python environment.
    goto :fail
  )
)

rem --- 3. Install the packages ---
echo.
echo Installing packages. This takes several minutes and downloads about 2 GB.
echo Please stay on a good internet connection and leave this window open.
echo.
".venv\Scripts\python.exe" -m pip install --upgrade pip >nul 2>&1
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 (
  echo.
  echo ERROR: Installing the packages failed. Check your internet connection and double-click this file to try again.
  goto :fail
)

rem --- 4. Download the base model used for training ---
if not exist "yolov8s.pt" (
  echo.
  echo Downloading the base model ^(yolov8s.pt^)...
  ".venv\Scripts\python.exe" -c "from ultralytics import YOLO; YOLO('yolov8s.pt')"
  if errorlevel 1 (
    echo.
    echo ERROR: Downloading the base model failed. Check your internet connection and double-click this file to try again.
    goto :fail
  )
)

echo.
echo Installation complete.
echo From now on, double-click "Start editha label finder.bat" to open the app.
if not defined EDITHA_NO_PAUSE pause
exit /b 0

:fail
if not defined EDITHA_NO_PAUSE pause
exit /b 1

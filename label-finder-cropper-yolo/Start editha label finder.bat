@echo off
rem Starts the editha label finder (Windows). Installs it first if that has not been done.

setlocal
cd /d "%~dp0"

set "NEEDS_INSTALL="
if not exist ".venv\Scripts\python.exe" set "NEEDS_INSTALL=1"
if not exist "yolov8s.pt" set "NEEDS_INSTALL=1"
if defined NEEDS_INSTALL (
  echo First run: installing before starting...
  set "EDITHA_NO_PAUSE=1"
  call "Install editha label finder.bat"
  if errorlevel 1 (
    echo.
    pause
    exit /b 1
  )
)

rem Streamlit asks for an email address in the terminal on first run, which would
rem block the app from starting. An empty credentials file skips that question.
if not exist "%USERPROFILE%\.streamlit\credentials.toml" (
  if not exist "%USERPROFILE%\.streamlit" mkdir "%USERPROFILE%\.streamlit"
  > "%USERPROFILE%\.streamlit\credentials.toml" (
    echo [general]
    echo email = ""
  )
)

echo === editha label finder ===
echo.
echo The app opens in your web browser in a moment.
echo LEAVE THIS WINDOW OPEN while you work. Closing it stops the app.
echo When you are finished, close the browser tab and then this window.
echo.

".venv\Scripts\python.exe" -m streamlit run app.py
pause

#!/bin/bash
# Starts the editha label finder (macOS). Installs it first if that has not been done.

cd "$(dirname "$0")" || exit 1

if [ ! -x .venv/bin/python ] || [ ! -f yolov8s.pt ]; then
  echo "First run: installing before starting..."
  EDITHA_NO_PAUSE=1 bash "./Install editha label finder.command" || {
    echo
    read -n 1 -s -r -p "Press any key to close this window..."
    exit 1
  }
fi

# Streamlit asks for an email address in the terminal on first run, which would
# block the app from starting. An empty credentials file skips that question.
if [ ! -f "$HOME/.streamlit/credentials.toml" ]; then
  mkdir -p "$HOME/.streamlit"
  printf '[general]\nemail = ""\n' > "$HOME/.streamlit/credentials.toml"
fi

echo "=== editha label finder ==="
echo
echo "The app opens in your web browser in a moment."
echo "LEAVE THIS WINDOW OPEN while you work. Closing it stops the app."
echo "When you are finished, close the browser tab and then this window."
echo

.venv/bin/python -m streamlit run app.py

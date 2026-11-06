#!/bin/bash
# One-time installer for the editha label finder (macOS).
# Creates a private Python environment in the ".venv" folder next to this file
# and installs everything the app needs. Nothing is installed system-wide.

cd "$(dirname "$0")" || exit 1

pause() {
  # Keep the window open so the user can read the message (skipped when
  # called from the Start script).
  if [ -z "$EDITHA_NO_PAUSE" ]; then
    echo
    read -n 1 -s -r -p "Press any key to close this window..."
    echo
  fi
}

fail() {
  echo
  echo "ERROR: $1"
  pause
  exit 1
}

echo "=== editha label finder: installer ==="
echo

# --- 1. Find a suitable Python (3.10 or newer) ---------------------------------
PY=""
for candidate in python3.12 python3.11 python3.13 python3.10 python3.14 python3; do
  if command -v "$candidate" >/dev/null 2>&1 &&
     "$candidate" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)' >/dev/null 2>&1; then
    PY="$candidate"
    break
  fi
done

if [ -z "$PY" ]; then
  fail "Python 3.10 or newer was not found.
Download it from https://www.python.org/downloads/ , run the installer,
then double-click this file again."
fi
echo "Using $($PY --version) ($(command -v "$PY"))"

# --- 2. Create the private environment -----------------------------------------
if [ ! -x .venv/bin/python ]; then
  echo
  echo "Creating the environment..."
  "$PY" -m venv .venv || fail "Could not create the Python environment."
fi

# --- 3. Install the packages ----------------------------------------------------
echo
echo "Installing packages. This takes several minutes and downloads about 2 GB."
echo "Please stay on a good internet connection and leave this window open."
echo
.venv/bin/python -m pip install --upgrade pip >/dev/null 2>&1
.venv/bin/python -m pip install -r requirements.txt ||
  fail "Installing the packages failed. Check your internet connection and double-click this file to try again."

# --- 4. Download the base model used for training ------------------------------
if [ ! -f yolov8s.pt ]; then
  echo
  echo "Downloading the base model (yolov8s.pt)..."
  .venv/bin/python -c "from ultralytics import YOLO; YOLO('yolov8s.pt')" ||
    fail "Downloading the base model failed. Check your internet connection and double-click this file to try again."
fi

echo
echo "Installation complete."
echo "From now on, double-click 'Start editha label finder.command' to open the app."
pause

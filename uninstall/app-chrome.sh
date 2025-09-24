#!/bin/bash

if command -v google-chrome >/dev/null 2>&1; then
  sudo apt remove -y google-chrome-stable
fi

if command -v snap >/dev/null 2>&1 && snap list 2>/dev/null | grep -q '^chromium\s'; then
  sudo snap remove chromium
fi

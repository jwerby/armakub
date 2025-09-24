#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Sync files across machines using https://dropbox.com
if [ "$OMAKUB_DEB_ARCH" != "amd64" ]; then
  echo "Skipping Dropbox install: nautilus-dropbox package targets amd64 only."
  omakub_return
  return
fi

sudo apt install -y nautilus-dropbox >/dev/null

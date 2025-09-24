#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

if [ "$OMAKUB_ARCH" != "x86_64" ]; then
  echo "Skipping Ollama install: upstream installer does not support architecture $OMAKUB_ARCH"
  omakub_return
  return
fi

curl -fsSL https://ollama.com/install.sh | sh

#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

if [ "$OMAKUB_ARCH" != "x86_64" ]; then
  echo "Skipping RubyMine install: snap package currently targets x86_64 only."
  omakub_return
  return
fi

sudo snap install rubymine --classic

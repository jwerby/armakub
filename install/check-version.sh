#!/bin/bash

if [ ! -f /etc/os-release ]; then
  echo "$(tput setaf 1)Error: Unable to determine OS. /etc/os-release file not found."
  echo "Installation stopped."
  exit 1
fi

. /etc/os-release

# Check if running on Ubuntu 24.04 or higher
if [ "$ID" != "ubuntu" ] || [ $(echo "$VERSION_ID >= 24.04" | bc) != 1 ]; then
  echo "$(tput setaf 1)Error: OS requirement not met"
  echo "You are currently running: $ID $VERSION_ID"
  echo "OS required: Ubuntu 24.04 or higher"
  echo "Installation stopped."
  exit 1
fi

# Determine supported architectures and expose helpers for other installers
ARCH_RAW=$(uname -m)
case "$ARCH_RAW" in
  x86_64|amd64)
    OMAKUB_ARCH="x86_64"
    OMAKUB_DEB_ARCH="amd64"
    ;;
  i686|i386)
    OMAKUB_ARCH="i686"
    OMAKUB_DEB_ARCH="i386"
    ;;
  aarch64|arm64)
    OMAKUB_ARCH="aarch64"
    OMAKUB_DEB_ARCH="arm64"
    ;;
  *)
    echo "$(tput setaf 1)Error: Unsupported architecture detected"
    echo "Current architecture: $ARCH_RAW"
    echo "This installation is only supported on x86 (x86_64/i686) or ARM64 (aarch64)."
    echo "Installation stopped."
    exit 1
    ;;
esac

export OMAKUB_ARCH
export OMAKUB_DEB_ARCH

if [ "$OMAKUB_ARCH" = "aarch64" ]; then
  echo "$(tput setaf 3)Notice: Running on ARM64 (aarch64). Some optional apps may be skipped if upstream packages are unavailable.$(tput sgr0)"
fi

omakub_return() {
  return 0 2>/dev/null || exit 0
}

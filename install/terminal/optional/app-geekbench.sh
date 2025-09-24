#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

GB_VERSION="6.4.0"

case "$OMAKUB_ARCH" in
  x86_64)
    GEEKBENCH_PACKAGE="Geekbench-${GB_VERSION}-Linux"
    ;;
  aarch64)
    GEEKBENCH_PACKAGE="Geekbench-${GB_VERSION}-LinuxARMPreview"
    ;;
  *)
    echo "Skipping Geekbench install: no package available for architecture $OMAKUB_ARCH"
    omakub_return
    return
    ;;
esac

cd /tmp
gum spin --title "Downloading Geekbench $GB_VERSION..." -- \
  curl -sLo geekbench.tar.gz "https://cdn.geekbench.com/${GEEKBENCH_PACKAGE}.tar.gz"
gum spin --title "Extracting Geekbench $GB_VERSION..." -- \
  tar -xzf geekbench.tar.gz
sudo mv "${GEEKBENCH_PACKAGE}" /usr/local/geekbench6
sudo ln -sf /usr/local/geekbench6/geekbench6 /usr/local/bin/geekbench6
rm -rf Geekbench* geekbench.tar.gz
cd -
echo "Run as geekbench6 from the terminal"

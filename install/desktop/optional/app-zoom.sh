#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

# Make video calls using https://zoom.us/
if [ "$OMAKUB_DEB_ARCH" != "amd64" ] && [ "$OMAKUB_DEB_ARCH" != "arm64" ]; then
  echo "Skipping Zoom install: no package available for architecture $OMAKUB_DEB_ARCH"
  omakub_return
  return
fi

cd /tmp
ZOOM_PACKAGE="zoom_${OMAKUB_DEB_ARCH}.deb"
wget "https://zoom.us/client/latest/${ZOOM_PACKAGE}"
sudo apt install -y "./${ZOOM_PACKAGE}"
rm "${ZOOM_PACKAGE}"
cd -

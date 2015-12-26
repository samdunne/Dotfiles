#!/usr/bin/env bash

# Might as well ask for password up-front, right?
sudo -v

xcode-select --install
xcrun cc

find ./setup -name "*.sh" | while read -r script
do
  chmod a+x "$script"
  /usr/bin/env bash "$script"
done

# Install the appropriate bash files
chmod a+x sync.sh
/usr/bin/env bash sync.sh -f

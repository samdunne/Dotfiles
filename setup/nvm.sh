#!/usr/bin/env bash

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
source ~/.bashrc
nvm install v4.2.1
nvm use 4.2.1
nvm alias default 4.2.

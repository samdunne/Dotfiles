#!/usr/bin/env bash

git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`

source ~/.bashrc
nvm install 5.0
nvm use 5.0
nvm alias default node

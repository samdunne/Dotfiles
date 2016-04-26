#!/usr/bin/env bash

brew install nvm
mkdir -p $HOME/.nvm

source ~/.bash_profile

nvm install 5.0
nvm use 5.0
nvm alias default node

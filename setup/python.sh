#!/usr/bin/env bash

brew install python --with-brewed-openssl
pip install virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1
virtualenv ~/.virtualenvs/default
source ~/.bashrc
pip install Pygments

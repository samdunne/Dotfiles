#!/usr/bin/env bash

brew install python pyenv-virtualenvwrapper --with-brewed-openssl

mkdir -p $HOME/.virtualenvs

source ~/.bash_profile

mkvirtualenv default
workon default
pip install Pygments

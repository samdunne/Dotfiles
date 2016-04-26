#!/usr/bin/env bash

brew install python --with-brewed-openssl
pip install virtualenv virtualenvwrapper

mkdir -p $HOME/.virtualenvs

source ~/.bash_profile

mkvirtualenv default
workon default
pip install Pygments

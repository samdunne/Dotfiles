#!/usr/bin/env bash

brew install python --with-brewed-openssl
pip install virtualenv

source ~/.bashrc

virtualenv ~/.virtualenvs/default
pip install Pygments

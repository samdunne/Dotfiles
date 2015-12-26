#!/usr/bin/env bash

curl -L https://get.rvm.io | bash -s stable
source ~/.bashrc
rvm install ruby-2.1.7
rvm use 2.1.7
rvm --default use 2.1.7
gem install berkshelf test-kitchen kitchen-vagrant kitchen-docker rubocop foodcritic chef serverspec rspec maid chunky_png whenever exifr

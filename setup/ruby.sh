#!/usr/bin/env bash

brew install --HEAD https://raw.github.com/postmodern/gem_home/master/homebrew/gem_home.rb

# Get Ruby install
brew install ruby-install
ruby-install --system ruby 2.2

# Support changing ruby
brew install chruby
chruby ruby-2.3.0
gem_home -

source ~/.bashrc

gem install berkshelf test-kitchen kitchen-vagrant \
  kitchen-docker rubocop foodcritic \
  chef serverspec rspec \
  maid chunky_png whenever \
  exifr rsense rails_best_practices \
  awesome_print

#!/usr/bin/env bash

brew install --HEAD https://raw.github.com/postmodern/gem_home/master/homebrew/gem_home.rb

brew install gdbm libffi libyaml openssl readline
brew install gcc48

# Get Ruby install
brew install ruby-install
ruby-install ruby 2.0
ruby-install ruby 2.1
ruby-install ruby 2.2
ruby-install ruby 2.3

# Support changing ruby
brew install chruby

source ~/.bash_profile

chruby ruby-2.3
gem_home $HOME

gem install berkshelf test-kitchen kitchen-vagrant \
  kitchen-docker rubocop foodcritic \
  chef serverspec rspec \
  maid chunky_png whenever \
  exifr rsense rails_best_practices \
  awesome_print

berks configure

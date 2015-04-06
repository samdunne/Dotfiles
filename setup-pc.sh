#!/usr/bin/env bash

# Homebrew
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  if "$( which apt-get )" 2> /dev/null; then
   sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
  elif "$( which yum )" 2> /dev/null; then
    sudo yum groupinstall 'Development Tools' && sudo yum install curl git irb m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel
  else
    echo "I have no idea what I'm doing." >&2
    exit 1
  fi

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "I have no idea what I'm doing." >&2
  exit 1
fi

brew tap Homebrew/brewdler
brew brewdle
brew update
brew upgrade
brew cleanup
brew brewdle cleanup

# NPM
\curl -L https://www.npmjs.org/install.sh | bash;
source ~/.bash_profile
npm install -g grunt-cli http-server uglify-js jshint yo node-inspector forever nodemon uncss

# RVM
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.3 --gems=rails,pry,bundler,exifr,maid,whenever,chunky_png

# for the c alias (syntax highlighted cat)
sudo easy_install Pygments

if [[ "$OSTYPE" == "darwin"* ]]; then
  ./.osx
fi

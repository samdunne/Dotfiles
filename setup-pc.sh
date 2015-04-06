#!/usr/bin/env bash

# Might as well ask for password up-front, right?
sudo -v

# Homebrew
if [[ "$OSTYPE" =~ linux-gnu ]]; then
  if hash apt-get 2> /dev/null; then
   apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
  elif hash yum 2> /dev/null; then
    yum groupinstall 'Development Tools'
    yum install curl git irb m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel
  else
    echo "Package manager not supported." >&2
    exit 1
  fi

  # We don't need sudo past this point
  sudo -K

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
elif [[ "$OSTYPE" =~ ^darwin ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "OS not supported." >&2
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

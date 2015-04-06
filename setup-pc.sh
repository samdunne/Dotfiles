#!/usr/bin/env bash

# Might as well ask for password up-front, right?
sudo -v

# Homebrew
if [[ "$OSTYPE" =~ linux-gnu ]]; then
  if hash apt-get 2> /dev/null; then
   sudo apt-get -y install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
  elif hash yum 2> /dev/null; then
    sudo yum -y groupinstall 'Development Tools'
    sudo yum -y install curl git irb m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel
  else
    echo "Package manager not supported." >&2
    exit 1
  fi

  # We don't need sudo past this point
  sudo -K

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"

  export PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
elif [[ "$OSTYPE" =~ ^darwin ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "OS not supported." >&2
  exit 1
fi

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

# Execute homebrew installation
chmod a+x
/usr/bin/env bash .brew

# NPM
command curl -L https://www.npmjs.org/install.sh | bash;
. ~/.bash_profile
npm install -g grunt-cli http-server uglify-js jshint yo node-inspector forever nodemon uncss

# RVM
command curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.3 --gems=rails,pry,bundler,exifr,maid,whenever,chunky_png

# for the c alias (syntax highlighted cat)
sudo easy_install Pygments

if [[ "$OSTYPE" == "darwin"* ]]; then
  ./.osx
fi

# Install the appropriate bash files
chmod a+x rootkit.sh
/usr/bin/env bash roothkit.sh -f

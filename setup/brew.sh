#!/usr/bin/env bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

fancy_echo() {
  local fmt
  fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

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
  local name
  name="$(brew_expand_alias "$1")"
  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name
  name="$(brew_expand_alias "$1")"
  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

taps=(
  'caskroom/cask'
  'caskroom/versions'
  'homebrew/brewdler'
  'homebrew/services'
  'homebrew/dupes'
  'homebrew/games'
  'homebrew/versions'
  'homebrew/x11'
  'thoughtbot/formulae'
)

packages=(
  'ack'
  'android-sdk'
  'apple-gcc42'
  'autoconf'
  'automake'
  'bash'
  'bash-completion'
  'brew-cask'
  'cabal-install'
  'cask'
  'cloog'
  'cmake'
  'cntlm'
  'coreutils'
  'cscope'
  'ctags'
  'docker'
  'ffmpeg'
  'fig'
  'findutils'
  'foremost'
  'freetype'
  'elasticsearch'
  'gcc'
  'gecode'
  'gettext'
  'ghc'
  'gist'
  'git'
  'git-extras'
  'gmp'
  'gnu-sed'
  'go'
  'grep'
  'gnupg'
  'hub'
  'imagemagick'
  'isl'
  'jpeg'
  'jq'
  'lame'
  'lesstif'
  'libevent'
  'libgpg-error'
  'libiconv'
  'libksba'
  'libmpc'
  'libogg'
  'libpng'
  'libtiff'
  'libtool'
  'libvo-aacenc'
  'libvorbis'
  'libxml2'
  'lua'
  'luajit'
  'lynx'
  'maven'
  'moreutils'
  'mpfr'
  'mysql'
  'narwhal'
  'ncurses'
  'ngrep'
  'nmap'
  'openssl'
  'ossp-uuid'
  'p7zip'
  'pcre'
  'pigz'
  'pkg-config'
  'postgresql'
  'privoxy'
  'pv'
  'rcm'
  'reattach-to-user-namespace'
  'redis'
  'rename'
  'screen'
  'sdl2'
  'shellcheck'
  'sqlite'
  'sqlmap'
  'ssh-copy-id'
  'tree'
  'ucspi-tcp'
  'uncrustify'
  'unixodbc'
  'vim'
  'watch'
  'webkit2png'
  'wget'
  'wxmac'
  'x264'
  'xpdf'
  'xvid'
  'xz'
  'zopfli'
)

casks=(
  '1password'
  'atom'
  'charles'
  'caffeine'
  'google-chrome'
  'chefdk'
  'consul'
  'dropbox'
  'terraform'
  'packer'
  'virtualbox'
  'vlc'
  'iterm2'
  'spotify'
  'slack'
  'the-unarchiver'
  'viscosity'
  'wireshark'
  'twitter'
  'tigervnc-viewer'
  'vmware-fusion'
)

# These are pre-requisites for certain software
brew install Caskroom/cask/java
brew install Caskroom/cask/xquartz

for i in "${taps[@]}"
do
  brew_tap "$i"
done

for i in "${packages[@]}"
do
  brew_install_or_upgrade "$i"
done

for i in "${casks[@]}"
do
  brew cask install "$i"
done

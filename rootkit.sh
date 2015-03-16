#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude ".brew" --exclude ".install_rvm" \
		--exclude ".install_npm" --exclude ".brewcasks" --exclude ".brewfile" --exclude ".brewtaps" -abviuzP --no-perms . ~;
	chmod +x .install_rvm .install_npm .brew;
	./.brew;
	./.install_rvm;
	./.install_npm;
	source $HOME/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
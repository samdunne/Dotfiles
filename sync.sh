#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")" || exit;

git pull origin master;

function run() {
	rsync --exclude-from .sync-ignore -avh --no-perms . ~;
	. ~/.bash_profile;
  update;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	run;
else
	read -pr "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		run;
	fi;
fi;
unset run;

maid clean -fr ~/.maid/rules.rb

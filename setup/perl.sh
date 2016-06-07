#!/usr/bin/env bash

\curl -L http://install.perlbrew.pl | bash

export PERLBREW_ROOT="$HOME/.perlbrew"
export PERLBREW_HOME="$HOME/.perlbrew"

perlbrew install perl-5.16.0
perlbrew switch perl-5.16.0

perl -MCPAN -e 'install Perl::Critic'

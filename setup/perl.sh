#!/usr/bin/env bash

\curl -L http://install.perlbrew.pl | bash

perlbrew install perl-5.16.0
perlbrew switch perl-5.16.0

perl -MCPAN -e 'install Perl::Critic'

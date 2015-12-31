#!/bin/bash -x
# puppetmaster/run.sh - Invoke the puppetmaste container mounting the local
# directory as /etc/puppet/environments/production
#
sudo /usr/bin/docker run \
    --hostname puppet.localdomain \
    --name puppetmaster \
    --interactive \
    --tty=true \
    --volume="$PWD":/etc/puppet/environments/production:Z \
    bkorren/puppetmaster \
    "$@"


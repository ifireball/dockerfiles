#!/bin/bash -e
mkdir -p '/etc/zuul'

if [[ ! -e '/etc/zuul/zuul.conf' ]]; then
    cp '/usr/share/zuul/zuul.conf.template' '/etc/zuul/zuul.conf'
fi

if [[ ! -d '/etc/zuul/ssh' ]]; then
    install -m 700 -d '/etc/zuul/ssh'
fi

if [[ ! -e '/etc/zuul/ssh/id_rsa' ]]; then
    ssh-keygen -b 2048 -t rsa -N '' -f '/etc/zuul/ssh/id_rsa'
fi

if [[ ! -e "$HOME/.ssh/known_hosts" ]]; then
    install -m 700 -d "$HOME/.ssh"
    ln -s '/etc/zuul/ssh/known_hosts' "$HOME/.ssh/known_hosts"
fi

exec zuul-merger -d


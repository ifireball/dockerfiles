#!/bin/bash -e
ZUUL_USER=default
ZUUL_HOME="$(getent passwd "$ZUUL_USER" | cut -d: -f6)"

SSH_DIR="$ZUUL_HOME/.ssh"
if [[ ! -d "$SSH_DIR" ]]; then
    install -o "$ZUUL_USER" -m 700 -d "$SSH_DIR"
fi

if [[ ! -e "$GERRIT_SSH_KEY" ]]; then
    # If we don't have an SSH key provided, generate it
    ssh-keygen -b 2048 -t rsa -N '' -f "$GERRIT_SSH_KEY"
fi
# We need to copy the private key to our own location so the file
# will have the right permissions
SSH_KEY="$SSH_DIR/id_rsa"
install -o "$ZUUL_USER" -m 600 "$GERRIT_SSH_KEY" "$SSH_KEY"

if [[ ! -e "$SSH_DIR/known_hosts" ]]; then
    /usr/bin/ssh-keyscan -t rsa -p "$GERRIT_PORT" "$GERRIT_SERVER" \
        | sed -re "s|^(${GERRIT_SERVER//.\\./})|[\1]:$GERRIT_PORT|" \
        > "$SSH_DIR/known_hosts"
    chown "$ZUUL_USER" "$SSH_DIR/known_hosts"
fi

mkdir -p '/etc/zuul'

if [[ ! -e '/etc/zuul/zuul.conf' ]]; then
    sed \
        -e "s|__GERRIT_SERVER__|$GERRIT_SERVER|" \
        -e "s|__GERRIT_PORT__|$GERRIT_PORT|" \
        -e "s|__GERRIT_BASEURL__|$GERRIT_BASEURL|" \
        -e "s|__GERRIT_USER__|$GERRIT_USER|" \
        -e "s|__GERRIT_SSH_KEY__|$SSH_KEY|" \
        '/usr/share/zuul/zuul.conf.template' > '/etc/zuul/zuul.conf'
fi

if [[ ! -e '/etc/zuul/layout/layout.yaml' ]]; then
    cp '/usr/share/zuul/layout.yaml.template' '/etc/zuul/layout/layout.yaml'
fi

exec runuser -u "$ZUUL_USER" -- zuul-server -d

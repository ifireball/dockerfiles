#!/bin/bash

if [[ $GERRIT_ADMIN_USER && $GERRIT_ADMIN_PRIVATE_KEY ]] &&
    [[ ! -e "$GERRIT_ADMIN_PRIVATE_KEY" ]]
then
    (
        set -ex
        ssh-keygen -b 4096 -t rsa -f "$GERRIT_ADMIN_PRIVATE_KEY" -q \
            -N "" -C "$GERRIT_ADMIN_EMAIL"
    )
    if (( $? )); then
        echo "Failed to create admin user keys, aborting"
        exit 1
    fi
fi

if [[ $GERRIT_ACCOUNTS && $GERRIT_PUBLIC_KEYS_PATH ]]; then
    (
        set -ex
        cd "$GERRIT_PUBLIC_KEYS_PATH"
        IFS=\;
        for account in $GERRIT_ACCOUNTS; do
            IFS=,
            read user fullname email rest <<<"$account"
            key_name="id_${user}_rsa"
            [[ -e "$key_name" ]] && continue
            ssh-keygen -b 4096 -t rsa -f "$key_name" -q -N "" -C "$email"
        done
    )
    if (( $? )); then
        echo "Failed to create user keys, aborting"
        exit 1
    fi
fi

exec "$GERRIT_HOME/bin/conf-and-run-gerrit.sh"

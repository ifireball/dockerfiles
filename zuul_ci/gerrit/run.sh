#!/bin/bash -x
DIRS=(/tmp/zuul-gerrit/site /tmp/zuul-gerrit/ssh-keys)
for dir in "${DIRS[@]}"; do
    [[ -d "$dir" ]] && continue
    sudo install -o 1000 -g 1000 -d "$dir"
done
sudo docker run -d \
    -e AUTH_TYPE='DEVELOPMENT_BECOME_ANY_ACCOUNT' \
    -v /tmp/zuul-gerrit/site:/home/gerrit/site:Z \
    -v /tmp/zuul-gerrit/ssh-keys:/home/gerrit/ssh-keys:Z \
    --name zuul-gerrit \
    docker.io/fabric8/gerrit:latest
sudo docker inspect \
    -f $'Container running at: {{.NetworkSettings.IPAddress}} With ports: {{range $k, $v := .NetworkSettings.Ports}}{{$k}} {{end}}' \
    zuul-gerrit

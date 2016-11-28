#!/bin/bash -x
DIRS=(/tmp/zuul/conf /tmp/zuul-server/state)
for dir in "${DIRS[@]}"; do
    [[ -d "$dir" ]] && continue
    sudo install -o 1001 -g 0 -d "$dir"
done
sudo docker run -d \
    -v /tmp/zuul/conf:/etc/zuul:z \
    -v /tmp/zuul-server/state:/var/lib/zuul:Z \
    --name zuul-server \
    zuul_server:latest
sudo docker inspect \
    -f $'Container running at: {{.NetworkSettings.IPAddress}} With ports: {{range $k, $v := .NetworkSettings.Ports}}{{$k}} {{end}}' \
    zuul-server


#!/bin/bash -x
DIRS=(/tmp/zuul/conf /tmp/zuul-merger/state /tmp/zuul/git)
for dir in "${DIRS[@]}"; do
    [[ -d "$dir" ]] && continue
    sudo install -o 1001 -g 0 -d "$dir"
done
sudo docker run -d \
    -v /tmp/zuul/conf:/etc/zuul:z \
    -v /tmp/zuul-merger/state:/var/lib/zuul:Z \
    -v /tmp/zuul/git:/git:z \
    --name zuul-merger \
    zuul_merger:latest
sudo docker inspect \
    -f $'Container running at: {{.NetworkSettings.IPAddress}} With ports: {{range $k, $v := .NetworkSettings.Ports}}{{$k}} {{end}}' \
    zuul-merger



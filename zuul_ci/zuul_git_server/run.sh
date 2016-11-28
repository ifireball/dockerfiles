#!/bin/bash -x
DIRS=(/tmp/zuul/git)
for dir in "${DIRS[@]}"; do
    [[ -d "$dir" ]] && continue
    sudo install -o 1001 -g 0 -d "$dir"
done
sudo docker run -d \
    -v /tmp/zuul/git:/git:z \
    --name zuul-git-server \
    zuul_git_server:latest
sudo docker inspect \
    -f $'Container running at: {{.NetworkSettings.IPAddress}} With ports: {{range $k, $v := .NetworkSettings.Ports}}{{$k}} {{end}}' \
    zuul-git-server




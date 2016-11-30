#!/bin/bash -x
sudo docker run -d \
    --name zuul-ui-server \
    zuul_ui_server:latest
sudo docker inspect \
    -f $'Container running at: {{.NetworkSettings.IPAddress}} With ports: {{range $k, $v := .NetworkSettings.Ports}}{{$k}} {{end}}' \
    zuul-ui-server





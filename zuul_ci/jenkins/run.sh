#!/bin/bash -x
sudo docker run -d \
    -e JENKINS_PASSWORD=admin \
    -v /tmp/zuul-jenkins:/var/lib/jenkins:Z \
    --name zuul-jenkins \
    zuul-jenkins:latest
sudo docker inspect \
    -f $'Container running at: {{.NetworkSettings.IPAddress}} With ports: {{range $k, $v := .NetworkSettings.Ports}}{{$k}} {{end}}' \
    zuul-jenkins

FROM zuul_base:latest
MAINTAINER Barak Korren <bkorren@redhat.com>

EXPOSE 8001
EXPOSE 4730

VOLUME /etc/zuul/layout /etc/zuul/ssh

ENV \
    GERRIT_SERVER=gerrit.example.com \
    GERRIT_PORT=29418 \
    GERRIT_BASEURL=http://gerrit.example.com:8080/ \
    GERRIT_USER=zuul \
    GERRIT_SSH_KEY=/etc/zuul/ssh/id_zuul_rsa

CMD start_zuul_server.sh

ADD zuul.conf.template /usr/share/zuul/zuul.conf.template
ADD layout.yaml.template /usr/share/zuul/layout.yaml.template
ADD start_zuul_server.sh /usr/local/bin

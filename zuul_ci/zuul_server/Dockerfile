FROM zuul_base:latest
MAINTAINER Barak Korren <bkorren@redhat.com>

EXPOSE 8001
EXPOSE 4730

CMD start_zuul_server.sh

ADD zuul.conf.template /usr/share/zuul/zuul.conf.template
ADD layout.yaml.template /usr/share/zuul/layout.yaml.template
ADD start_zuul_server.sh /usr/local/bin

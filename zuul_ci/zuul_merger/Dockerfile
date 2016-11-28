FROM zuul_base:latest
MAINTAINER Barak Korren <bkorren@redhat.com>

VOLUME /git

CMD start_zuul_merger.sh

ADD zuul.conf.template /usr/share/zuul/zuul.conf.template
ADD start_zuul_merger.sh /usr/local/bin


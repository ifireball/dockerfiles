FROM centos:centos7
MAINTAINER Barak Korren <bkorren@redhat.com>
EXPOSE 3128

CMD /usr/sbin/squid -f /etc/squid/squid.conf -N

RUN yum install -y squid

USER squid

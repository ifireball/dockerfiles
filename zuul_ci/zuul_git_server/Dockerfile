FROM openshift/base-centos7
MAINTAINER Barak Korren <bkorren@redhat.com>
VOLUME /git
EXPOSE 80

CMD httpd -DFOREGROUND

USER root

ADD zuul_git.conf /etc/httpd/conf.d/zuul_git.conf

RUN yum install -y httpd

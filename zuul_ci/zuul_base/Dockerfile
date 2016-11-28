FROM openshift/python-27-centos7
MAINTAINER Barak Korren <bkorren@redhat.com>
RUN scl enable python27 -- pip install --user zuul
USER root
RUN install -o default -g root -m 755 -d /var/lib/zuul
USER default
VOLUME ["/etc/zuul", "/var/lib/zuul"]

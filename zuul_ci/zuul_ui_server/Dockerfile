FROM openshift/base-centos7
MAINTAINER Barak Korren <bkorren@redhat.com>
EXPOSE 80

CMD httpd -DFOREGROUND

USER root

ADD zuul_ui.conf /etc/httpd/conf.d/zuul_ui.conf

RUN yum install -y httpd && \
    git clone --branch 2.5.1 --depth 1 \
        https://git.openstack.org/openstack-infra/zuul \
        /opt/zuul && \
    /opt/zuul/etc/status/fetch-dependencies.sh



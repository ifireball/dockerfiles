FROM centos:7
MAINTAINER bkorren@redhat.com
RUN ["yum", "install", "-y", "epel-release", "centos-release-scl"]
RUN ["yum", "install", "-y", "puppet-server"]
COPY puppet.conf /etc/puppet/puppet.conf
EXPOSE 8140
VOLUME ["/etc/puppet/environments/production"]
ENTRYPOINT ["/usr/bin/puppet", "master", "--no-daemonize", "--logdest", "console"]

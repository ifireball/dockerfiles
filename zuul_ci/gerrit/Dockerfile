FROM docker.io/fabric8/gerrit:latest
MAINTAINER Barak Korren <bkorren@redhat.com>

CMD ${GERRIT_HOME}/bin/make-users-and-run-gerrit.sh

ADD ./make-users-and-run-gerrit.sh ${GERRIT_HOME}/bin

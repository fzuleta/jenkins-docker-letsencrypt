FROM jenkins/jenkins:lts
USER root

RUN apt-get update
RUN apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

RUN curl -fsSL get.docker.com | sh
RUN usermod -aG docker jenkins

ENV JAVA_OPTS="-Xmx2048m"
ENV JENKINS_OPTS=" --handlerCountMax=300"

RUN /usr/local/bin/install-plugins.sh nodejs global-build-stats docker-plugin github-pullrequest

RUN usermod -aG docker jenkins

USER jenkins
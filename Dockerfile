FROM ubuntu:16.04

RUN apt-get update -qq
RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN add-apt-repository "deb http://packages.cloud.google.com/apt cloud-sdk-xenial main"

RUN apt-get update -qq
RUN apt-get install -y apt-utils
RUN apt-get install -y --allow-unauthenticated docker-ce
RUN apt-get install -y google-cloud-sdk jq

# run complex setup
COPY setup.sh /setup.sh
RUN chmod a+x /setup.sh
RUN /setup.sh

# install latest git
RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update -qq && apt-get install -y git

# remove and clean up apt
RUN add-apt-repository -r "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN add-apt-repository -r "deb http://packages.cloud.google.com/apt cloud-sdk-xenial main"
RUN apt-get update -qq || true
RUN apt autoremove --purge || true
RUN rm -rf /var/lib/apt/lists/*
RUN apt clean || true
RUN rm -rf /tmp/*
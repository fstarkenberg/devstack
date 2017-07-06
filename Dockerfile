FROM ubuntu:16.04
LABEL maintainer="Fredrik Starkenberg"

RUN set -x \
	&& useradd -s /bin/bash -d /opt/stack -m stack \
    && apt-get update --quiet \
    && apt-get install --quiet --yes sudo git lsb-release net-tools iptables ebtables bsdmainutils python-pip bridge-utils \
    && apt-get clean \
    && pip install -U os-testr \
    && echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack \
    && git clone https://git.openstack.org/openstack-dev/devstack /opt/stack/devstack \
    && chown -R stack:stack /opt/stack

USER stack:stack
WORKDIR /opt/stack

EXPOSE 80 8080 35357 5000 5900 6080 8004 8386 8774 8776 8777 9292 9696
VOLUME ["/opt/stack"]


CMD "/opt/stack/devstack/stack.sh"

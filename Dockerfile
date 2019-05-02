FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        python3-dev \
        build-essential \
        python3-pip \
        libffi-dev \
        libssl-dev \
        xmlsec1 \
        libyaml-dev \
        wget

ENV SATOSA_PIP_TARGET=git+git://github.com/IdentityPython/SATOSA.git@49da5d4c0ac1a5ebf1a71b4f7aaf04f0e52d8fdb

RUN pip3 install --upgrade pip setuptools
RUN pip3 install ldap3
RUN pip3 install ${SATOSA_PIP_TARGET}

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps
ENTRYPOINT ["/tmp/satosa/start.sh"]

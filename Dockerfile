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

# Build from the head of SATOSA master
ENV SATOSA_PIP_TARGET=git+git://github.com/IdentityPython/SATOSA.git@79abc46f9a870048b9600357cca4ab9e86df8b57

# Build pysaml2 using a specific PR until merged
ENV PYSAML2_PIP_TARGET=git+git://github.com/IdentityPython/pysaml2.git@refs/pull/621/merge

RUN pip3 install --upgrade pip setuptools
RUN pip3 install ldap3
RUN pip3 install ${PYSAML2_PIP_TARGET}
RUN pip3 install ${SATOSA_PIP_TARGET}

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps
ENTRYPOINT ["/tmp/satosa/start.sh"]

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

# Build from PR 246 until it is merged
ENV SATOSA_PIP_TARGET=git+git://github.com/IdentityPython/SATOSA.git@refs/pull/246/merge

# Build pysaml2 using a specific commit
ENV PYSAML2_PIP_TARGET=git+git://github.com/IdentityPython/pysaml2.git@322a5f64006cf795179005f772b494e6030028bb

RUN pip3 install --upgrade pip setuptools
RUN pip3 install ldap3
RUN pip3 install ${PYSAML2_PIP_TARGET}
RUN pip3 install ${SATOSA_PIP_TARGET}

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps

# Set language to prevent errors when breaking
# into the container to run satosa-saml-metadata.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENTRYPOINT ["/tmp/satosa/start.sh"]

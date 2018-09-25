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

ENV SATOSA_PIP_TARGET=git+git://github.com/skoranda/SATOSA.git@ebc5a5fbb52f56f70afa42f7c24eac5d11eb1c7c
ENV SATOSA_MICROSERVICES_SRC_URL=https://github.com/IdentityPython/satosa_microservices/archive/master.tar.gz

RUN pip3 install --upgrade pip setuptools
RUN pip3 install ${SATOSA_PIP_TARGET}

RUN wget -O satosa_microservices.tar.gz ${SATOSA_MICROSERVICES_SRC_URL} \
    && mkdir -p /opt/satosa_microservices \
    && tar -zxf satosa_microservices.tar.gz -C /opt/satosa_microservices --strip-components=1 \
    && rm -f satosa_microservices.tar.gz

ENV PYTHONPATH=/opt/satosa_microservices/src/satosa/micro_services

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps
ENTRYPOINT ["/tmp/satosa/start.sh"]

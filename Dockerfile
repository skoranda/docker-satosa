FROM python:3.7.4-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
        xmlsec1

WORKDIR /tmp

# Until both SATOSA PRs 277 and 252 are merged upstream download and
# merge them by hand.
RUN git clone https://github.com/IdentityPython/SATOSA.git \
    && cd SATOSA \
    && git config --global user.email "nobody@sunet.se" \
    && git config --global user.name "Nobody" \
    && git fetch origin pull/277/head:saml_co_frontend \
    && git fetch origin pull/252/head:ldap_attribute_store \
    && git pull --no-commit . saml_co_frontend ldap_attribute_store \
    && pip install . \
    && pip install ldap3

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps

# Set language to prevent errors when breaking
# into the container to run satosa-saml-metadata.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENTRYPOINT ["/tmp/satosa/start.sh"]

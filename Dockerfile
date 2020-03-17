FROM python:3.7.7-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
        xmlsec1

RUN pip install satosa==6.1 \
    && pip install ldap3

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps

# Set language to prevent errors when breaking
# into the container to run satosa-saml-metadata.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENTRYPOINT ["/tmp/satosa/start.sh"]

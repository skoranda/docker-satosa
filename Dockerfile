FROM python:3.7.4-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
        xmlsec1

ENV SATOSA_SRC_URL=git+https://github.com/IdentityPython/SATOSA.git@803bf24afc49565da8d4d023962515874cfba2f7

# Use a specific commit until a SATOSA release is made with necessary functionality.
RUN pip install ${SATOSA_SRC_URL} \
    && pip install ldap3

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps

# Set language to prevent errors when breaking
# into the container to run satosa-saml-metadata.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENTRYPOINT ["/tmp/satosa/start.sh"]

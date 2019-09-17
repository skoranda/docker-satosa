FROM python:3.7.4-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
        xmlsec1

# Until SATOSA PR 252 is merged and a release cut install directly from
# the Github hidden reference for the merged PR.
RUN pip install git+https://github.com/IdentityPython/SATOSA.git@refs/pull/252/merge \
    && pip install ldap3

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps

# Set language to prevent errors when breaking
# into the container to run satosa-saml-metadata.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENTRYPOINT ["/tmp/satosa/start.sh"]

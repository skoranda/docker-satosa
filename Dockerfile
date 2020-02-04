FROM python:3.7.6-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
        xmlsec1

# Use a specific commit until a SATOSA release is made with necessary functionality.
ENV SATOSA_SRC_URL=git+https://github.com/IdentityPython/SATOSA.git@0d521b160c779cd1d962eb232692034c0155df9d

RUN pip install ${SATOSA_SRC_URL} \
    && pip install ldap3

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps

# Set language to prevent errors when breaking
# into the container to run satosa-saml-metadata.
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENTRYPOINT ["/tmp/satosa/start.sh"]

#! /bin/sh

set -e

: "${ENTRY_PORT:?Required env variable ENTRY_PORT is missing}"
: "${ENTRY_CORS:?Required env variable ENTRY_CORS is missing}"

: "${USER_SERVICE_CONTEXT_PATH:?Required env variable USER_SERVICE_CONTEXT_PATH is missing}"
: "${USER_SERVICE_HOSTNAME:?Required env variable USER_SERVICE_HOSTNAME is missing}"
: "${USER_SERVICE_PORT:?Required env variable USER_SERVICE_PORT is missing}"

: "${GAME_SERVICE_SEARCH_CONTEXT_PATH:?Required env variable GAME_SERVICE_SEARCH_CONTEXT_PATH is missing}"
: "${GAME_SERVICE_SEARCH_HOSTNAME:?Required env variable GAME_SERVICE_SEARCH_HOSTNAME is missing}"
: "${GAME_SERVICE_SEARCH_PORT:?Required env variable GAME_SERVICE_SEARCH_PORT is missing}"


# Remove the defualt config
rm -f /etc/envoy/envoy.yaml

# Inject environment variables 
touch /tmp/envoy.yaml
envsubst '\
    ${ENTRY_PORT} \
    ${ENTRY_CORS} \
    ${USER_SERVICE_CONTEXT_PATH} \
    ${USER_SERVICE_HOSTNAME} \
    ${USER_SERVICE_PORT} \
    ${GAME_SERVICE_CONTEXT_PATH} \
    ${GAME_SERVICE_HOSTNAME} \
    ${GAME_SERVICE_PORT}' \
    < /envoy.conf.template > /etc/convoy/convoy.yaml

if command -v sudo > /dev/null 2>&1; then
    sudo /usr/local/bin/envoy -c /etc/envoy/envoy.yaml
else
    /usr/local/bin/envoy -c /etc/envoy/envoy.yaml
fi
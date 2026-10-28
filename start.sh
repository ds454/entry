#! /bin/sh

# Errors fail
set -e

# Check to make sure all required environment variables are set
: "${ENTRY_PORT:?Required env variable ENTRY_PORT is missing}"

: "${USER_SERVICE_CONTEXT_PATH:?Required env variable USER_SERVICE_CONTEXT_PATH is missing}"
: "${USER_SERVICE_HOSTNAME:?Required env variable USER_SERVICE_HOSTNAME is missing}"
: "${USER_SERVICE_PORT:?Required env variable USER_SERVICE_PORT is missing}"

: "${GAME_SERVICE_CONTEXT_PATH:?Required env variable GAME_SERVICE_SEARCH_CONTEXT_PATH is missing}"
: "${GAME_SERVICE_HOSTNAME:?Required env variable GAME_SERVICE_SEARCH_HOSTNAME is missing}"
: "${GAME_SERVICE_PORT:?Required env variable GAME_SERVICE_SEARCH_PORT is missing}"


# Remove the defualt config
rm -f /etc/envoy/envoy.yaml

# Inject environment variables into our new config
envsubst '\
    ${ENTRY_PORT} \
    ${USER_SERVICE_CONTEXT_PATH} \
    ${USER_SERVICE_HOSTNAME} \
    ${USER_SERVICE_PORT} \
    ${GAME_SERVICE_CONTEXT_PATH} \
    ${GAME_SERVICE_HOSTNAME} \
    ${GAME_SERVICE_PORT}' \
    < /envoy.yaml.template > /etc/envoy/envoy.yaml

# Make the config readable
chmod +r /etc/envoy/envoy.yaml

# Start envoy
exec /usr/local/bin/envoy -c /etc/envoy/envoy.yaml
#! /bin/sh

# Errors fail
set -e

# Check to make sure all required environment variables are set
: "${ENTRY_PORT:?Required env variable ENTRY_PORT is missing}"

: "${AUTH_SERVICE_CONTEXT_PATH:?Required env variable AUTH_SERVICE_CONTEXT_PATH is missing}"
: "${AUTH_SERVICE_HOSTNAME:?Required env variable AUTH_SERVICE_HOSTNAME is missing}"
: "${AUTH_SERVICE_PORT:?Required env variable AUTH_SERVICE_PORT is missing}"
: "${AUTH_SERVICE_LOGIN_PATH:?Required env variable AUTH_SERVICE_LOGIN_PATH is missing}"
: "${AUTH_HEALTH_INTERVAL:?Required env variable AUTH_HEALTH_INTERVAL is missing}"
: "${AUTH_SESSION_TOKEN_HEADER_KEY:?Required env variable AUTH_SESSION_TOKEN_HEADER_KEY is missing}"

: "${USER_SERVICE_CONTEXT_PATH:?Required env variable USER_SERVICE_CONTEXT_PATH is missing}"
: "${USER_SERVICE_HOSTNAME:?Required env variable USER_SERVICE_HOSTNAME is missing}"
: "${USER_SERVICE_PORT:?Required env variable USER_SERVICE_PORT is missing}"
: "${USER_SERVICE_REGISTER_PATH:?Required env variable USER_SERVICE_REGISTER_PATH is missing}"
: "${USER_HEALTH_INTERVAL:?Required env variable USER_HEALTH_INTERVAL is missing}"

: "${GAME_SERVICE_CONTEXT_PATH:?Required env variable GAME_SERVICE_CONTEXT_PATH is missing}"
: "${GAME_SERVICE_HOSTNAME:?Required env variable GAME_SERVICE_HOSTNAME is missing}"
: "${GAME_SERVICE_PORT:?Required env variable GAME_SERVICE_PORT is missing}"

# Remove the defualt config
rm -f /etc/envoy/envoy.yaml

# Inject environment variables into our new config
envsubst '\
    ${ENTRY_PORT} \
    ${AUTH_SERVICE_CONTEXT_PATH} \
    ${AUTH_SERVICE_HOSTNAME} \
    ${AUTH_SERVICE_PORT} \
    ${AUTH_SERVICE_LOGIN_PATH} \
    ${AUTH_HEALTH_INTERVAL} \
    ${AUTH_SESSION_TOKEN_HEADER_KEY} \
    ${USER_SERVICE_CONTEXT_PATH} \
    ${USER_SERVICE_REGISTER_PATH} \
    ${USER_SERVICE_HOSTNAME} \
    ${USER_SERVICE_PORT} \
    ${USER_HEALTH_INTERVAL} \
    ${GAME_SERVICE_CONTEXT_PATH} \
    ${GAME_SERVICE_HOSTNAME} \
    ${GAME_SERVICE_PORT}' \
    < /envoy.yaml.template > /etc/envoy/envoy.yaml

# Make the config readable
chmod +r /etc/envoy/envoy.yaml

# Start envoy
exec /usr/local/bin/envoy -c /etc/envoy/envoy.yaml
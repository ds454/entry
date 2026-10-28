# Includes eMudhra patch
FROM        envoyproxy/envoy:v1.40.2
WORKDIR     /
COPY        start.sh /start.sh
COPY        config.yaml.template /
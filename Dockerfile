# Includes eMudhra patch
FROM        envoyproxy/envoy:v1.40.2

# Install envsubst
RUN         apt update && apt install -y gettext-base

# Explicitly set our working directory
WORKDIR     /

# Copy over the files we need
COPY        start.sh /start.sh
COPY        config.yaml.template /config.yaml.template

# Make the start script executable
RUN         chmod +x /start.sh

# Make our start script the entrypoint
ENTRYPOINT  ["/start.sh"]

# Clear CMD
CMD []
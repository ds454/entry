# Includes eMudhra patch
FROM        envoyproxy/envoy:v1.40.2

# Install envsubst and clean up after apt
RUN         apt update && \
            apt install -y --no-install-recommends gettext-base && \
            rm -rf /var/lib/apt/lists/*

# Explicitly set our working directory
WORKDIR     /

# Copy over the start script
COPY        start.sh /start.sh
RUN         chmod +x /start.sh

# Copy the config
COPY        envoy.yaml /envoy.yaml.template

# Make our start script the entrypoint
ENTRYPOINT  ["/start.sh"]
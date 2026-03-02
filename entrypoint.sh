#!/bin/sh

# 1. Fix folder permissions for the Docker-mounted volume
chown -R node:node /home/node/.openclaw

# 2. Apply the config fix securely AS the node user
su node -c "node /app/openclaw.mjs config set gateway.controlUi.dangerouslyAllowHostHeaderOriginFallback true"

# 3. Start the gateway AS the node user
exec su node -c "node /app/openclaw.mjs gateway --bind ${OPENCLAW_GATEWAY_BIND:-lan} --port 18789 --allow-unconfigured"

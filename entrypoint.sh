#!/bin/sh
# Fix volume permissions
chown -R node:node /home/node/.openclaw

# Set config as node user
su -s /bin/sh node -c "node /app/openclaw.mjs config set gateway.controlUi.dangerouslyAllowHostHeaderOriginFallback true"
su -s /bin/sh node -c "node /app/openclaw.mjs config set gateway.token ${OPENCLAW_GATEWAY_TOKEN}"

# Start gateway as node user
exec su -s /bin/sh node -c "exec node /app/openclaw.mjs gateway --bind ${OPENCLAW_GATEWAY_BIND:-lan} --port 18789 --allow-unconfigured"

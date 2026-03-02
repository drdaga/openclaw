#!/bin/sh
# Fix volume permissions
chown -R node:node /home/node/.openclaw

# Set config
su -s /bin/sh node -c "node /app/openclaw.mjs config set gateway.controlUi.dangerouslyAllowHostHeaderOriginFallback true"
su -s /bin/sh node -c "node /app/openclaw.mjs config set gateway.token ${OPENCLAW_GATEWAY_TOKEN}"

# Create auth-profiles.json with single Claude session key
mkdir -p /home/node/.openclaw/agents/main/agent
chown -R node:node /home/node/.openclaw/agents

cat > /home/node/.openclaw/agents/main/agent/auth-profiles.json << EOF
{
  "anthropic": [
    {"type": "session-key", "sessionKey": "${CLAUDE_AI_SESSION_KEY}"}
  ]
}
EOF

chown node:node /home/node/.openclaw/agents/main/agent/auth-profiles.json

# Start gateway
exec su -s /bin/sh node -c "exec node /app/openclaw.mjs gateway --bind ${OPENCLAW_GATEWAY_BIND:-lan} --port 18789 --allow-unconfigured"

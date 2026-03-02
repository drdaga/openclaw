#!/bin/sh
# 1. Set the config key to bypass the origin error
node openclaw.mjs config set gateway.controlUi.dangerouslyAllowHostHeaderOriginFallback true

# 2. Start the gateway as the main process
exec node openclaw.mjs gateway --bind ${OPENCLAW_GATEWAY_BIND:-lan} --port 18789 --allow-unconfigured

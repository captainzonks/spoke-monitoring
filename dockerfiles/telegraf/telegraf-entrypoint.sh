#!/bin/sh
set -e

# ============================================================================
# TELEGRAF ENTRYPOINT - DOCKER SECRETS HANDLER
# ============================================================================
# Description: Reads Docker secrets and exports as environment variables
# Created: 2026-02-12
# Version: 1.0.0
# ============================================================================

# ============================================================================
# SECRETS LOADING
# ============================================================================
# Read the InfluxDB3 auth token from Docker secret file
if [ -f "/run/secrets/influxdb3_auth_token" ]; then
  echo "SUCCESS: found secret 'influxdb3_auth_token'"
  echo "Setting INFLUXDB3_AUTH_TOKEN environment variable..."
  INFLUXDB3_AUTH_TOKEN="$(cat /run/secrets/influxdb3_auth_token)"
  export INFLUXDB3_AUTH_TOKEN
else
  echo "WARNING: secret 'influxdb3_auth_token' not found at /run/secrets/"
  echo "Falling back to INFLUXDB3_AUTH_TOKEN environment variable"
fi

# Execute the original Telegraf entrypoint
exec /entrypoint.sh "$@"

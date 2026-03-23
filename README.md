# spoke-monitoring

Monitoring and observability module for [Spoke](https://github.com/captainzonks/spoke).

## Services

| Service | Description | Port |
|---------|-------------|------|
| Grafana | Visualization and dashboards | 3000 |
| Prometheus | Metrics collection and storage | 9090 |
| Loki | Log aggregation (monolithic mode) | 3100 |
| Telegraf | Metrics agent (host + Docker) | 8094/9273 |
| Dozzle (socket) | Docker log viewer agent | 8080 |
| Dozzle (soxy) | Docker log viewer web UI | 8080 |
| Alloy | Grafana log/metrics collector | 12345 |
| NUT-UPSD | UPS monitoring and management | 3493 |

## Prerequisites

- [Spoke](https://github.com/captainzonks/spoke) hub deployed and running
- External Docker networks: `troxy`, `soxy`, `auxy`
- Hub services: `traefik`, `postgres-hub`

## Quick Start

1. Clone into your Spoke modules directory:
   ```bash
   cd /path/to/spoke/modules
   git clone git@github.com:captainzonks/spoke-monitoring.git monitoring
   ```

2. Configure via `modules.yml` in your Spoke root:
   ```yaml
   modules:
     monitoring:
       repo: "git@github.com:captainzonks/spoke-monitoring.git"
       ref: "main"
       enabled: true
       env_overrides:
         GRAFANA_IP: "192.168.35.102"
         PROMETHEUS_IP: "192.168.35.109"
   ```

3. Deploy:
   ```bash
   make deploy MODULE=monitoring
   ```

## Custom Builds

Prometheus and Telegraf use custom Dockerfiles for non-root user mapping. Builds are handled automatically by `docker compose` using the `build` directives in `docker-compose.yml`.

## Traefik Rules

The `traefik/` directory contains routing and service definitions that Spoke deploys to the hub's Traefik rules directory with the `mod_monitoring_` prefix.

## Secrets

| Secret | Required | Description |
|--------|----------|-------------|
| `grafana_admin_password` | Yes | Grafana admin password |
| `grafana_secret_key` | Yes | Grafana encryption key |
| `grafana_oauth_client_id` | Yes | Authentik OAuth client ID |
| `grafana_oauth_client_secret` | Yes | Authentik OAuth client secret |
| `grafana_psql_password` | Yes | Grafana PostgreSQL password |
| `influxdb3_auth_token` | No | InfluxDB3 auth token for Telegraf |
| `nut_upsd_password` | No | NUT UPS monitoring password |

## License

MIT

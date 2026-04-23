# ==============================================================================
# MONITORING MODULE - PROMETHEUS DOCKERFILE
# ==============================================================================
# Description: Prometheus with custom UID/GID for host filesystem permissions
# Author: Matt Barham
# Created: 2026-02-12
# Modified: 2026-04-23
# Version: 1.0.1
# Host: Your Server
# ==============================================================================
# Type: Dockerfile
# Base Image: prom/prometheus:${CT_TAG}
# Documentation: https://prometheus.io/docs/
# Component: module: monitoring / service: prometheus
# Build args: USER_ID, GROUP_ID, USERNAME, GROUPNAME, CT_TAG
# Security: custom user mapping for host filesystem permissions
# ==============================================================================

ARG CT_TAG=v3.11.2
FROM prom/prometheus:${CT_TAG}

ARG USER_ID
ARG GROUP_ID

ARG USERNAME
ARG GROUPNAME

SHELL ["/bin/sh", "-c"]

USER root

# Create custom user/group for host filesystem permissions
RUN addgroup --gid ${GROUP_ID} ${GROUPNAME} &&\
    adduser -D -H -G ${GROUPNAME} -u ${USER_ID} ${USERNAME} &&\
    install -d -m 0755 ${USERNAME} -g ${GROUPNAME} /home/{$USERNAME}/ &&\
    mkdir -p /var/log/${USERNAME}/ &&\
    chown -v --changes --silent --no-dereference --recursive \
        ${USER_ID}:${GROUP_ID} \
            /etc/${USERNAME}/ \
            /bin/${USERNAME} \
            /bin/promtool \
            /${USERNAME} \
            /var/log/${USERNAME}/

USER ${USERNAME}

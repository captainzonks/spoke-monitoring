# ==============================================================================
# MONITORING MODULE - TELEGRAF DOCKERFILE
# ==============================================================================
# Description: Telegraf with custom user and Docker secrets handling
# Author: Matt Barham
# Created: 2026-02-12
# Modified: 2026-04-21
# Version: 1.0.1
# Host: Your Server
# ==============================================================================
# Type: Dockerfile
# Base Image: telegraf:${CT_TAG}
# Documentation: https://docs.influxdata.com/telegraf/
# Component: module: monitoring / service: telegraf
# Build args: USER_ID, GROUP_ID, USERNAME, GROUPNAME, OG_UID, OG_GID, CT_TAG
# Security: custom user mapping, Docker secrets support via entrypoint
# ==============================================================================

ARG CT_TAG=1.37.0
FROM telegraf:${CT_TAG}

ARG USER_ID
ARG GROUP_ID

ARG USERNAME
ARG GROUPNAME

ARG OG_UID
ARG OG_GID

SHELL ["/bin/bash", "-c"]

USER root

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    userdel -f ${USERNAME} &&\
    if getent group ${GROUPNAME}; then groupdel ${GROUPNAME}; fi &&\
    groupadd -g ${GROUP_ID} ${GROUPNAME} &&\
    useradd -l -u ${USER_ID} -g ${GROUPNAME} ${USERNAME} &&\
    install -d -m 0755 -o ${USERNAME} -g ${GROUPNAME} /home/${USERNAME}/ &&\
    chown --changes --silent --no-dereference --recursive \
        --from=${OG_UID}:${OG_GID} ${USER_ID}:${GROUP_ID} \
            /etc/${USERNAME}/ \
            /var/log/${USERNAME}/ \
            /var/lib/${USERNAME}/ \
            /usr/bin/${USERNAME} \
;fi

# Copy custom entrypoint for Docker secrets handling
COPY telegraf-entrypoint.sh /telegraf-entrypoint.sh
RUN chmod 755 /telegraf-entrypoint.sh

USER ${USERNAME}

ENTRYPOINT ["/telegraf-entrypoint.sh"]
CMD ["telegraf"]

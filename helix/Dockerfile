FROM ubuntu:20.04

ARG UID
ARG GID

SHELL ["/bin/bash", "-c"]


RUN apt update && apt install -y software-properties-common && \
    add-apt-repository -y ppa:git-core/ppa && \
    apt update && apt -y upgrade && \
    apt install -y \
    curl build-essential git && \
    #
    if ! id -g $GID > /dev/null 2>&1; then \
       group_name=appuser; \
       groupadd -g $GID $group_name; \
    else group_name=$(id -g -n $GID); fi && \
    #
    if ! id -u $UID > /dev/null 2>&1; then \
       user_name=appuser; \
       useradd -m -u $UID -g $GID -s /bin/bash $user_name; \
    else user_name=$(id -u -n $UID); fi && \
    #
    su - $user_name -c \
    'curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable' \
    && apt clean && apt autoremove --purge

USER appuser
WORKDIR /home/appuser


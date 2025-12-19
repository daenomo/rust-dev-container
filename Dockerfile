FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common ca-certificates && \
    apt-get install -y sudo build-essential libgmp-dev git wget unzip which tar curl rustup zsh && \
    apt-get clean

ARG USERNAME

RUN groupadd $USERNAME && \
    useradd -m -s /bin/zsh -g $USERNAME -G sudo $USERNAME && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN rustup default stable

WORKDIR /home/$USERNAME/app
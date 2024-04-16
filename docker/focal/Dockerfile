FROM ubuntu:20.04

# Set the working directory inside container
WORKDIR /src

# Install any needed packages

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update; \
    apt-get install -y --allow-unauthenticated aptitude; \
    aptitude install -y --allow-untrusted \
    wget \
    gnupg \
    nano \
    screen \
    inetutils-ping \
    sudo \
    xvfb \
    x11vnc


# Setup rfuser

ARG user=rfuser
ARG group=rfuser
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} && \
    useradd -u ${uid} -g ${group} -s /bin/bash ${user} && \
    usermod -aG sudo ${user} && \
    mkdir -p /home/${user} && \
    chown -R ${user}:${group} /home/${user}

RUN echo "DISPLAY=:0" >> /etc/environment

# Install ratflow-core

COPY . /src/ratflow-core
RUN cd /src/ratflow-core && ls -lah && ./install.sh ./installers/focal

# Run entrypoint

EXPOSE 5900/tcp

# Run commands when the container launches
ADD docker/focal/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

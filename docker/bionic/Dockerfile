# Use an official Python runtime as a parent image
FROM ubuntu:18.04

# Set the working directory inside container
WORKDIR /

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

# Copy local files to the container
ADD ./*.list /etc/apt/sources.list.d/

# Setup ratflow repository

RUN sh -c 'wget -O /tmp/nixlab.key http://apt.nixlab.in/public.gpg.key; sudo apt-key add /tmp/nixlab.key'
RUN aptitude update

# Install ratflow-core

RUN aptitude install -y --allow-untrusted \
    ratflow-core

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

# Run entrypoint

EXPOSE 5900/tcp

# Run commands when the container launches
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

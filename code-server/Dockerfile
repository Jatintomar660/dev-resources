FROM lscr.io/linuxserver/code-server:latest

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    vim \
    nano \
    net-tools \
    htop \
    zip \
    unzip \
    tar \
    gzip \ 
    sudo \
    iputils-ping \
    telnet

RUN apt-get install -y python3 python3-pip

RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

RUN curl -OL https://go.dev/dl/go1.20.7.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.20.7.linux-amd64.tar.gz \
    && rm go1.20.7.linux-amd64.tar.gz

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="${PATH}:/usr/local/go/bin"

COPY extensions.gz /home/
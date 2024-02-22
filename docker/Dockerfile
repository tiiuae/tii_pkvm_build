FROM debian:bookworm

# tzdata noninteractive install
ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        locales

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

# Yocto build dependencies
RUN \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        gawk \
        wget \
        git-core \
        diffstat \
        unzip \
        texinfo \
        gcc-multilib \
        build-essential \
        chrpath \
        socat \
        cpio \
        python3 \
        python3-pip \
        python3-pexpect

RUN \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu

RUN \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        lz4 \
        zstd \
        file \
        sudo \
        iproute2 \
        iptables

RUN \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install \
        vim \
        less \
        strace

RUN useradd -m -d /home/build -s /bin/bash -G sudo -u 1000 build
RUN echo 'build:build' | chpasswd
RUN printf '\n\n\
eval $(ssh-agent -s &> /dev/null)\n\
find /home/build/.ssh/ -type f -exec grep -l "PRIVATE" {} \; | xargs ssh-add &> /dev/null\n'\
>> /home/build/.bashrc
USER build

ENV WORKSPACE=/workspace

WORKDIR /workspace

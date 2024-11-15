FROM alpine:3.18

ARG USER=tilted

RUN addgroup -S $USER \
    && adduser -S $USER -G $USER \
    && apk upgrade --no-cache \
    && apk add --no-cache \
        bash \
        make \
        cmake \
        unzip \
        git \
        gcc \
        g++ \
        alpine-sdk \
        build-base \
        ca-certificates \
        curl \
        wget \
        linux-headers \
        p7zip \
        perl \
        xz \
        bsd-compat-headers \
        readline-dev \
        ccache \
        curl-dev \
        libcurl \
        coreutils \
        autoconf \
        automake \
        libtool \
        gcompat \
        libstdc++ \
        libstdc++-dev \
        libffi-dev \
        openssl-dev \
        libc6-compat

USER $USER

RUN curl -fsSL https://xmake.io/shget.text | bash

WORKDIR /home/$USER

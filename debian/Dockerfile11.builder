# TBD
# Use debian:11 due to bugs with arm/v7 on debian:12 while building openssl
#   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=999680
#   https://github.com/openssl/openssl/issues/21630
#
# Debian 11 will require:
#   cmake 3.20+ to be built and installed
#   gcc-10, g++-10

FROM debian:12

ARG USER=tilted
ENV DEBIAN_FRONTEND=noninteractive

RUN adduser --disabled-password --gecos "" $USER \
  && apt update \
  && apt install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      make \
      git \
      curl \
      wget \
      unzip \
      gcc-10 \
      g++-10 \
      libssl-dev \
  && rm -rf /var/lib/apt/lists/* \
  && cp /usr/lib/*/libstdc++.so.? /usr/lib/ \
  && wget https://github.com/Kitware/CMake/archive/refs/tags/v3.25.1.tar.gz -O cmake-$CMAKE_VERSION.tar.gz \
    && tar zxvf cmake-$CMAKE_VERSION.tar.gz \
    && rm cmake-$CMAKE_VERSION.tar.gz \
    && cd CMake-$CMAKE_VERSION \
    && ./bootstrap \
    && make \ 
    && make install

USER $USER

RUN curl -fsSL https://xmake.io/shget.text | bash

WORKDIR /home/$USER

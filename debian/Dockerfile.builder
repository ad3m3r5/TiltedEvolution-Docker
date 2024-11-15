# Using debian:11 due to bugs with arm/v7 on debian:12 while building openssl
#   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=999680
#   https://github.com/openssl/openssl/issues/21630
FROM debian:11

ARG USER=tilted
ENV DEBIAN_FRONTEND=noninteractive

RUN adduser --disabled-password --gecos "" $USER \
  && apt update \
  && apt install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      cmake \
      make \
      git \
      curl \
      wget \
      unzip \
      gcc-10 \
      g++-10 \
  && rm -rf /var/lib/apt/lists/* \
  && cp /usr/lib/*/libstdc++.so.? /usr/lib/

USER $USER

RUN curl -fsSL https://xmake.io/shget.text | bash

WORKDIR /home/$USER

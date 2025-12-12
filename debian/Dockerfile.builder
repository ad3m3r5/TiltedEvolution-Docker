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

RUN apt update \
  && apt install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      cmake \
      make \
      git \
      curl \
      wget \
      unzip \
      gcc-12 \
      g++-12 \
  && rm -rf /var/lib/apt/lists/* \
  && adduser --disabled-password --gecos "" $USER

USER $USER
WORKDIR /home/$USER

RUN curl -fsSL https://xmake.io/shget.text | bash

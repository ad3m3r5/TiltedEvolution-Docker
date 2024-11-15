FROM debian:12

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
      gcc-12 \
      g++-12

USER $USER

RUN curl -fsSL https://xmake.io/shget.text | bash

WORKDIR /home/$USER

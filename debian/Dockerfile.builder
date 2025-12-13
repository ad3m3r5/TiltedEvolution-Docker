FROM debian:13

ARG USER=tilted
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
  && apt install -y --no-install-recommends \
      adduser \
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
      pkg-config \
      libssl-dev \
      xmake \
  && rm -rf /var/lib/apt/lists/* \
  && adduser --disabled-password --gecos "" $USER

USER $USER
WORKDIR /home/$USER

#RUN curl -fsSL https://xmake.io/shget.text | bash

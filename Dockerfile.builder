FROM alpine:3.16

WORKDIR /home/builder

RUN apk add --no-cache \
  cmake \
  unzip \
  git \
  gcc \
  g++ \
  alpine-sdk \
  build-base \
  ca-certificates \
  curl \
  linux-headers \
  bash \
  p7zip \
  perl \
  xz \
  bsd-compat-headers  

RUN git clone --recursive https://github.com/xmake-io/xmake.git ./xmake && \
  cd xmake && \
  make build && \
  make install && \
  rm -rf /home/builder/xmake

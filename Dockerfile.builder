FROM alpine:3.19

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

RUN curl -fsSL https://xmake.io/shget.text | bash

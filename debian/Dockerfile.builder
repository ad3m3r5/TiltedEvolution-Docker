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
  && echo "deb http://deb.debian.org/debian trixie-backports main" > /etc/apt/sources.list.d/backports.list \
  && apt update \
  && apt install -y --no-install-recommends -t trixie-backports \
      xmake \
  && rm -rf /var/lib/apt/lists/* \
  && adduser --disabled-password --gecos "" $USER

RUN if [ "$(dpkg --print-architecture)" = armhf ]; then \
      gcc -dumpspecs | awk '{print} /^\*cc1:$/ {getline; print $0 " %{!mfpu=*:-mfpu=vfpv3-d16}"}' \
        > "$(dirname "$(gcc -print-libgcc-file-name)")/specs"; \
    fi

USER $USER
WORKDIR /home/$USER

#RUN curl -fsSL https://xmake.io/shget.text | bash

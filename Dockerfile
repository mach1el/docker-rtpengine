FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -yqq --no-install-recommends \
  git \
  curl \
  wget \
  ca-certificates \
  gnupg2 \
  dirmngr \
  debhelper \
  default-libmysqlclient-dev \
  gperf \
  iptables-dev \
  libavcodec-dev \
  libavfilter-dev \
  libavformat-dev \
  libavutil-dev \
  libbencode-perl \
  libcrypt-openssl-rsa-perl \
  libcrypt-rijndael-perl \
  libhiredis-dev \
  libio-multiplex-perl \
  libio-socket-inet6-perl \
  libjson-glib-dev \
  libdigest-crc-perl \
  libdigest-hmac-perl \
  libnet-interface-perl \
  libnet-interface-perl \
  libssl-dev \
  libsystemd-dev \
  libxmlrpc-core-c3-dev \
  libcurl4-openssl-dev \
  libevent-dev \
  libpcap0.8-dev markdown \
  unzip \
  nfs-common \
  dkms \
  libspandsp-dev \
  build-essential \
  lsb-release \
  && rm -rf /var/lib/apt/lists/*

ENV VER=1.0.4
WORKDIR /tmp

RUN curl https://codeload.github.com/BelledonneCommunications/bcg729/tar.gz/$VER >bcg729_$VER.orig.tar.gz
RUN tar zxf bcg729_$VER.orig.tar.gz

WORKDIR /tmp/bcg729-$VER
RUN git clone https://github.com/ossobv/bcg729-deb.git debian
RUN dpkg-buildpackage -d -us -uc -sa

WORKDIR /tmp
RUN dpkg -i libbcg729-*.deb

RUN git clone https://github.com/sipwise/rtpengine.git
WORKDIR /tmp/rtpengine
RUN dpkg-checkbuilddeps
RUN dpkg-buildpackage -us -uc -sa

WORKDIR /tmp
RUN dpkg -i ngcp-rtpengine-daemon_*.deb ngcp-rtpengine-recording-daemon_*.deb ngcp-rtpengine-iptables_*.deb ngcp-rtpengine-kernel-dkms_*.deb

WORKDIR /
RUN rm -rf /tmp/*
RUN mkdir -p /etc/rtpengine/
RUN mkdir -p /var/spool/rtpengine
RUN mkdir -p /var/lib/rtpengine-recording

ENV TABLE=0
COPY cfg/rtpengine.conf /etc/rtpengine/
COPY cfg/rtpengine-recording.conf /etc/rtpengine/

ADD units /
COPY init.sh /init.sh
RUN chmod +x /init.sh
ENTRYPOINT ["/init.sh"]
FROM alpine:latest
MAINTAINER sweord <sweord@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

RUN \
  apk --update --upgrade add \
      python \
      libsodium \
      wget \
      py-pip \
      privoxy \
      supervisor \
  && rm /var/cache/apk/*

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     9090
ENV PASSWORD        pwd
ENV METHOD          aes-256-cfb
ENV PROTOCOL        origin
ENV OBFS            plain
ENV TIMEOUT         300


ARG BRANCH=manyuser
ARG WORK=~


#------------------------------------------------------------------------------
# Populate root file system:
#------------------------------------------------------------------------------

ADD rootfs /

#------------------------------------------------------------------------------
# Install ShadowsocksR:
#------------------------------------------------------------------------------

RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/shadowsocksr-backup/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK

WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks

#------------------------------------------------------------------------------
# Expose ports and entrypoint:
#------------------------------------------------------------------------------
EXPOSE 8118 7070

# ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT  ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

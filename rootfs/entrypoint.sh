#!/bin/sh

#------------------------------------------------------------------------------
# Configure the service:
#------------------------------------------------------------------------------
env python /~/shadowsocksr-manyuser/shadowsocks/server.py -s $SERVER_ADDR -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM

env /usr/sbin/privoxy --no-daemon /etc/privoxy/config

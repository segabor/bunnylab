#!/bin/bash
export RUBYOPT=rubygems
HOST=`hostname -s`
RES=boot
UNAME=net.violet.platform
PWD=violet
d=`dirname $0`
ruby $d/backend.rb &
ruby $d/listener.rb $UNAME@$HOST/$ES $PWD

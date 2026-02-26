#!/bin/zsh

dscacheutil -flushcache
killall -HUP mDNSResponder
echo "DNS cache flushed."

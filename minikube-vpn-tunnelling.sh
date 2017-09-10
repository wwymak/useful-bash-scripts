#!/bin/bash
# script for letting a container in minikube to resources that the host can see through a vpn tunnel.
# works for macs, not sure about other systems

startme() {
  minikube start
  rulefile="rules.tmp"
  interfaces=( $(netstat -in | egrep 'utun\d .*\d+\.\d+\.\d+\.\d+' | cut -d ' ' -f 1) )
  for i in "${interfaces[@]}"
  do
    RULE="nat on ${i} proto {tcp, udp, icmp} from 192.168.64.0/24 to my.vpn.ip.addr -> ${i}"
    echo $RULE >> $rulefile
  done
  sudo pfctl -a com.apple/tun -f $rulefile
}

stopme() {
  sudo pfctl -F all -a com.apple/tun
  minikube stop
}

case "$1" in
    start)   startme ;;
    stop)    stopme ;;
esac

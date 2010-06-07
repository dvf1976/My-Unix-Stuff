#!/bin/sh
# should be run once a minute by cron
# responsible for keeping synergyc alive
# if a connection to server is not detected, kills any ssh sessions to server and stops synergyc
# if synergy is not running and server is available, starts an ssh tunnel and synergy
# from http://www.totalaldo.com/blog/?p=49

# name of computer running the synergy server
server='vader'
host=`/bin/hostname`
if [ $host = "martin" ]
then
    server='skinner'
fi

isTunnelActive=`ps -auxw | grep “24800:$server:24800″ | grep -v grep | wc -l`
isSynergyActive=`ps -auxw | grep ’synergyc.*restart’ | grep -v grep | wc -l`
isClientDead=`ping -c 1 $server | grep “100% packet loss” | wc -l`

echo “Tunnel Active: ” $isTunnelActive
echo $server ” Dead: ” $isClientDead
echo “Synergy running: ” $isSynergyActive

if [ $isTunnelActive -gt 0 -a $isClientDead -gt 0 ] 
then
    echo “Tunnel is active, but client is dead. Stopping all tunnels and synergy”
    # kill the tunnel and synergy since there is no connection to the computer
    ps -auxw | grep '24800:$server:24800' | grep -v grep | awk '{print $2}' | xargs kill;
    killall -9 synergyc;
    exit;
elif [ $isTunnelActive -eq 0 -a $isClientDead -eq 0 ] 
then
    echo “Tunnel is down, but client is up. Starting tunnel and synergy”
    # start the ssh tunnel and the client
    killall -9 synergyc;
    ps -auxw | grep "24800:$server:24800" | grep -v grep | awk '{print $2}' | xargs kill;
    ssh -f -N -L 24800:$server:24800 $server && /usr/bin/synergyc --restart localhost
elif [ $isClientDead -eq 0 -a $isSynergyActive -eq 0 ]
then
    echo “Client is up but synergy is down. Need to start”
    ps -auxw | grep '24800:$server:24800' | grep -v grep | awk '{print $2}' | xargs kill;
    killall -9 synergyc;
    ssh -f -N -L 24800:$server:24800 $server && /usr/bin/synergyc --restart localhost
fi



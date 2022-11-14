#!/bin/bash

if [ "$#" -ne "1" ]
then
        echo "USAGE: $0 <host list file>"
        exit 1
fi


if [[ -f  $1 ]]
then
        for file in `cat $1`
        do
                ssh $file <<ENDSSH
                declare -a INF=()
                INF=($(ifconfig | grep -i ^eth | awk '{print $1}' | xargs))

                for i in "${INF[@]}"
                do
                        ntuple=`ethtool --show-features $i| grep ntuple | awk '{print $2}'`
                        if [[ "$ntuple" == "off" ]]
                        then
                                MSG_NTUPLE="ntuple filtering is OFF on $HOSTNAME"
                        else
                                MSG_NTUPLE=""
                        fi
                        for ring in `ethtool -g $i | grep "RX:\|TX:" | awk '$2 > 4000 {print ;}'| cut -d ':' -f2 | xargs`
                        do
                
                                if [[ "$ring" < 4000 ]]
                                then
                                        RING_MSG="Ring parameters for $ring is less less than 4096 bytes"
                                else
                                        RING_MSG=""
                                fi
                        done
                done


                net=`sysctl -a | grep netdev_budget | awk -F '=' '{print $2}'`
                if [[ "$net" < 600 ]]
                then
	                MAX_PACKET="netdev_budget set on $HOSTNAME = $net"
                else
	                MAX_PACKET=""
                fi


                if [[ -z $MSG_NTUPLE && -z $RING_MSG && -z $MAX_PACKET ]]
                then
                        echo "All parameters are as per expected"
                        exit 0
                else
                        echo "Some network parameters are not as per requirement.\n\n$MSG_NTUPLE\n$RING_MSG\n$MAX_PACKET\n"
                        exit 1
  
                        #echo -e "\n*****Alert Triggered*****\nSome network parameters are not as per requirement.\n\n$MSG_NTUPLE\n$RING_MSG\n$MAX_PACKET\n" | mail -s "Braze: Report On netdev, ntuple and ring buffer" viraj@objectrocket.com
                fi
                ENDSSH
        done
else
        echo "The $1 does not exist, [HOST FILE IS MISSING]"
        exit 1
fi

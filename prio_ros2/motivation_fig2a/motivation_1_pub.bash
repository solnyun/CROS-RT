#!/bin/bash

# Inputs: Number of subscriber node, packet number (pkt_num)
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <number> <pkt_num>"
    exit 1
fi
input_num=$1
pkt_num=$2
#period=$2


#Make directory to store the result data
CreateDIR=chain_${input_num}_pkt_${pkt_num}
if [ ! -d $CreateDIR ]; then
        mkdir $CreateDIR
fi

declare -a nodes=("90" "80")
declare -a periods=("20" "200")


echo "Nodes start to run"
for (( i=0; i<$input_num; i++ )); do
    node=${nodes[$i]}
    period=${periods[$i]}
    file_name="${CreateDIR}/pub_${node}.txt"
    ros2 run motivation talker -r __node:=pub_$node -t sub_$node -p $period -s $pkt_num > $file_name &
    sleep 3s
done

echo "start to assign priority"
for (( i=0; i<$input_num; i++ )); do
    node=${nodes[$i]}
    file_name="${CreateDIR}/pub_${node}.txt"
    python3 pri_assign.py "$file_name" "$node"
done

#iperf3 -c 192.168.0.22 -p 7778 -i 0.1 -b 90M -k 4000000000 -u > "$CreateDIR/iperf_client.txt" &

sleep 150s
sudo pkill talker
sudo pkill iperf3

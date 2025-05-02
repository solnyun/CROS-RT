#!/bin/bash

# Inputs: Number of subscriber node, packet number (pkt_num)
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <number> <pkt_num>"
    exit 1
fi
input_num=$1
pkt_num=$2

#Make directory to store the result data
CreateDIR=chain_${input_num}_pkt_${pkt_num}
if [ ! -d $CreateDIR ]; then
        mkdir $CreateDIR
fi

declare -a nodes=("90" "80")
declare -a periods=("20" "200")
declare -a utilizations=("0.35" "0.15")
#declare -a utilizations=("0.45" "0.12")

echo "Nodes start to run"
for (( i=0; i<$input_num; i++ )); do
    node=${nodes[$i]}
    period=${periods[$i]}
    file_name="${CreateDIR}/sub_${node}.txt"
    util=${utilizations[$i]}
    taskset -c 0 ros2 run motivation listener -r __node:=sub_$node -t sub_$node -u $util -p $period > $file_name &
    sleep 5s
done

echo "start to assign priority"
for (( i=0; i<$input_num; i++ )); do
    node=${nodes[$i]}
    file_name="${CreateDIR}/sub_${node}.txt" 
    python3 pri_assign.py "${file_name}" "${node}"
done

#iperf3 -s -p 7778 > "$CreateDIR/iperf_server.txt" &

sleep 300s
sudo pkill listener
sudo pkill iperf3


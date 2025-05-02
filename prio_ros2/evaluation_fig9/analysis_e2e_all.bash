#!/bin/bash

# Inputs: Number of subscriber node, packet number (pkt_num)
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <type>"
    exit 1
fi
type=$1

CreateDIR=divide1_prio
if [ ! -d "$CreateDIR" ]; then
        mkdir "$CreateDIR"
fi

python3 analysis_e2e.py "$CreateDIR/${type}_global_costmap.txt" "$CreateDIR/${type}_lidar.txt" "$CreateDIR/${type}_chain1.txt"
python3 analysis_e2e.py "$CreateDIR/${type}_local_plan.txt" "$CreateDIR/${type}_lidar.txt" "$CreateDIR/${type}_chain2.txt"
python3 analysis_e2e.py "$CreateDIR/${type}_state.txt" "$CreateDIR/${type}_TF.txt" "$CreateDIR/${type}_chain3.txt"
python3 analysis_e2e.py "$CreateDIR/${type}_global_plan.txt" "$CreateDIR/${type}_goal.txt" "$CreateDIR/${type}_chain4.txt"



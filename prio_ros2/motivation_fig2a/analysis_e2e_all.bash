#!/bin/bash

# Inputs: Number of subscriber node, packet number (pkt_num)
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <type>"
    exit 1
fi
type=$1

CreateDIR=chain_1_pkt_0
if [ ! -d "$CreateDIR" ]; then
        mkdir "$CreateDIR"
fi

python3 analysis_e2e.py "$CreateDIR/sub_90.txt" "$CreateDIR/pub_90.txt" "$CreateDIR/${type}_chain1.txt"
#python3 analysis_e2e.py "$CreateDIR/sub_80.txt" "$CreateDIR/pub_80.txt" "$CreateDIR/${type}_chain2.txt"
#python3 analysis_e2e.py "$CreateDIR/sub_70.txt" "$CreateDIR/pub_70.txt" "$CreateDIR/${type}_chain3.txt"
#python3 analysis_e2e.py "$CreateDIR/sub_60.txt" "$CreateDIR/pub_60.txt" "$CreateDIR/${type}_chain4.txt"
#python3 analysis_e2e.py "$CreateDIR/sub_50.txt" "$CreateDIR/pub_50.txt" "$CreateDIR/${type}_chain5.txt"

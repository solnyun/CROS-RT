#!/bin/bash

# Inputs: Number of subscriber node, packet number (pkt_num)
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <DIR>"
    exit 1
fi
DIR=$1

#for i in $(seq 0 50); do
for i in 2 10 33 48; do
    python3 analysis_e2e.py "$DIR/node${i}_0_2.txt" "$DIR/node${i}_0_0.txt" "$DIR/set${i}_chain0.txt"
#    python3 analysis_e2e.py "$DIR/node${i}_1_2.txt" "$DIR/node${i}_1_0.txt" "$DIR/set${i}_chain1.txt"
#    python3 analysis_e2e.py "$DIR/node${i}_2_2.txt" "$DIR/node${i}_2_0.txt" "$DIR/set${i}_chain2.txt"
#    python3 analysis_e2e.py "$DIR/node${i}_3_2.txt" "$DIR/node${i}_3_0.txt" "$DIR/set${i}_chain3.txt"
#    python3 analysis_e2e.py "$DIR/node${i}_4_2.txt" "$DIR/node${i}_4_0.txt" "$DIR/set${i}_chain4.txt"
#    python3 analysis_e2e.py "$DIR/node${i}_5_2.txt" "$DIR/node${i}_5_0.txt" "$DIR/set${i}_chain5.txt"
done

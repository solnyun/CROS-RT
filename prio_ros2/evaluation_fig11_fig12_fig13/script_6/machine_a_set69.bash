#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_2 -p 177 -st topic69_0_1 -pt None -u 0.011824852619858661 > ./result_6chains/node69_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_2 -p 189 -st topic69_1_1 -pt None -u 0.0002510311386232922 > ./result_6chains/node69_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_2 -p 230 -st topic69_2_1 -pt None -u 0.12040114627930631 > ./result_6chains/node69_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_2 -p 897 -st topic69_3_1 -pt None -u 0.002103581708243568 > ./result_6chains/node69_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_2 -p 900 -st topic69_4_1 -pt None -u 0.06872669201068915 > ./result_6chains/node69_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_2 -p 941 -st topic69_5_1 -pt None -u 0.01988207355178126 > ./result_6chains/node69_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_0 -p 177 -st none -pt topic69_0_0 -u 0.004933766851925092 > ./result_6chains/node69_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_0 -p 189 -st none -pt topic69_1_0 -u 0.056912025826020674 > ./result_6chains/node69_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_0 -p 230 -st none -pt topic69_2_0 -u 0.045089348203075086 > ./result_6chains/node69_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_0 -p 897 -st none -pt topic69_3_0 -u 0.03782290053587886 > ./result_6chains/node69_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_0 -p 900 -st none -pt topic69_4_0 -u 0.03895194005410493 > ./result_6chains/node69_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_0 -p 941 -st none -pt topic69_5_0 -u 0.009601166677653643 > ./result_6chains/node69_5_0.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_6chains/node69_0_0.txt 90"
    "./result_6chains/node69_0_2.txt 90"
    "./result_6chains/node69_1_0.txt 89"
    "./result_6chains/node69_1_2.txt 89"
    "./result_6chains/node69_2_0.txt 88"
    "./result_6chains/node69_2_2.txt 88"
    "./result_6chains/node69_3_0.txt 87"
    "./result_6chains/node69_3_2.txt 87"
    "./result_6chains/node69_4_0.txt 86"
    "./result_6chains/node69_4_2.txt 86"
    "./result_6chains/node69_5_0.txt 85"
    "./result_6chains/node69_5_2.txt 85"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

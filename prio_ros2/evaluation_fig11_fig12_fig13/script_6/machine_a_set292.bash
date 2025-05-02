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
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_2 -p 286 -st topic292_0_1 -pt None -u 0.01337381632359197 > ./result_6chains/node292_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_2 -p 378 -st topic292_1_1 -pt None -u 0.015494517886411319 > ./result_6chains/node292_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_2 -p 700 -st topic292_2_1 -pt None -u 0.05075522367581925 > ./result_6chains/node292_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_2 -p 740 -st topic292_3_1 -pt None -u 0.015384176480433026 > ./result_6chains/node292_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_2 -p 916 -st topic292_4_1 -pt None -u 0.07718119679551934 > ./result_6chains/node292_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_2 -p 942 -st topic292_5_1 -pt None -u 0.010153199682509835 > ./result_6chains/node292_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_0 -p 286 -st none -pt topic292_0_0 -u 0.011692265007239466 > ./result_6chains/node292_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_0 -p 378 -st none -pt topic292_1_0 -u 0.003146657454757118 > ./result_6chains/node292_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_0 -p 700 -st none -pt topic292_2_0 -u 0.056543806588632006 > ./result_6chains/node292_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_0 -p 740 -st none -pt topic292_3_0 -u 0.028395067893779158 > ./result_6chains/node292_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_0 -p 916 -st none -pt topic292_4_0 -u 0.04359095952533759 > ./result_6chains/node292_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_0 -p 942 -st none -pt topic292_5_0 -u 0.01401930413277569 > ./result_6chains/node292_5_0.txt &
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
    "./result_6chains/node292_0_0.txt 90"
    "./result_6chains/node292_0_2.txt 90"
    "./result_6chains/node292_1_0.txt 89"
    "./result_6chains/node292_1_2.txt 89"
    "./result_6chains/node292_2_0.txt 88"
    "./result_6chains/node292_2_2.txt 88"
    "./result_6chains/node292_3_0.txt 87"
    "./result_6chains/node292_3_2.txt 87"
    "./result_6chains/node292_4_0.txt 86"
    "./result_6chains/node292_4_2.txt 86"
    "./result_6chains/node292_5_0.txt 85"
    "./result_6chains/node292_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_2 -p 43 -st topic271_0_1 -pt None -u 0.00033962171581020106 > ./result_6chains/node271_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_2 -p 185 -st topic271_1_1 -pt None -u 0.008133011995166528 > ./result_6chains/node271_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_2 -p 393 -st topic271_2_1 -pt None -u 0.03158361427832421 > ./result_6chains/node271_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_2 -p 540 -st topic271_3_1 -pt None -u 0.024557844244170762 > ./result_6chains/node271_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_2 -p 576 -st topic271_4_1 -pt None -u 0.004232475043299787 > ./result_6chains/node271_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_2 -p 675 -st topic271_5_1 -pt None -u 0.013539760445319692 > ./result_6chains/node271_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_0 -p 43 -st none -pt topic271_0_0 -u 0.13316079791796892 > ./result_6chains/node271_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_0 -p 185 -st none -pt topic271_1_0 -u 0.012240337770406173 > ./result_6chains/node271_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_0 -p 393 -st none -pt topic271_2_0 -u 0.03542196934846509 > ./result_6chains/node271_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_0 -p 540 -st none -pt topic271_3_0 -u 0.010254851291528672 > ./result_6chains/node271_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_0 -p 576 -st none -pt topic271_4_0 -u 0.005674133404375795 > ./result_6chains/node271_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_0 -p 675 -st none -pt topic271_5_0 -u 0.013921150969851567 > ./result_6chains/node271_5_0.txt &
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
    "./result_6chains/node271_0_0.txt 90"
    "./result_6chains/node271_0_2.txt 90"
    "./result_6chains/node271_1_0.txt 89"
    "./result_6chains/node271_1_2.txt 89"
    "./result_6chains/node271_2_0.txt 88"
    "./result_6chains/node271_2_2.txt 88"
    "./result_6chains/node271_3_0.txt 87"
    "./result_6chains/node271_3_2.txt 87"
    "./result_6chains/node271_4_0.txt 86"
    "./result_6chains/node271_4_2.txt 86"
    "./result_6chains/node271_5_0.txt 85"
    "./result_6chains/node271_5_2.txt 85"
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

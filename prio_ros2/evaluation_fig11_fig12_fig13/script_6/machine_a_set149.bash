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
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_2 -p 102 -st topic149_0_1 -pt None -u 0.019198386158892022 > ./result_6chains/node149_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_2 -p 156 -st topic149_1_1 -pt None -u 0.015038426299608887 > ./result_6chains/node149_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_2 -p 177 -st topic149_2_1 -pt None -u 0.04037258998513937 > ./result_6chains/node149_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_2 -p 524 -st topic149_3_1 -pt None -u 0.025606225870503874 > ./result_6chains/node149_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_4_2 -p 730 -st topic149_4_1 -pt None -u 0.04959815779186168 > ./result_6chains/node149_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_5_2 -p 754 -st topic149_5_1 -pt None -u 0.03266981793718818 > ./result_6chains/node149_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_0 -p 102 -st none -pt topic149_0_0 -u 0.019635270470107546 > ./result_6chains/node149_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_0 -p 156 -st none -pt topic149_1_0 -u 0.012913720886210511 > ./result_6chains/node149_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_0 -p 177 -st none -pt topic149_2_0 -u 0.042178228729361555 > ./result_6chains/node149_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_0 -p 524 -st none -pt topic149_3_0 -u 0.0688141092646482 > ./result_6chains/node149_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_4_0 -p 730 -st none -pt topic149_4_0 -u 0.012558770235135713 > ./result_6chains/node149_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node149_5_0 -p 754 -st none -pt topic149_5_0 -u 0.017330242233234407 > ./result_6chains/node149_5_0.txt &
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
    "./result_6chains/node149_0_0.txt 90"
    "./result_6chains/node149_0_2.txt 90"
    "./result_6chains/node149_1_0.txt 89"
    "./result_6chains/node149_1_2.txt 89"
    "./result_6chains/node149_2_0.txt 88"
    "./result_6chains/node149_2_2.txt 88"
    "./result_6chains/node149_3_0.txt 87"
    "./result_6chains/node149_3_2.txt 87"
    "./result_6chains/node149_4_0.txt 86"
    "./result_6chains/node149_4_2.txt 86"
    "./result_6chains/node149_5_0.txt 85"
    "./result_6chains/node149_5_2.txt 85"
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

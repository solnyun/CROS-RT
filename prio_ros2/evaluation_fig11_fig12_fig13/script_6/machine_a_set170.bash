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
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_2 -p 83 -st topic170_0_1 -pt None -u 0.04403659566148238 > ./result_6chains/node170_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_2 -p 133 -st topic170_1_1 -pt None -u 0.04623778813706908 > ./result_6chains/node170_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_2 -p 230 -st topic170_2_1 -pt None -u 0.047357546731377875 > ./result_6chains/node170_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_2 -p 275 -st topic170_3_1 -pt None -u 0.014661151267887224 > ./result_6chains/node170_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_2 -p 697 -st topic170_4_1 -pt None -u 0.0674676341494856 > ./result_6chains/node170_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_2 -p 777 -st topic170_5_1 -pt None -u 0.028099891486685995 > ./result_6chains/node170_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_0 -p 83 -st none -pt topic170_0_0 -u 0.05698740486571918 > ./result_6chains/node170_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_0 -p 133 -st none -pt topic170_1_0 -u 0.015990591869425974 > ./result_6chains/node170_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_0 -p 230 -st none -pt topic170_2_0 -u 0.061635258081387534 > ./result_6chains/node170_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_0 -p 275 -st none -pt topic170_3_0 -u 0.0011125948338937264 > ./result_6chains/node170_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_0 -p 697 -st none -pt topic170_4_0 -u 0.01712263384947485 > ./result_6chains/node170_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_0 -p 777 -st none -pt topic170_5_0 -u 0.026918241959361315 > ./result_6chains/node170_5_0.txt &
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
    "./result_6chains/node170_0_0.txt 90"
    "./result_6chains/node170_0_2.txt 90"
    "./result_6chains/node170_1_0.txt 89"
    "./result_6chains/node170_1_2.txt 89"
    "./result_6chains/node170_2_0.txt 88"
    "./result_6chains/node170_2_2.txt 88"
    "./result_6chains/node170_3_0.txt 87"
    "./result_6chains/node170_3_2.txt 87"
    "./result_6chains/node170_4_0.txt 86"
    "./result_6chains/node170_4_2.txt 86"
    "./result_6chains/node170_5_0.txt 85"
    "./result_6chains/node170_5_2.txt 85"
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

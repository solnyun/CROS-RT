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
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_1 -p 104 -st topic194_0_0 -pt topic194_0_1 -u 0.009814133306808748 > ./result_10chains/node194_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_1 -p 152 -st topic194_1_0 -pt topic194_1_1 -u 0.040999232451542855 > ./result_10chains/node194_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_1 -p 216 -st topic194_2_0 -pt topic194_2_1 -u 0.0050090017071765525 > ./result_10chains/node194_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_1 -p 378 -st topic194_3_0 -pt topic194_3_1 -u 0.0028759165733904246 > ./result_10chains/node194_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_1 -p 478 -st topic194_4_0 -pt topic194_4_1 -u 0.0069729570434924615 > ./result_10chains/node194_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_1 -p 518 -st topic194_5_0 -pt topic194_5_1 -u 0.0008014732663067237 > ./result_10chains/node194_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_6_1 -p 568 -st topic194_6_0 -pt topic194_6_1 -u 0.004336186371930437 > ./result_10chains/node194_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_7_1 -p 748 -st topic194_7_0 -pt topic194_7_1 -u 0.0007653780025686507 > ./result_10chains/node194_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_8_1 -p 770 -st topic194_8_0 -pt topic194_8_1 -u 0.06284126437196438 > ./result_10chains/node194_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_9_1 -p 936 -st topic194_9_0 -pt topic194_9_1 -u 0.00819045069696402 > ./result_10chains/node194_9_1.txt &
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
    "./result_10chains/node194_0_1.txt 90"
    "./result_10chains/node194_1_1.txt 89"
    "./result_10chains/node194_2_1.txt 88"
    "./result_10chains/node194_3_1.txt 87"
    "./result_10chains/node194_4_1.txt 86"
    "./result_10chains/node194_5_1.txt 85"
    "./result_10chains/node194_6_1.txt 84"
    "./result_10chains/node194_7_1.txt 83"
    "./result_10chains/node194_8_1.txt 82"
    "./result_10chains/node194_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework

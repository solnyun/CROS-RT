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
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_1 -p 13 -st topic219_0_0 -pt topic219_0_1 -u 0.03589151418052583 > ./result_10chains/node219_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_1 -p 48 -st topic219_1_0 -pt topic219_1_1 -u 0.010614548872337704 > ./result_10chains/node219_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_1 -p 81 -st topic219_2_0 -pt topic219_2_1 -u 0.040385887039895374 > ./result_10chains/node219_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_1 -p 151 -st topic219_3_0 -pt topic219_3_1 -u 0.012871458081762932 > ./result_10chains/node219_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_1 -p 249 -st topic219_4_0 -pt topic219_4_1 -u 0.0016988697976439149 > ./result_10chains/node219_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_1 -p 331 -st topic219_5_0 -pt topic219_5_1 -u 0.04810376383524104 > ./result_10chains/node219_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_6_1 -p 530 -st topic219_6_0 -pt topic219_6_1 -u 0.049957710256751484 > ./result_10chains/node219_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_7_1 -p 612 -st topic219_7_0 -pt topic219_7_1 -u 0.008590983954659376 > ./result_10chains/node219_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_8_1 -p 727 -st topic219_8_0 -pt topic219_8_1 -u 0.016963652375184886 > ./result_10chains/node219_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_9_1 -p 794 -st topic219_9_0 -pt topic219_9_1 -u 0.013752256586916251 > ./result_10chains/node219_9_1.txt &
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
    "./result_10chains/node219_0_1.txt 90"
    "./result_10chains/node219_1_1.txt 89"
    "./result_10chains/node219_2_1.txt 88"
    "./result_10chains/node219_3_1.txt 87"
    "./result_10chains/node219_4_1.txt 86"
    "./result_10chains/node219_5_1.txt 85"
    "./result_10chains/node219_6_1.txt 84"
    "./result_10chains/node219_7_1.txt 83"
    "./result_10chains/node219_8_1.txt 82"
    "./result_10chains/node219_9_1.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node117_0_1 -p 246 -st topic117_0_0 -pt topic117_0_1 -u 0.012359978299039343 > ./result_10chains/node117_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_1_1 -p 319 -st topic117_1_0 -pt topic117_1_1 -u 0.0049448002576457095 > ./result_10chains/node117_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_2_1 -p 385 -st topic117_2_0 -pt topic117_2_1 -u 0.01883527279394559 > ./result_10chains/node117_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_3_1 -p 493 -st topic117_3_0 -pt topic117_3_1 -u 0.001434562529898098 > ./result_10chains/node117_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_4_1 -p 566 -st topic117_4_0 -pt topic117_4_1 -u 0.018194809506097087 > ./result_10chains/node117_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_5_1 -p 592 -st topic117_5_0 -pt topic117_5_1 -u 0.02855802014077166 > ./result_10chains/node117_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_6_1 -p 719 -st topic117_6_0 -pt topic117_6_1 -u 0.03292162440992166 > ./result_10chains/node117_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_7_1 -p 901 -st topic117_7_0 -pt topic117_7_1 -u 0.0013956122580548042 > ./result_10chains/node117_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_8_1 -p 916 -st topic117_8_0 -pt topic117_8_1 -u 0.014844965763763353 > ./result_10chains/node117_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node117_9_1 -p 933 -st topic117_9_0 -pt topic117_9_1 -u 0.02493506613736832 > ./result_10chains/node117_9_1.txt &
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
    "./result_10chains/node117_0_1.txt 90"
    "./result_10chains/node117_1_1.txt 89"
    "./result_10chains/node117_2_1.txt 88"
    "./result_10chains/node117_3_1.txt 87"
    "./result_10chains/node117_4_1.txt 86"
    "./result_10chains/node117_5_1.txt 85"
    "./result_10chains/node117_6_1.txt 84"
    "./result_10chains/node117_7_1.txt 83"
    "./result_10chains/node117_8_1.txt 82"
    "./result_10chains/node117_9_1.txt 81"
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

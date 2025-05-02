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
ros2 run evaluation_3_randomdag uunifast_node -n node450_0_1 -p 147 -st topic450_0_0 -pt topic450_0_1 -u 0.007487939858869197 > ./result_10chains/node450_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_1_1 -p 221 -st topic450_1_0 -pt topic450_1_1 -u 0.0020452284665056775 > ./result_10chains/node450_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_2_1 -p 318 -st topic450_2_0 -pt topic450_2_1 -u 0.0020571505775355825 > ./result_10chains/node450_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_3_1 -p 331 -st topic450_3_0 -pt topic450_3_1 -u 0.008577224944465112 > ./result_10chains/node450_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_4_1 -p 381 -st topic450_4_0 -pt topic450_4_1 -u 0.00777917501363623 > ./result_10chains/node450_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_5_1 -p 491 -st topic450_5_0 -pt topic450_5_1 -u 0.019367846662932703 > ./result_10chains/node450_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_6_1 -p 522 -st topic450_6_0 -pt topic450_6_1 -u 0.023678640625750813 > ./result_10chains/node450_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_7_1 -p 829 -st topic450_7_0 -pt topic450_7_1 -u 0.04666486772755329 > ./result_10chains/node450_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_8_1 -p 885 -st topic450_8_0 -pt topic450_8_1 -u 0.0005608192108302323 > ./result_10chains/node450_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node450_9_1 -p 971 -st topic450_9_0 -pt topic450_9_1 -u 0.0015055979367981157 > ./result_10chains/node450_9_1.txt &
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
    "./result_10chains/node450_0_1.txt 90"
    "./result_10chains/node450_1_1.txt 89"
    "./result_10chains/node450_2_1.txt 88"
    "./result_10chains/node450_3_1.txt 87"
    "./result_10chains/node450_4_1.txt 86"
    "./result_10chains/node450_5_1.txt 85"
    "./result_10chains/node450_6_1.txt 84"
    "./result_10chains/node450_7_1.txt 83"
    "./result_10chains/node450_8_1.txt 82"
    "./result_10chains/node450_9_1.txt 81"
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

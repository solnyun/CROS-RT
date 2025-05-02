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
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_1 -p 11 -st topic395_0_0 -pt topic395_0_1 -u 0.010689853886056977 > ./result_10chains/node395_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_1 -p 65 -st topic395_1_0 -pt topic395_1_1 -u 0.012943628405257979 > ./result_10chains/node395_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_1 -p 125 -st topic395_2_0 -pt topic395_2_1 -u 0.02412069383363369 > ./result_10chains/node395_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_1 -p 211 -st topic395_3_0 -pt topic395_3_1 -u 0.011075818914300983 > ./result_10chains/node395_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_1 -p 267 -st topic395_4_0 -pt topic395_4_1 -u 0.002811734565543289 > ./result_10chains/node395_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_1 -p 325 -st topic395_5_0 -pt topic395_5_1 -u 0.02222261415132551 > ./result_10chains/node395_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_6_1 -p 467 -st topic395_6_0 -pt topic395_6_1 -u 0.0011051673149167496 > ./result_10chains/node395_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_7_1 -p 712 -st topic395_7_0 -pt topic395_7_1 -u 0.052086975726131426 > ./result_10chains/node395_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_8_1 -p 796 -st topic395_8_0 -pt topic395_8_1 -u 0.0012123397816553583 > ./result_10chains/node395_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_9_1 -p 854 -st topic395_9_0 -pt topic395_9_1 -u 0.005216495219054203 > ./result_10chains/node395_9_1.txt &
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
    "./result_10chains/node395_0_1.txt 90"
    "./result_10chains/node395_1_1.txt 89"
    "./result_10chains/node395_2_1.txt 88"
    "./result_10chains/node395_3_1.txt 87"
    "./result_10chains/node395_4_1.txt 86"
    "./result_10chains/node395_5_1.txt 85"
    "./result_10chains/node395_6_1.txt 84"
    "./result_10chains/node395_7_1.txt 83"
    "./result_10chains/node395_8_1.txt 82"
    "./result_10chains/node395_9_1.txt 81"
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

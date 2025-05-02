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
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_1 -p 25 -st topic11_0_0 -pt topic11_0_1 -u 0.00976320361809957 > ./result_8chains/node11_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_1 -p 272 -st topic11_1_0 -pt topic11_1_1 -u 0.043483489822568056 > ./result_8chains/node11_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_1 -p 309 -st topic11_2_0 -pt topic11_2_1 -u 0.02631612095853969 > ./result_8chains/node11_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_1 -p 395 -st topic11_3_0 -pt topic11_3_1 -u 0.026312468015049162 > ./result_8chains/node11_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_1 -p 682 -st topic11_4_0 -pt topic11_4_1 -u 0.010039729875255421 > ./result_8chains/node11_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_1 -p 727 -st topic11_5_0 -pt topic11_5_1 -u 0.014773534492453999 > ./result_8chains/node11_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_6_1 -p 834 -st topic11_6_0 -pt topic11_6_1 -u 0.00939921634747179 > ./result_8chains/node11_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_7_1 -p 944 -st topic11_7_0 -pt topic11_7_1 -u 0.025399958249618257 > ./result_8chains/node11_7_1.txt &
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
    "./result_8chains/node11_0_1.txt 90"
    "./result_8chains/node11_1_1.txt 89"
    "./result_8chains/node11_2_1.txt 88"
    "./result_8chains/node11_3_1.txt 87"
    "./result_8chains/node11_4_1.txt 86"
    "./result_8chains/node11_5_1.txt 85"
    "./result_8chains/node11_6_1.txt 84"
    "./result_8chains/node11_7_1.txt 83"
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

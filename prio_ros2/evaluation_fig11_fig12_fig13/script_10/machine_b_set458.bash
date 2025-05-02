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
ros2 run evaluation_3_randomdag uunifast_node -n node458_0_1 -p 239 -st topic458_0_0 -pt topic458_0_1 -u 0.017399489495557696 > ./result_10chains/node458_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_1_1 -p 332 -st topic458_1_0 -pt topic458_1_1 -u 0.019877001660450533 > ./result_10chains/node458_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_2_1 -p 348 -st topic458_2_0 -pt topic458_2_1 -u 0.013326667479299725 > ./result_10chains/node458_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_3_1 -p 458 -st topic458_3_0 -pt topic458_3_1 -u 0.03714918016374685 > ./result_10chains/node458_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_4_1 -p 521 -st topic458_4_0 -pt topic458_4_1 -u 0.0031848233934289594 > ./result_10chains/node458_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_5_1 -p 550 -st topic458_5_0 -pt topic458_5_1 -u 0.0031479822717578876 > ./result_10chains/node458_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_6_1 -p 750 -st topic458_6_0 -pt topic458_6_1 -u 0.00042645855871739635 > ./result_10chains/node458_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_7_1 -p 840 -st topic458_7_0 -pt topic458_7_1 -u 0.01668737439005072 > ./result_10chains/node458_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_8_1 -p 854 -st topic458_8_0 -pt topic458_8_1 -u 0.005263352292219331 > ./result_10chains/node458_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_9_1 -p 936 -st topic458_9_0 -pt topic458_9_1 -u 0.01498613621825582 > ./result_10chains/node458_9_1.txt &
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
    "./result_10chains/node458_0_1.txt 90"
    "./result_10chains/node458_1_1.txt 89"
    "./result_10chains/node458_2_1.txt 88"
    "./result_10chains/node458_3_1.txt 87"
    "./result_10chains/node458_4_1.txt 86"
    "./result_10chains/node458_5_1.txt 85"
    "./result_10chains/node458_6_1.txt 84"
    "./result_10chains/node458_7_1.txt 83"
    "./result_10chains/node458_8_1.txt 82"
    "./result_10chains/node458_9_1.txt 81"
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

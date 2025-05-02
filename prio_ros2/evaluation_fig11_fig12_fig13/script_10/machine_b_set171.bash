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
ros2 run evaluation_3_randomdag uunifast_node -n node171_0_1 -p 263 -st topic171_0_0 -pt topic171_0_1 -u 0.05067311037361827 > ./result_10chains/node171_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_1_1 -p 376 -st topic171_1_0 -pt topic171_1_1 -u 0.024634564570219952 > ./result_10chains/node171_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_2_1 -p 379 -st topic171_2_0 -pt topic171_2_1 -u 0.0064834868660090805 > ./result_10chains/node171_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_3_1 -p 429 -st topic171_3_0 -pt topic171_3_1 -u 0.014734491610713552 > ./result_10chains/node171_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_4_1 -p 580 -st topic171_4_0 -pt topic171_4_1 -u 0.003957845165857343 > ./result_10chains/node171_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_5_1 -p 635 -st topic171_5_0 -pt topic171_5_1 -u 0.0041806048193002154 > ./result_10chains/node171_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_6_1 -p 647 -st topic171_6_0 -pt topic171_6_1 -u 0.00522882900383384 > ./result_10chains/node171_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_7_1 -p 916 -st topic171_7_0 -pt topic171_7_1 -u 0.0011222212871715986 > ./result_10chains/node171_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_8_1 -p 926 -st topic171_8_0 -pt topic171_8_1 -u 0.06621632683041534 > ./result_10chains/node171_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node171_9_1 -p 933 -st topic171_9_0 -pt topic171_9_1 -u 0.012420482050245192 > ./result_10chains/node171_9_1.txt &
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
    "./result_10chains/node171_0_1.txt 90"
    "./result_10chains/node171_1_1.txt 89"
    "./result_10chains/node171_2_1.txt 88"
    "./result_10chains/node171_3_1.txt 87"
    "./result_10chains/node171_4_1.txt 86"
    "./result_10chains/node171_5_1.txt 85"
    "./result_10chains/node171_6_1.txt 84"
    "./result_10chains/node171_7_1.txt 83"
    "./result_10chains/node171_8_1.txt 82"
    "./result_10chains/node171_9_1.txt 81"
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

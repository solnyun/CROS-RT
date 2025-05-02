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
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_1 -p 117 -st topic286_0_0 -pt topic286_0_1 -u 0.024436756726241626 > ./result_10chains/node286_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_1 -p 172 -st topic286_1_0 -pt topic286_1_1 -u 0.012475843790800856 > ./result_10chains/node286_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_1 -p 348 -st topic286_2_0 -pt topic286_2_1 -u 0.009984623113269364 > ./result_10chains/node286_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_1 -p 620 -st topic286_3_0 -pt topic286_3_1 -u 0.004939368602300709 > ./result_10chains/node286_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_4_1 -p 695 -st topic286_4_0 -pt topic286_4_1 -u 0.00139758827298736 > ./result_10chains/node286_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_5_1 -p 884 -st topic286_5_0 -pt topic286_5_1 -u 0.045333274030976756 > ./result_10chains/node286_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_6_1 -p 897 -st topic286_6_0 -pt topic286_6_1 -u 0.02413724017160332 > ./result_10chains/node286_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_7_1 -p 955 -st topic286_7_0 -pt topic286_7_1 -u 0.03202063897811813 > ./result_10chains/node286_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_8_1 -p 977 -st topic286_8_0 -pt topic286_8_1 -u 0.03694356887416604 > ./result_10chains/node286_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_9_1 -p 986 -st topic286_9_0 -pt topic286_9_1 -u 0.0017737309216766697 > ./result_10chains/node286_9_1.txt &
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
    "./result_10chains/node286_0_1.txt 90"
    "./result_10chains/node286_1_1.txt 89"
    "./result_10chains/node286_2_1.txt 88"
    "./result_10chains/node286_3_1.txt 87"
    "./result_10chains/node286_4_1.txt 86"
    "./result_10chains/node286_5_1.txt 85"
    "./result_10chains/node286_6_1.txt 84"
    "./result_10chains/node286_7_1.txt 83"
    "./result_10chains/node286_8_1.txt 82"
    "./result_10chains/node286_9_1.txt 81"
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

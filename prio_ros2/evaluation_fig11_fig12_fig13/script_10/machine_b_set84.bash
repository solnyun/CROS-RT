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
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_1 -p 34 -st topic84_0_0 -pt topic84_0_1 -u 0.018558349164262244 > ./result_10chains/node84_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_1 -p 223 -st topic84_1_0 -pt topic84_1_1 -u 0.023105255476537634 > ./result_10chains/node84_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_1 -p 224 -st topic84_2_0 -pt topic84_2_1 -u 0.007438403731297394 > ./result_10chains/node84_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_1 -p 328 -st topic84_3_0 -pt topic84_3_1 -u 0.023046758207027118 > ./result_10chains/node84_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_1 -p 337 -st topic84_4_0 -pt topic84_4_1 -u 0.00776729604647064 > ./result_10chains/node84_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_1 -p 429 -st topic84_5_0 -pt topic84_5_1 -u 0.00017105996079003205 > ./result_10chains/node84_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_6_1 -p 478 -st topic84_6_0 -pt topic84_6_1 -u 0.03131489271866689 > ./result_10chains/node84_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_7_1 -p 827 -st topic84_7_0 -pt topic84_7_1 -u 0.011902783729498809 > ./result_10chains/node84_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_8_1 -p 868 -st topic84_8_0 -pt topic84_8_1 -u 0.02539303505294649 > ./result_10chains/node84_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_9_1 -p 936 -st topic84_9_0 -pt topic84_9_1 -u 0.01128114717431393 > ./result_10chains/node84_9_1.txt &
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
    "./result_10chains/node84_0_1.txt 90"
    "./result_10chains/node84_1_1.txt 89"
    "./result_10chains/node84_2_1.txt 88"
    "./result_10chains/node84_3_1.txt 87"
    "./result_10chains/node84_4_1.txt 86"
    "./result_10chains/node84_5_1.txt 85"
    "./result_10chains/node84_6_1.txt 84"
    "./result_10chains/node84_7_1.txt 83"
    "./result_10chains/node84_8_1.txt 82"
    "./result_10chains/node84_9_1.txt 81"
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

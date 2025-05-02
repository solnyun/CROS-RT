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
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_1 -p 126 -st topic112_0_0 -pt topic112_0_1 -u 0.0133310981682499 > ./result_10chains/node112_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_1 -p 273 -st topic112_1_0 -pt topic112_1_1 -u 0.029635565042482714 > ./result_10chains/node112_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_1 -p 373 -st topic112_2_0 -pt topic112_2_1 -u 0.008452585329779772 > ./result_10chains/node112_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_1 -p 423 -st topic112_3_0 -pt topic112_3_1 -u 0.016952770012844925 > ./result_10chains/node112_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_1 -p 510 -st topic112_4_0 -pt topic112_4_1 -u 0.024861953915597063 > ./result_10chains/node112_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_1 -p 793 -st topic112_5_0 -pt topic112_5_1 -u 0.012882889133176922 > ./result_10chains/node112_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_6_1 -p 811 -st topic112_6_0 -pt topic112_6_1 -u 0.004568801175497933 > ./result_10chains/node112_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_7_1 -p 872 -st topic112_7_0 -pt topic112_7_1 -u 0.029484729160179662 > ./result_10chains/node112_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_8_1 -p 905 -st topic112_8_0 -pt topic112_8_1 -u 0.025744665817426654 > ./result_10chains/node112_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_9_1 -p 937 -st topic112_9_0 -pt topic112_9_1 -u 0.01061453382009472 > ./result_10chains/node112_9_1.txt &
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
    "./result_10chains/node112_0_1.txt 90"
    "./result_10chains/node112_1_1.txt 89"
    "./result_10chains/node112_2_1.txt 88"
    "./result_10chains/node112_3_1.txt 87"
    "./result_10chains/node112_4_1.txt 86"
    "./result_10chains/node112_5_1.txt 85"
    "./result_10chains/node112_6_1.txt 84"
    "./result_10chains/node112_7_1.txt 83"
    "./result_10chains/node112_8_1.txt 82"
    "./result_10chains/node112_9_1.txt 81"
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

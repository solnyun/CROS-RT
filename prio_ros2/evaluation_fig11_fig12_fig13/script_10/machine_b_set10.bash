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
ros2 run evaluation_3_randomdag uunifast_node -n node10_0_1 -p 10 -st topic10_0_0 -pt topic10_0_1 -u 0.00038302530522305034 > ./result_10chains/node10_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_1_1 -p 73 -st topic10_1_0 -pt topic10_1_1 -u 0.010069498894412054 > ./result_10chains/node10_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_2_1 -p 255 -st topic10_2_0 -pt topic10_2_1 -u 0.015975872285079906 > ./result_10chains/node10_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_3_1 -p 292 -st topic10_3_0 -pt topic10_3_1 -u 0.02434234669187274 > ./result_10chains/node10_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_4_1 -p 506 -st topic10_4_0 -pt topic10_4_1 -u 0.0048757328867684024 > ./result_10chains/node10_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_5_1 -p 510 -st topic10_5_0 -pt topic10_5_1 -u 0.007099488004335186 > ./result_10chains/node10_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_6_1 -p 550 -st topic10_6_0 -pt topic10_6_1 -u 0.038831664352695056 > ./result_10chains/node10_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_7_1 -p 595 -st topic10_7_0 -pt topic10_7_1 -u 0.03225499964653647 > ./result_10chains/node10_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_8_1 -p 610 -st topic10_8_0 -pt topic10_8_1 -u 0.030376926933008218 > ./result_10chains/node10_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node10_9_1 -p 749 -st topic10_9_0 -pt topic10_9_1 -u 0.012968589052412704 > ./result_10chains/node10_9_1.txt &
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
    "./result_10chains/node10_0_1.txt 90"
    "./result_10chains/node10_1_1.txt 89"
    "./result_10chains/node10_2_1.txt 88"
    "./result_10chains/node10_3_1.txt 87"
    "./result_10chains/node10_4_1.txt 86"
    "./result_10chains/node10_5_1.txt 85"
    "./result_10chains/node10_6_1.txt 84"
    "./result_10chains/node10_7_1.txt 83"
    "./result_10chains/node10_8_1.txt 82"
    "./result_10chains/node10_9_1.txt 81"
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

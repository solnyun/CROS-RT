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
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_1 -p 37 -st topic475_0_0 -pt topic475_0_1 -u 0.01583484383919742 > ./result_10chains/node475_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_1 -p 114 -st topic475_1_0 -pt topic475_1_1 -u 0.012041946733106601 > ./result_10chains/node475_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_1 -p 166 -st topic475_2_0 -pt topic475_2_1 -u 0.008275035114376272 > ./result_10chains/node475_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_1 -p 194 -st topic475_3_0 -pt topic475_3_1 -u 0.030669482729050568 > ./result_10chains/node475_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_1 -p 334 -st topic475_4_0 -pt topic475_4_1 -u 0.0011283609361446567 > ./result_10chains/node475_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_1 -p 473 -st topic475_5_0 -pt topic475_5_1 -u 0.03143111999941256 > ./result_10chains/node475_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_6_1 -p 643 -st topic475_6_0 -pt topic475_6_1 -u 0.0020421277583641817 > ./result_10chains/node475_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_7_1 -p 840 -st topic475_7_0 -pt topic475_7_1 -u 0.04669480165437801 > ./result_10chains/node475_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_8_1 -p 854 -st topic475_8_0 -pt topic475_8_1 -u 0.009392742723894634 > ./result_10chains/node475_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_9_1 -p 884 -st topic475_9_0 -pt topic475_9_1 -u 0.0032187898363816806 > ./result_10chains/node475_9_1.txt &
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
    "./result_10chains/node475_0_1.txt 90"
    "./result_10chains/node475_1_1.txt 89"
    "./result_10chains/node475_2_1.txt 88"
    "./result_10chains/node475_3_1.txt 87"
    "./result_10chains/node475_4_1.txt 86"
    "./result_10chains/node475_5_1.txt 85"
    "./result_10chains/node475_6_1.txt 84"
    "./result_10chains/node475_7_1.txt 83"
    "./result_10chains/node475_8_1.txt 82"
    "./result_10chains/node475_9_1.txt 81"
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

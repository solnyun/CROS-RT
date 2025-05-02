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
ros2 run evaluation_3_randomdag uunifast_node -n node11_0_1 -p 227 -st topic11_0_0 -pt topic11_0_1 -u 0.04668074203145378 > ./result_10chains/node11_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_1_1 -p 248 -st topic11_1_0 -pt topic11_1_1 -u 0.021948678132471644 > ./result_10chains/node11_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_2_1 -p 457 -st topic11_2_0 -pt topic11_2_1 -u 0.027265401846797654 > ./result_10chains/node11_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_3_1 -p 470 -st topic11_3_0 -pt topic11_3_1 -u 0.036787554122326205 > ./result_10chains/node11_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_4_1 -p 519 -st topic11_4_0 -pt topic11_4_1 -u 0.010025632435217563 > ./result_10chains/node11_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_5_1 -p 648 -st topic11_5_0 -pt topic11_5_1 -u 0.010005337703315798 > ./result_10chains/node11_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_6_1 -p 699 -st topic11_6_0 -pt topic11_6_1 -u 0.011802950228273434 > ./result_10chains/node11_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_7_1 -p 734 -st topic11_7_0 -pt topic11_7_1 -u 0.007327238039448375 > ./result_10chains/node11_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_8_1 -p 738 -st topic11_8_0 -pt topic11_8_1 -u 0.022329492180184346 > ./result_10chains/node11_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node11_9_1 -p 976 -st topic11_9_0 -pt topic11_9_1 -u 0.013203528290104162 > ./result_10chains/node11_9_1.txt &
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
    "./result_10chains/node11_0_1.txt 90"
    "./result_10chains/node11_1_1.txt 89"
    "./result_10chains/node11_2_1.txt 88"
    "./result_10chains/node11_3_1.txt 87"
    "./result_10chains/node11_4_1.txt 86"
    "./result_10chains/node11_5_1.txt 85"
    "./result_10chains/node11_6_1.txt 84"
    "./result_10chains/node11_7_1.txt 83"
    "./result_10chains/node11_8_1.txt 82"
    "./result_10chains/node11_9_1.txt 81"
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

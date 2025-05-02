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
ros2 run evaluation_3_randomdag uunifast_node -n node27_0_1 -p 166 -st topic27_0_0 -pt topic27_0_1 -u 0.01582388444372279 > ./result_10chains/node27_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_1_1 -p 224 -st topic27_1_0 -pt topic27_1_1 -u 0.015415218531165176 > ./result_10chains/node27_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_2_1 -p 304 -st topic27_2_0 -pt topic27_2_1 -u 0.0012620650692380941 > ./result_10chains/node27_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_3_1 -p 331 -st topic27_3_0 -pt topic27_3_1 -u 0.018841120663895428 > ./result_10chains/node27_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_4_1 -p 357 -st topic27_4_0 -pt topic27_4_1 -u 0.006678218394978952 > ./result_10chains/node27_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_5_1 -p 648 -st topic27_5_0 -pt topic27_5_1 -u 0.0009507429949103252 > ./result_10chains/node27_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_6_1 -p 654 -st topic27_6_0 -pt topic27_6_1 -u 0.023615427060297622 > ./result_10chains/node27_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_7_1 -p 682 -st topic27_7_0 -pt topic27_7_1 -u 0.007562049055458486 > ./result_10chains/node27_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_8_1 -p 745 -st topic27_8_0 -pt topic27_8_1 -u 0.02518048505400068 > ./result_10chains/node27_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node27_9_1 -p 851 -st topic27_9_0 -pt topic27_9_1 -u 0.061732455035771926 > ./result_10chains/node27_9_1.txt &
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
    "./result_10chains/node27_0_1.txt 90"
    "./result_10chains/node27_1_1.txt 89"
    "./result_10chains/node27_2_1.txt 88"
    "./result_10chains/node27_3_1.txt 87"
    "./result_10chains/node27_4_1.txt 86"
    "./result_10chains/node27_5_1.txt 85"
    "./result_10chains/node27_6_1.txt 84"
    "./result_10chains/node27_7_1.txt 83"
    "./result_10chains/node27_8_1.txt 82"
    "./result_10chains/node27_9_1.txt 81"
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

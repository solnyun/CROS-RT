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
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_1 -p 175 -st topic32_0_0 -pt topic32_0_1 -u 0.0020931344536019303 > ./result_8chains/node32_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_1 -p 265 -st topic32_1_0 -pt topic32_1_1 -u 0.022028614674899083 > ./result_8chains/node32_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_1 -p 389 -st topic32_2_0 -pt topic32_2_1 -u 0.010830607763031297 > ./result_8chains/node32_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_1 -p 574 -st topic32_3_0 -pt topic32_3_1 -u 0.017723384253424457 > ./result_8chains/node32_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_1 -p 631 -st topic32_4_0 -pt topic32_4_1 -u 0.029247768038931032 > ./result_8chains/node32_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_1 -p 683 -st topic32_5_0 -pt topic32_5_1 -u 0.037508768367424866 > ./result_8chains/node32_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_6_1 -p 705 -st topic32_6_0 -pt topic32_6_1 -u 0.05376525203126746 > ./result_8chains/node32_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node32_7_1 -p 979 -st topic32_7_0 -pt topic32_7_1 -u 0.0052686914739696195 > ./result_8chains/node32_7_1.txt &
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
    "./result_8chains/node32_0_1.txt 90"
    "./result_8chains/node32_1_1.txt 89"
    "./result_8chains/node32_2_1.txt 88"
    "./result_8chains/node32_3_1.txt 87"
    "./result_8chains/node32_4_1.txt 86"
    "./result_8chains/node32_5_1.txt 85"
    "./result_8chains/node32_6_1.txt 84"
    "./result_8chains/node32_7_1.txt 83"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node223_0_1 -p 27 -st topic223_0_0 -pt topic223_0_1 -u 0.0347392365347034 > ./result_10chains/node223_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_1_1 -p 150 -st topic223_1_0 -pt topic223_1_1 -u 0.012417666158651475 > ./result_10chains/node223_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_2_1 -p 283 -st topic223_2_0 -pt topic223_2_1 -u 0.002888057503910524 > ./result_10chains/node223_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_3_1 -p 400 -st topic223_3_0 -pt topic223_3_1 -u 0.0038271966725456075 > ./result_10chains/node223_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_4_1 -p 407 -st topic223_4_0 -pt topic223_4_1 -u 0.016258021871780992 > ./result_10chains/node223_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_5_1 -p 637 -st topic223_5_0 -pt topic223_5_1 -u 0.0035936757260724705 > ./result_10chains/node223_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_6_1 -p 796 -st topic223_6_0 -pt topic223_6_1 -u 0.01347853609635713 > ./result_10chains/node223_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_7_1 -p 813 -st topic223_7_0 -pt topic223_7_1 -u 0.049776706418589695 > ./result_10chains/node223_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_8_1 -p 864 -st topic223_8_0 -pt topic223_8_1 -u 0.0734485122703547 > ./result_10chains/node223_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_9_1 -p 966 -st topic223_9_0 -pt topic223_9_1 -u 0.002709936945135975 > ./result_10chains/node223_9_1.txt &
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
    "./result_10chains/node223_0_1.txt 90"
    "./result_10chains/node223_1_1.txt 89"
    "./result_10chains/node223_2_1.txt 88"
    "./result_10chains/node223_3_1.txt 87"
    "./result_10chains/node223_4_1.txt 86"
    "./result_10chains/node223_5_1.txt 85"
    "./result_10chains/node223_6_1.txt 84"
    "./result_10chains/node223_7_1.txt 83"
    "./result_10chains/node223_8_1.txt 82"
    "./result_10chains/node223_9_1.txt 81"
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

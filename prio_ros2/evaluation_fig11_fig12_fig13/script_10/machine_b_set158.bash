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
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_1 -p 101 -st topic158_0_0 -pt topic158_0_1 -u 0.002384270005028888 > ./result_10chains/node158_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_1 -p 127 -st topic158_1_0 -pt topic158_1_1 -u 0.05250712270124769 > ./result_10chains/node158_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_1 -p 135 -st topic158_2_0 -pt topic158_2_1 -u 0.034016536131137365 > ./result_10chains/node158_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_1 -p 273 -st topic158_3_0 -pt topic158_3_1 -u 0.0026219340239078126 > ./result_10chains/node158_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_4_1 -p 279 -st topic158_4_0 -pt topic158_4_1 -u 0.011722446212656612 > ./result_10chains/node158_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_5_1 -p 310 -st topic158_5_0 -pt topic158_5_1 -u 0.0007507008391327008 > ./result_10chains/node158_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_6_1 -p 353 -st topic158_6_0 -pt topic158_6_1 -u 0.04795575292687157 > ./result_10chains/node158_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_7_1 -p 425 -st topic158_7_0 -pt topic158_7_1 -u 0.0021601326456478775 > ./result_10chains/node158_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_8_1 -p 884 -st topic158_8_0 -pt topic158_8_1 -u 0.0022386822707291115 > ./result_10chains/node158_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_9_1 -p 985 -st topic158_9_0 -pt topic158_9_1 -u 0.004911526287725135 > ./result_10chains/node158_9_1.txt &
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
    "./result_10chains/node158_0_1.txt 90"
    "./result_10chains/node158_1_1.txt 89"
    "./result_10chains/node158_2_1.txt 88"
    "./result_10chains/node158_3_1.txt 87"
    "./result_10chains/node158_4_1.txt 86"
    "./result_10chains/node158_5_1.txt 85"
    "./result_10chains/node158_6_1.txt 84"
    "./result_10chains/node158_7_1.txt 83"
    "./result_10chains/node158_8_1.txt 82"
    "./result_10chains/node158_9_1.txt 81"
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

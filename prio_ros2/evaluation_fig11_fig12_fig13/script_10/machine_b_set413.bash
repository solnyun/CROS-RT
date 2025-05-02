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
ros2 run evaluation_3_randomdag uunifast_node -n node413_0_1 -p 19 -st topic413_0_0 -pt topic413_0_1 -u 0.011231991419611675 > ./result_10chains/node413_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_1_1 -p 308 -st topic413_1_0 -pt topic413_1_1 -u 0.01327691769690914 > ./result_10chains/node413_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_2_1 -p 365 -st topic413_2_0 -pt topic413_2_1 -u 0.03626256037653541 > ./result_10chains/node413_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_3_1 -p 405 -st topic413_3_0 -pt topic413_3_1 -u 0.00923318188067318 > ./result_10chains/node413_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_4_1 -p 463 -st topic413_4_0 -pt topic413_4_1 -u 0.004272897032192857 > ./result_10chains/node413_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_5_1 -p 512 -st topic413_5_0 -pt topic413_5_1 -u 0.0020996739780405893 > ./result_10chains/node413_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_6_1 -p 584 -st topic413_6_0 -pt topic413_6_1 -u 0.005831548020294869 > ./result_10chains/node413_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_7_1 -p 823 -st topic413_7_0 -pt topic413_7_1 -u 0.005951170969416331 > ./result_10chains/node413_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_8_1 -p 832 -st topic413_8_0 -pt topic413_8_1 -u 0.017273935431880313 > ./result_10chains/node413_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node413_9_1 -p 944 -st topic413_9_0 -pt topic413_9_1 -u 0.03469654082505608 > ./result_10chains/node413_9_1.txt &
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
    "./result_10chains/node413_0_1.txt 90"
    "./result_10chains/node413_1_1.txt 89"
    "./result_10chains/node413_2_1.txt 88"
    "./result_10chains/node413_3_1.txt 87"
    "./result_10chains/node413_4_1.txt 86"
    "./result_10chains/node413_5_1.txt 85"
    "./result_10chains/node413_6_1.txt 84"
    "./result_10chains/node413_7_1.txt 83"
    "./result_10chains/node413_8_1.txt 82"
    "./result_10chains/node413_9_1.txt 81"
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

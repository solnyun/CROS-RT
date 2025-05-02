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
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_1 -p 132 -st topic284_0_0 -pt topic284_0_1 -u 0.06390258465895271 > ./result_10chains/node284_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_1 -p 226 -st topic284_1_0 -pt topic284_1_1 -u 0.014069641868033222 > ./result_10chains/node284_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_1 -p 267 -st topic284_2_0 -pt topic284_2_1 -u 0.0059748724746279125 > ./result_10chains/node284_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_1 -p 294 -st topic284_3_0 -pt topic284_3_1 -u 0.012183818774195943 > ./result_10chains/node284_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_1 -p 334 -st topic284_4_0 -pt topic284_4_1 -u 0.00024058405086391232 > ./result_10chains/node284_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_1 -p 534 -st topic284_5_0 -pt topic284_5_1 -u 0.014306098746117046 > ./result_10chains/node284_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_6_1 -p 624 -st topic284_6_0 -pt topic284_6_1 -u 0.020362146604011783 > ./result_10chains/node284_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_7_1 -p 695 -st topic284_7_0 -pt topic284_7_1 -u 0.027687652049919298 > ./result_10chains/node284_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_8_1 -p 734 -st topic284_8_0 -pt topic284_8_1 -u 0.0025843394098238742 > ./result_10chains/node284_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_9_1 -p 749 -st topic284_9_0 -pt topic284_9_1 -u 0.046100863284615975 > ./result_10chains/node284_9_1.txt &
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
    "./result_10chains/node284_0_1.txt 90"
    "./result_10chains/node284_1_1.txt 89"
    "./result_10chains/node284_2_1.txt 88"
    "./result_10chains/node284_3_1.txt 87"
    "./result_10chains/node284_4_1.txt 86"
    "./result_10chains/node284_5_1.txt 85"
    "./result_10chains/node284_6_1.txt 84"
    "./result_10chains/node284_7_1.txt 83"
    "./result_10chains/node284_8_1.txt 82"
    "./result_10chains/node284_9_1.txt 81"
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

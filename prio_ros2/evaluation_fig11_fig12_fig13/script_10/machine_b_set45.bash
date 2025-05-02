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
ros2 run evaluation_3_randomdag uunifast_node -n node45_0_1 -p 27 -st topic45_0_0 -pt topic45_0_1 -u 0.00408351131736312 > ./result_10chains/node45_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_1_1 -p 114 -st topic45_1_0 -pt topic45_1_1 -u 0.05231140496513942 > ./result_10chains/node45_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_2_1 -p 153 -st topic45_2_0 -pt topic45_2_1 -u 0.008172009131932723 > ./result_10chains/node45_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_3_1 -p 306 -st topic45_3_0 -pt topic45_3_1 -u 0.011389549885214678 > ./result_10chains/node45_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_4_1 -p 357 -st topic45_4_0 -pt topic45_4_1 -u 0.018331373495383052 > ./result_10chains/node45_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_5_1 -p 366 -st topic45_5_0 -pt topic45_5_1 -u 0.008838705931578872 > ./result_10chains/node45_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_6_1 -p 421 -st topic45_6_0 -pt topic45_6_1 -u 0.03686715573312918 > ./result_10chains/node45_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_7_1 -p 804 -st topic45_7_0 -pt topic45_7_1 -u 0.02790231496886498 > ./result_10chains/node45_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_8_1 -p 941 -st topic45_8_0 -pt topic45_8_1 -u 0.003324431592403934 > ./result_10chains/node45_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node45_9_1 -p 949 -st topic45_9_0 -pt topic45_9_1 -u 0.004653644566847066 > ./result_10chains/node45_9_1.txt &
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
    "./result_10chains/node45_0_1.txt 90"
    "./result_10chains/node45_1_1.txt 89"
    "./result_10chains/node45_2_1.txt 88"
    "./result_10chains/node45_3_1.txt 87"
    "./result_10chains/node45_4_1.txt 86"
    "./result_10chains/node45_5_1.txt 85"
    "./result_10chains/node45_6_1.txt 84"
    "./result_10chains/node45_7_1.txt 83"
    "./result_10chains/node45_8_1.txt 82"
    "./result_10chains/node45_9_1.txt 81"
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

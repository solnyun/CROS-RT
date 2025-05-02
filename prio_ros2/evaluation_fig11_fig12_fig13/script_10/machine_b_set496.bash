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
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_1 -p 76 -st topic496_0_0 -pt topic496_0_1 -u 0.033609962133368254 > ./result_10chains/node496_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_1 -p 114 -st topic496_1_0 -pt topic496_1_1 -u 0.008806550959369053 > ./result_10chains/node496_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_1 -p 196 -st topic496_2_0 -pt topic496_2_1 -u 0.028937858121969584 > ./result_10chains/node496_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_1 -p 241 -st topic496_3_0 -pt topic496_3_1 -u 0.0001523418534438159 > ./result_10chains/node496_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_1 -p 438 -st topic496_4_0 -pt topic496_4_1 -u 0.01479461593703113 > ./result_10chains/node496_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_1 -p 578 -st topic496_5_0 -pt topic496_5_1 -u 0.021504651820753423 > ./result_10chains/node496_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_6_1 -p 711 -st topic496_6_0 -pt topic496_6_1 -u 0.014465677784994663 > ./result_10chains/node496_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_7_1 -p 731 -st topic496_7_0 -pt topic496_7_1 -u 0.004707631976450549 > ./result_10chains/node496_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_8_1 -p 780 -st topic496_8_0 -pt topic496_8_1 -u 0.006281857006133297 > ./result_10chains/node496_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_9_1 -p 996 -st topic496_9_0 -pt topic496_9_1 -u 0.015348625349322308 > ./result_10chains/node496_9_1.txt &
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
    "./result_10chains/node496_0_1.txt 90"
    "./result_10chains/node496_1_1.txt 89"
    "./result_10chains/node496_2_1.txt 88"
    "./result_10chains/node496_3_1.txt 87"
    "./result_10chains/node496_4_1.txt 86"
    "./result_10chains/node496_5_1.txt 85"
    "./result_10chains/node496_6_1.txt 84"
    "./result_10chains/node496_7_1.txt 83"
    "./result_10chains/node496_8_1.txt 82"
    "./result_10chains/node496_9_1.txt 81"
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

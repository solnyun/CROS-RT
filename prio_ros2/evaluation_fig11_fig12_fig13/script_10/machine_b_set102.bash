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
ros2 run evaluation_3_randomdag uunifast_node -n node102_0_1 -p 30 -st topic102_0_0 -pt topic102_0_1 -u 0.008484507127455743 > ./result_10chains/node102_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_1_1 -p 261 -st topic102_1_0 -pt topic102_1_1 -u 0.05251482965173315 > ./result_10chains/node102_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_2_1 -p 403 -st topic102_2_0 -pt topic102_2_1 -u 0.025925259132902223 > ./result_10chains/node102_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_3_1 -p 564 -st topic102_3_0 -pt topic102_3_1 -u 0.002635308588630203 > ./result_10chains/node102_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_4_1 -p 685 -st topic102_4_0 -pt topic102_4_1 -u 0.012430134253076763 > ./result_10chains/node102_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_5_1 -p 715 -st topic102_5_0 -pt topic102_5_1 -u 0.020083711915691665 > ./result_10chains/node102_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_6_1 -p 721 -st topic102_6_0 -pt topic102_6_1 -u 0.0032395567705645334 > ./result_10chains/node102_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_7_1 -p 730 -st topic102_7_0 -pt topic102_7_1 -u 0.03783560003689257 > ./result_10chains/node102_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_8_1 -p 841 -st topic102_8_0 -pt topic102_8_1 -u 0.023063884725415318 > ./result_10chains/node102_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_9_1 -p 858 -st topic102_9_0 -pt topic102_9_1 -u 0.0006350340058937625 > ./result_10chains/node102_9_1.txt &
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
    "./result_10chains/node102_0_1.txt 90"
    "./result_10chains/node102_1_1.txt 89"
    "./result_10chains/node102_2_1.txt 88"
    "./result_10chains/node102_3_1.txt 87"
    "./result_10chains/node102_4_1.txt 86"
    "./result_10chains/node102_5_1.txt 85"
    "./result_10chains/node102_6_1.txt 84"
    "./result_10chains/node102_7_1.txt 83"
    "./result_10chains/node102_8_1.txt 82"
    "./result_10chains/node102_9_1.txt 81"
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

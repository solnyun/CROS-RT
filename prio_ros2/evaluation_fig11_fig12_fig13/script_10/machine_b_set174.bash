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
ros2 run evaluation_3_randomdag uunifast_node -n node174_0_1 -p 50 -st topic174_0_0 -pt topic174_0_1 -u 0.017802217942640253 > ./result_10chains/node174_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_1_1 -p 74 -st topic174_1_0 -pt topic174_1_1 -u 0.0017935252413991964 > ./result_10chains/node174_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_2_1 -p 98 -st topic174_2_0 -pt topic174_2_1 -u 0.010131942745953693 > ./result_10chains/node174_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_3_1 -p 175 -st topic174_3_0 -pt topic174_3_1 -u 6.383508445723107e-05 > ./result_10chains/node174_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_4_1 -p 265 -st topic174_4_0 -pt topic174_4_1 -u 0.002993520824671747 > ./result_10chains/node174_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_5_1 -p 417 -st topic174_5_0 -pt topic174_5_1 -u 0.003933179161117156 > ./result_10chains/node174_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_6_1 -p 521 -st topic174_6_0 -pt topic174_6_1 -u 0.0003961049237531933 > ./result_10chains/node174_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_7_1 -p 662 -st topic174_7_0 -pt topic174_7_1 -u 0.017939569980089734 > ./result_10chains/node174_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_8_1 -p 689 -st topic174_8_0 -pt topic174_8_1 -u 0.0026688634102555106 > ./result_10chains/node174_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node174_9_1 -p 725 -st topic174_9_0 -pt topic174_9_1 -u 0.0002775158393842035 > ./result_10chains/node174_9_1.txt &
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
    "./result_10chains/node174_0_1.txt 90"
    "./result_10chains/node174_1_1.txt 89"
    "./result_10chains/node174_2_1.txt 88"
    "./result_10chains/node174_3_1.txt 87"
    "./result_10chains/node174_4_1.txt 86"
    "./result_10chains/node174_5_1.txt 85"
    "./result_10chains/node174_6_1.txt 84"
    "./result_10chains/node174_7_1.txt 83"
    "./result_10chains/node174_8_1.txt 82"
    "./result_10chains/node174_9_1.txt 81"
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

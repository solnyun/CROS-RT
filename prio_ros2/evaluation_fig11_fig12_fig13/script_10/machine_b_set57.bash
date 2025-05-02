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
ros2 run evaluation_3_randomdag uunifast_node -n node57_0_1 -p 273 -st topic57_0_0 -pt topic57_0_1 -u 0.007385317673010039 > ./result_10chains/node57_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_1_1 -p 294 -st topic57_1_0 -pt topic57_1_1 -u 0.015795595341195234 > ./result_10chains/node57_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_2_1 -p 311 -st topic57_2_0 -pt topic57_2_1 -u 0.06187119861934859 > ./result_10chains/node57_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_3_1 -p 412 -st topic57_3_0 -pt topic57_3_1 -u 0.015493677308320186 > ./result_10chains/node57_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_4_1 -p 453 -st topic57_4_0 -pt topic57_4_1 -u 0.010759812956033787 > ./result_10chains/node57_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_5_1 -p 580 -st topic57_5_0 -pt topic57_5_1 -u 0.004724713593543872 > ./result_10chains/node57_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_6_1 -p 581 -st topic57_6_0 -pt topic57_6_1 -u 0.03535146450716667 > ./result_10chains/node57_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_7_1 -p 639 -st topic57_7_0 -pt topic57_7_1 -u 0.0014723464571374245 > ./result_10chains/node57_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_8_1 -p 744 -st topic57_8_0 -pt topic57_8_1 -u 0.02794638984963972 > ./result_10chains/node57_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_9_1 -p 853 -st topic57_9_0 -pt topic57_9_1 -u 0.03784542257670067 > ./result_10chains/node57_9_1.txt &
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
    "./result_10chains/node57_0_1.txt 90"
    "./result_10chains/node57_1_1.txt 89"
    "./result_10chains/node57_2_1.txt 88"
    "./result_10chains/node57_3_1.txt 87"
    "./result_10chains/node57_4_1.txt 86"
    "./result_10chains/node57_5_1.txt 85"
    "./result_10chains/node57_6_1.txt 84"
    "./result_10chains/node57_7_1.txt 83"
    "./result_10chains/node57_8_1.txt 82"
    "./result_10chains/node57_9_1.txt 81"
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

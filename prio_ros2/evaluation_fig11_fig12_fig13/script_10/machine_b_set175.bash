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
ros2 run evaluation_3_randomdag uunifast_node -n node175_0_1 -p 222 -st topic175_0_0 -pt topic175_0_1 -u 0.003713449524620105 > ./result_10chains/node175_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_1_1 -p 249 -st topic175_1_0 -pt topic175_1_1 -u 0.0012817214501959495 > ./result_10chains/node175_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_2_1 -p 264 -st topic175_2_0 -pt topic175_2_1 -u 0.028957275585591857 > ./result_10chains/node175_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_3_1 -p 270 -st topic175_3_0 -pt topic175_3_1 -u 0.002821871108764029 > ./result_10chains/node175_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_4_1 -p 278 -st topic175_4_0 -pt topic175_4_1 -u 0.029431859273990835 > ./result_10chains/node175_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_5_1 -p 372 -st topic175_5_0 -pt topic175_5_1 -u 0.009919146698459363 > ./result_10chains/node175_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_6_1 -p 633 -st topic175_6_0 -pt topic175_6_1 -u 0.0015011206476972794 > ./result_10chains/node175_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_7_1 -p 840 -st topic175_7_0 -pt topic175_7_1 -u 0.00208966366029166 > ./result_10chains/node175_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_8_1 -p 977 -st topic175_8_0 -pt topic175_8_1 -u 0.0002814650572198485 > ./result_10chains/node175_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node175_9_1 -p 981 -st topic175_9_0 -pt topic175_9_1 -u 0.03238387627134025 > ./result_10chains/node175_9_1.txt &
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
    "./result_10chains/node175_0_1.txt 90"
    "./result_10chains/node175_1_1.txt 89"
    "./result_10chains/node175_2_1.txt 88"
    "./result_10chains/node175_3_1.txt 87"
    "./result_10chains/node175_4_1.txt 86"
    "./result_10chains/node175_5_1.txt 85"
    "./result_10chains/node175_6_1.txt 84"
    "./result_10chains/node175_7_1.txt 83"
    "./result_10chains/node175_8_1.txt 82"
    "./result_10chains/node175_9_1.txt 81"
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

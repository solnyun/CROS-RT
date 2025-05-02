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
ros2 run evaluation_3_randomdag uunifast_node -n node104_0_1 -p 81 -st topic104_0_0 -pt topic104_0_1 -u 0.03736728215462132 > ./result_10chains/node104_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_1_1 -p 82 -st topic104_1_0 -pt topic104_1_1 -u 0.00037465343132814244 > ./result_10chains/node104_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_2_1 -p 109 -st topic104_2_0 -pt topic104_2_1 -u 0.0032876865108581454 > ./result_10chains/node104_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_3_1 -p 279 -st topic104_3_0 -pt topic104_3_1 -u 0.043154288612826996 > ./result_10chains/node104_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_4_1 -p 303 -st topic104_4_0 -pt topic104_4_1 -u 0.0009599104321892371 > ./result_10chains/node104_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_5_1 -p 314 -st topic104_5_0 -pt topic104_5_1 -u 0.003635548027669633 > ./result_10chains/node104_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_6_1 -p 380 -st topic104_6_0 -pt topic104_6_1 -u 0.039572931438024234 > ./result_10chains/node104_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_7_1 -p 669 -st topic104_7_0 -pt topic104_7_1 -u 0.049511139760920905 > ./result_10chains/node104_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_8_1 -p 707 -st topic104_8_0 -pt topic104_8_1 -u 0.009274930280715334 > ./result_10chains/node104_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node104_9_1 -p 922 -st topic104_9_0 -pt topic104_9_1 -u 0.015611798347703827 > ./result_10chains/node104_9_1.txt &
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
    "./result_10chains/node104_0_1.txt 90"
    "./result_10chains/node104_1_1.txt 89"
    "./result_10chains/node104_2_1.txt 88"
    "./result_10chains/node104_3_1.txt 87"
    "./result_10chains/node104_4_1.txt 86"
    "./result_10chains/node104_5_1.txt 85"
    "./result_10chains/node104_6_1.txt 84"
    "./result_10chains/node104_7_1.txt 83"
    "./result_10chains/node104_8_1.txt 82"
    "./result_10chains/node104_9_1.txt 81"
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

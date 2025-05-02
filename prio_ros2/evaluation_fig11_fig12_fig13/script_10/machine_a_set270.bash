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
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_2 -p 55 -st topic270_0_1 -pt None -u 0.015962099263098384 > ./result_10chains/node270_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_2 -p 108 -st topic270_1_1 -pt None -u 0.016746196183544226 > ./result_10chains/node270_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_2 -p 111 -st topic270_2_1 -pt None -u 0.024411107529322407 > ./result_10chains/node270_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_2 -p 201 -st topic270_3_1 -pt None -u 0.032127421313427496 > ./result_10chains/node270_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_2 -p 258 -st topic270_4_1 -pt None -u 0.01886831561333946 > ./result_10chains/node270_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_2 -p 524 -st topic270_5_1 -pt None -u 0.008232558330992512 > ./result_10chains/node270_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_6_2 -p 796 -st topic270_6_1 -pt None -u 0.007189829665134401 > ./result_10chains/node270_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_7_2 -p 936 -st topic270_7_1 -pt None -u 0.008354081772251734 > ./result_10chains/node270_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_8_2 -p 956 -st topic270_8_1 -pt None -u 0.01907631078503664 > ./result_10chains/node270_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_9_2 -p 963 -st topic270_9_1 -pt None -u 0.0022843353899693686 > ./result_10chains/node270_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_0 -p 55 -st none -pt topic270_0_0 -u 0.0006354121144470093 > ./result_10chains/node270_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_0 -p 108 -st none -pt topic270_1_0 -u 0.012661952528085219 > ./result_10chains/node270_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_0 -p 111 -st none -pt topic270_2_0 -u 0.013582539326981502 > ./result_10chains/node270_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_0 -p 201 -st none -pt topic270_3_0 -u 0.015291099060581792 > ./result_10chains/node270_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_0 -p 258 -st none -pt topic270_4_0 -u 0.012414483294789447 > ./result_10chains/node270_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_0 -p 524 -st none -pt topic270_5_0 -u 0.05092702995832554 > ./result_10chains/node270_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_6_0 -p 796 -st none -pt topic270_6_0 -u 0.027144169246792443 > ./result_10chains/node270_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_7_0 -p 936 -st none -pt topic270_7_0 -u 0.03618839964708251 > ./result_10chains/node270_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_8_0 -p 956 -st none -pt topic270_8_0 -u 0.007588042047793217 > ./result_10chains/node270_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_9_0 -p 963 -st none -pt topic270_9_0 -u 0.01449365065782042 > ./result_10chains/node270_9_0.txt &
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
    "./result_10chains/node270_0_0.txt 90"
    "./result_10chains/node270_0_2.txt 90"
    "./result_10chains/node270_1_0.txt 89"
    "./result_10chains/node270_1_2.txt 89"
    "./result_10chains/node270_2_0.txt 88"
    "./result_10chains/node270_2_2.txt 88"
    "./result_10chains/node270_3_0.txt 87"
    "./result_10chains/node270_3_2.txt 87"
    "./result_10chains/node270_4_0.txt 86"
    "./result_10chains/node270_4_2.txt 86"
    "./result_10chains/node270_5_0.txt 85"
    "./result_10chains/node270_5_2.txt 85"
    "./result_10chains/node270_6_0.txt 84"
    "./result_10chains/node270_6_2.txt 84"
    "./result_10chains/node270_7_0.txt 83"
    "./result_10chains/node270_7_2.txt 83"
    "./result_10chains/node270_8_0.txt 82"
    "./result_10chains/node270_8_2.txt 82"
    "./result_10chains/node270_9_0.txt 81"
    "./result_10chains/node270_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

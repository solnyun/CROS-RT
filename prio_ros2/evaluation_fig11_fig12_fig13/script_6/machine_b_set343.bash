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
ros2 run evaluation_3_randomdag uunifast_node -n node343_0_1 -p 301 -st topic343_0_0 -pt topic343_0_1 -u 0.02493197505793504 > ./result_6chains/node343_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_1_1 -p 375 -st topic343_1_0 -pt topic343_1_1 -u 0.0016813911744523735 > ./result_6chains/node343_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_2_1 -p 426 -st topic343_2_0 -pt topic343_2_1 -u 0.011634948571488446 > ./result_6chains/node343_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_3_1 -p 434 -st topic343_3_0 -pt topic343_3_1 -u 0.06812889321050256 > ./result_6chains/node343_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_4_1 -p 641 -st topic343_4_0 -pt topic343_4_1 -u 0.01678658035150979 > ./result_6chains/node343_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node343_5_1 -p 665 -st topic343_5_0 -pt topic343_5_1 -u 0.01685596472622258 > ./result_6chains/node343_5_1.txt &
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
    "./result_6chains/node343_0_1.txt 90"
    "./result_6chains/node343_1_1.txt 89"
    "./result_6chains/node343_2_1.txt 88"
    "./result_6chains/node343_3_1.txt 87"
    "./result_6chains/node343_4_1.txt 86"
    "./result_6chains/node343_5_1.txt 85"
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

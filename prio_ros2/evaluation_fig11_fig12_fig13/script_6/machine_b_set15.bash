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
ros2 run evaluation_3_randomdag uunifast_node -n node15_0_1 -p 81 -st topic15_0_0 -pt topic15_0_1 -u 0.006147564967298902 > ./result_6chains/node15_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_1_1 -p 194 -st topic15_1_0 -pt topic15_1_1 -u 0.006098358542489302 > ./result_6chains/node15_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_2_1 -p 245 -st topic15_2_0 -pt topic15_2_1 -u 0.0067809284389883095 > ./result_6chains/node15_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_3_1 -p 346 -st topic15_3_0 -pt topic15_3_1 -u 0.044305972203601496 > ./result_6chains/node15_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_4_1 -p 388 -st topic15_4_0 -pt topic15_4_1 -u 0.00878974053790943 > ./result_6chains/node15_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node15_5_1 -p 509 -st topic15_5_0 -pt topic15_5_1 -u 0.0017183206011500245 > ./result_6chains/node15_5_1.txt &
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
    "./result_6chains/node15_0_1.txt 90"
    "./result_6chains/node15_1_1.txt 89"
    "./result_6chains/node15_2_1.txt 88"
    "./result_6chains/node15_3_1.txt 87"
    "./result_6chains/node15_4_1.txt 86"
    "./result_6chains/node15_5_1.txt 85"
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

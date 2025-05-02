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
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_1 -p 13 -st topic245_0_0 -pt topic245_0_1 -u 0.005853535959978118 > ./result_8chains/node245_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_1 -p 88 -st topic245_1_0 -pt topic245_1_1 -u 0.049872663482911306 > ./result_8chains/node245_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_1 -p 301 -st topic245_2_0 -pt topic245_2_1 -u 0.03130638507445238 > ./result_8chains/node245_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_1 -p 360 -st topic245_3_0 -pt topic245_3_1 -u 0.004128008299541186 > ./result_8chains/node245_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_1 -p 702 -st topic245_4_0 -pt topic245_4_1 -u 0.03679141275631054 > ./result_8chains/node245_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_1 -p 848 -st topic245_5_0 -pt topic245_5_1 -u 0.040513269500223825 > ./result_8chains/node245_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_6_1 -p 871 -st topic245_6_0 -pt topic245_6_1 -u 0.0031872184418077626 > ./result_8chains/node245_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_7_1 -p 899 -st topic245_7_0 -pt topic245_7_1 -u 0.03305850564649299 > ./result_8chains/node245_7_1.txt &
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
    "./result_8chains/node245_0_1.txt 90"
    "./result_8chains/node245_1_1.txt 89"
    "./result_8chains/node245_2_1.txt 88"
    "./result_8chains/node245_3_1.txt 87"
    "./result_8chains/node245_4_1.txt 86"
    "./result_8chains/node245_5_1.txt 85"
    "./result_8chains/node245_6_1.txt 84"
    "./result_8chains/node245_7_1.txt 83"
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

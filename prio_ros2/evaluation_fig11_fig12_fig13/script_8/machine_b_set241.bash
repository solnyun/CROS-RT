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
ros2 run evaluation_3_randomdag uunifast_node -n node241_0_1 -p 41 -st topic241_0_0 -pt topic241_0_1 -u 0.0022192579481957186 > ./result_8chains/node241_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_1_1 -p 241 -st topic241_1_0 -pt topic241_1_1 -u 0.019228391586177063 > ./result_8chains/node241_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_2_1 -p 261 -st topic241_2_0 -pt topic241_2_1 -u 0.009531632782488697 > ./result_8chains/node241_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_3_1 -p 277 -st topic241_3_0 -pt topic241_3_1 -u 0.04020296017705194 > ./result_8chains/node241_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_4_1 -p 346 -st topic241_4_0 -pt topic241_4_1 -u 0.00021769895302936604 > ./result_8chains/node241_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_5_1 -p 512 -st topic241_5_0 -pt topic241_5_1 -u 0.03307634222234579 > ./result_8chains/node241_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_6_1 -p 558 -st topic241_6_0 -pt topic241_6_1 -u 0.011523954193499095 > ./result_8chains/node241_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node241_7_1 -p 998 -st topic241_7_0 -pt topic241_7_1 -u 0.012871233550611047 > ./result_8chains/node241_7_1.txt &
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
    "./result_8chains/node241_0_1.txt 90"
    "./result_8chains/node241_1_1.txt 89"
    "./result_8chains/node241_2_1.txt 88"
    "./result_8chains/node241_3_1.txt 87"
    "./result_8chains/node241_4_1.txt 86"
    "./result_8chains/node241_5_1.txt 85"
    "./result_8chains/node241_6_1.txt 84"
    "./result_8chains/node241_7_1.txt 83"
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

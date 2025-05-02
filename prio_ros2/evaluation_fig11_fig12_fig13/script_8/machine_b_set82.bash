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
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_1 -p 83 -st topic82_0_0 -pt topic82_0_1 -u 0.012998462719180592 > ./result_8chains/node82_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_1 -p 122 -st topic82_1_0 -pt topic82_1_1 -u 0.0015290598198948735 > ./result_8chains/node82_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_1 -p 239 -st topic82_2_0 -pt topic82_2_1 -u 0.011570533398286897 > ./result_8chains/node82_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_1 -p 411 -st topic82_3_0 -pt topic82_3_1 -u 0.02201427121040586 > ./result_8chains/node82_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_1 -p 682 -st topic82_4_0 -pt topic82_4_1 -u 0.03980196238268324 > ./result_8chains/node82_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_1 -p 894 -st topic82_5_0 -pt topic82_5_1 -u 0.007987561225455589 > ./result_8chains/node82_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_6_1 -p 938 -st topic82_6_0 -pt topic82_6_1 -u 0.013018196942378324 > ./result_8chains/node82_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_7_1 -p 964 -st topic82_7_0 -pt topic82_7_1 -u 0.0010755403068333676 > ./result_8chains/node82_7_1.txt &
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
    "./result_8chains/node82_0_1.txt 90"
    "./result_8chains/node82_1_1.txt 89"
    "./result_8chains/node82_2_1.txt 88"
    "./result_8chains/node82_3_1.txt 87"
    "./result_8chains/node82_4_1.txt 86"
    "./result_8chains/node82_5_1.txt 85"
    "./result_8chains/node82_6_1.txt 84"
    "./result_8chains/node82_7_1.txt 83"
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

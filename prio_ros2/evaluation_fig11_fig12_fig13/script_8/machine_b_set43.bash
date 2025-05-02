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
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_1 -p 82 -st topic43_0_0 -pt topic43_0_1 -u 0.025186642795206826 > ./result_8chains/node43_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_1 -p 119 -st topic43_1_0 -pt topic43_1_1 -u 0.008568309629597759 > ./result_8chains/node43_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_1 -p 164 -st topic43_2_0 -pt topic43_2_1 -u 0.021011444706110993 > ./result_8chains/node43_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_1 -p 247 -st topic43_3_0 -pt topic43_3_1 -u 0.03691100842799502 > ./result_8chains/node43_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_1 -p 270 -st topic43_4_0 -pt topic43_4_1 -u 0.018970111652274246 > ./result_8chains/node43_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_1 -p 529 -st topic43_5_0 -pt topic43_5_1 -u 0.003213328710336555 > ./result_8chains/node43_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_6_1 -p 852 -st topic43_6_0 -pt topic43_6_1 -u 0.04474931360609127 > ./result_8chains/node43_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node43_7_1 -p 917 -st topic43_7_0 -pt topic43_7_1 -u 0.0165647400526874 > ./result_8chains/node43_7_1.txt &
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
    "./result_8chains/node43_0_1.txt 90"
    "./result_8chains/node43_1_1.txt 89"
    "./result_8chains/node43_2_1.txt 88"
    "./result_8chains/node43_3_1.txt 87"
    "./result_8chains/node43_4_1.txt 86"
    "./result_8chains/node43_5_1.txt 85"
    "./result_8chains/node43_6_1.txt 84"
    "./result_8chains/node43_7_1.txt 83"
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

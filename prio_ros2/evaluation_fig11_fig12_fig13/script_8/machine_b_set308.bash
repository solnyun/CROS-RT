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
ros2 run evaluation_3_randomdag uunifast_node -n node308_0_1 -p 277 -st topic308_0_0 -pt topic308_0_1 -u 0.013692898853956026 > ./result_8chains/node308_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_1_1 -p 540 -st topic308_1_0 -pt topic308_1_1 -u 0.018489381237928926 > ./result_8chains/node308_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_2_1 -p 726 -st topic308_2_0 -pt topic308_2_1 -u 0.0017857422674655288 > ./result_8chains/node308_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_3_1 -p 740 -st topic308_3_0 -pt topic308_3_1 -u 0.05712718874369027 > ./result_8chains/node308_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_4_1 -p 752 -st topic308_4_0 -pt topic308_4_1 -u 0.0113021655929397 > ./result_8chains/node308_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_5_1 -p 954 -st topic308_5_0 -pt topic308_5_1 -u 0.015331301125456998 > ./result_8chains/node308_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_6_1 -p 967 -st topic308_6_0 -pt topic308_6_1 -u 0.0009065444959189435 > ./result_8chains/node308_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node308_7_1 -p 993 -st topic308_7_0 -pt topic308_7_1 -u 0.012830941782591077 > ./result_8chains/node308_7_1.txt &
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
    "./result_8chains/node308_0_1.txt 90"
    "./result_8chains/node308_1_1.txt 89"
    "./result_8chains/node308_2_1.txt 88"
    "./result_8chains/node308_3_1.txt 87"
    "./result_8chains/node308_4_1.txt 86"
    "./result_8chains/node308_5_1.txt 85"
    "./result_8chains/node308_6_1.txt 84"
    "./result_8chains/node308_7_1.txt 83"
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

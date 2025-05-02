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
ros2 run evaluation_3_randomdag uunifast_node -n node401_0_1 -p 139 -st topic401_0_0 -pt topic401_0_1 -u 0.04086170666962724 > ./result_8chains/node401_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_1_1 -p 350 -st topic401_1_0 -pt topic401_1_1 -u 0.009853611163393172 > ./result_8chains/node401_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_2_1 -p 430 -st topic401_2_0 -pt topic401_2_1 -u 0.010158676579242465 > ./result_8chains/node401_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_3_1 -p 433 -st topic401_3_0 -pt topic401_3_1 -u 0.003807089813939124 > ./result_8chains/node401_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_4_1 -p 460 -st topic401_4_0 -pt topic401_4_1 -u 0.009155991360833254 > ./result_8chains/node401_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_5_1 -p 735 -st topic401_5_0 -pt topic401_5_1 -u 0.0035131727494707443 > ./result_8chains/node401_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_6_1 -p 942 -st topic401_6_0 -pt topic401_6_1 -u 0.052172629920979215 > ./result_8chains/node401_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node401_7_1 -p 955 -st topic401_7_0 -pt topic401_7_1 -u 0.010464515952186351 > ./result_8chains/node401_7_1.txt &
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
    "./result_8chains/node401_0_1.txt 90"
    "./result_8chains/node401_1_1.txt 89"
    "./result_8chains/node401_2_1.txt 88"
    "./result_8chains/node401_3_1.txt 87"
    "./result_8chains/node401_4_1.txt 86"
    "./result_8chains/node401_5_1.txt 85"
    "./result_8chains/node401_6_1.txt 84"
    "./result_8chains/node401_7_1.txt 83"
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

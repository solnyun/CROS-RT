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
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_1 -p 50 -st topic198_0_0 -pt topic198_0_1 -u 0.018028751868383097 > ./result_8chains/node198_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_1 -p 142 -st topic198_1_0 -pt topic198_1_1 -u 0.028243749095769988 > ./result_8chains/node198_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_1 -p 170 -st topic198_2_0 -pt topic198_2_1 -u 0.009634778768539798 > ./result_8chains/node198_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_1 -p 416 -st topic198_3_0 -pt topic198_3_1 -u 0.016680543738871678 > ./result_8chains/node198_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_1 -p 609 -st topic198_4_0 -pt topic198_4_1 -u 0.00867509754179635 > ./result_8chains/node198_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_1 -p 696 -st topic198_5_0 -pt topic198_5_1 -u 0.031829775454131334 > ./result_8chains/node198_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_6_1 -p 738 -st topic198_6_0 -pt topic198_6_1 -u 0.013907494129042755 > ./result_8chains/node198_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_7_1 -p 766 -st topic198_7_0 -pt topic198_7_1 -u 0.025721061830464874 > ./result_8chains/node198_7_1.txt &
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
    "./result_8chains/node198_0_1.txt 90"
    "./result_8chains/node198_1_1.txt 89"
    "./result_8chains/node198_2_1.txt 88"
    "./result_8chains/node198_3_1.txt 87"
    "./result_8chains/node198_4_1.txt 86"
    "./result_8chains/node198_5_1.txt 85"
    "./result_8chains/node198_6_1.txt 84"
    "./result_8chains/node198_7_1.txt 83"
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

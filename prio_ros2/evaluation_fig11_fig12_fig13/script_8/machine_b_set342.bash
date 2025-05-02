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
ros2 run evaluation_3_randomdag uunifast_node -n node342_0_1 -p 28 -st topic342_0_0 -pt topic342_0_1 -u 0.02978479649111393 > ./result_8chains/node342_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_1_1 -p 79 -st topic342_1_0 -pt topic342_1_1 -u 0.015950599584289793 > ./result_8chains/node342_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_2_1 -p 167 -st topic342_2_0 -pt topic342_2_1 -u 0.011398566367383345 > ./result_8chains/node342_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_3_1 -p 218 -st topic342_3_0 -pt topic342_3_1 -u 0.00829594800905098 > ./result_8chains/node342_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_4_1 -p 615 -st topic342_4_0 -pt topic342_4_1 -u 0.004545827187137419 > ./result_8chains/node342_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_5_1 -p 637 -st topic342_5_0 -pt topic342_5_1 -u 0.0010340886295335805 > ./result_8chains/node342_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_6_1 -p 660 -st topic342_6_0 -pt topic342_6_1 -u 0.07106101212623177 > ./result_8chains/node342_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node342_7_1 -p 954 -st topic342_7_0 -pt topic342_7_1 -u 0.041322554795559824 > ./result_8chains/node342_7_1.txt &
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
    "./result_8chains/node342_0_1.txt 90"
    "./result_8chains/node342_1_1.txt 89"
    "./result_8chains/node342_2_1.txt 88"
    "./result_8chains/node342_3_1.txt 87"
    "./result_8chains/node342_4_1.txt 86"
    "./result_8chains/node342_5_1.txt 85"
    "./result_8chains/node342_6_1.txt 84"
    "./result_8chains/node342_7_1.txt 83"
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

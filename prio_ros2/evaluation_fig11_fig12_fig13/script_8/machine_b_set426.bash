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
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_1 -p 211 -st topic426_0_0 -pt topic426_0_1 -u 0.032385706569965256 > ./result_8chains/node426_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_1 -p 423 -st topic426_1_0 -pt topic426_1_1 -u 0.003648815137506145 > ./result_8chains/node426_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_1 -p 443 -st topic426_2_0 -pt topic426_2_1 -u 0.0006260247430552868 > ./result_8chains/node426_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_1 -p 512 -st topic426_3_0 -pt topic426_3_1 -u 0.024528943932896397 > ./result_8chains/node426_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_1 -p 540 -st topic426_4_0 -pt topic426_4_1 -u 0.041739890299171106 > ./result_8chains/node426_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_1 -p 630 -st topic426_5_0 -pt topic426_5_1 -u 0.017651790510550103 > ./result_8chains/node426_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_6_1 -p 865 -st topic426_6_0 -pt topic426_6_1 -u 0.003988998348847028 > ./result_8chains/node426_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_7_1 -p 885 -st topic426_7_0 -pt topic426_7_1 -u 0.033318479579204176 > ./result_8chains/node426_7_1.txt &
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
    "./result_8chains/node426_0_1.txt 90"
    "./result_8chains/node426_1_1.txt 89"
    "./result_8chains/node426_2_1.txt 88"
    "./result_8chains/node426_3_1.txt 87"
    "./result_8chains/node426_4_1.txt 86"
    "./result_8chains/node426_5_1.txt 85"
    "./result_8chains/node426_6_1.txt 84"
    "./result_8chains/node426_7_1.txt 83"
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

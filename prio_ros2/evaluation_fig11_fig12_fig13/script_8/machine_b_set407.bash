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
ros2 run evaluation_3_randomdag uunifast_node -n node407_0_1 -p 51 -st topic407_0_0 -pt topic407_0_1 -u 0.01492102291098324 > ./result_8chains/node407_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_1_1 -p 438 -st topic407_1_0 -pt topic407_1_1 -u 0.042201037614823356 > ./result_8chains/node407_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_2_1 -p 460 -st topic407_2_0 -pt topic407_2_1 -u 0.023795182042779084 > ./result_8chains/node407_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_3_1 -p 578 -st topic407_3_0 -pt topic407_3_1 -u 0.0049114726768533234 > ./result_8chains/node407_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_4_1 -p 703 -st topic407_4_0 -pt topic407_4_1 -u 0.01608919532424649 > ./result_8chains/node407_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_5_1 -p 767 -st topic407_5_0 -pt topic407_5_1 -u 0.016055549827451124 > ./result_8chains/node407_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_6_1 -p 781 -st topic407_6_0 -pt topic407_6_1 -u 0.002758201379769634 > ./result_8chains/node407_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node407_7_1 -p 974 -st topic407_7_0 -pt topic407_7_1 -u 0.02257063147239733 > ./result_8chains/node407_7_1.txt &
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
    "./result_8chains/node407_0_1.txt 90"
    "./result_8chains/node407_1_1.txt 89"
    "./result_8chains/node407_2_1.txt 88"
    "./result_8chains/node407_3_1.txt 87"
    "./result_8chains/node407_4_1.txt 86"
    "./result_8chains/node407_5_1.txt 85"
    "./result_8chains/node407_6_1.txt 84"
    "./result_8chains/node407_7_1.txt 83"
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

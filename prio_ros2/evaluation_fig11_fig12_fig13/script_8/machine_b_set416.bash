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
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_1 -p 83 -st topic416_0_0 -pt topic416_0_1 -u 0.04363376007124703 > ./result_8chains/node416_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_1 -p 120 -st topic416_1_0 -pt topic416_1_1 -u 0.06920351487647608 > ./result_8chains/node416_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_1 -p 163 -st topic416_2_0 -pt topic416_2_1 -u 0.010719577872250752 > ./result_8chains/node416_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_1 -p 388 -st topic416_3_0 -pt topic416_3_1 -u 0.006459707639640128 > ./result_8chains/node416_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_4_1 -p 450 -st topic416_4_0 -pt topic416_4_1 -u 0.007796892572897202 > ./result_8chains/node416_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_5_1 -p 538 -st topic416_5_0 -pt topic416_5_1 -u 0.0014371699441546038 > ./result_8chains/node416_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_6_1 -p 651 -st topic416_6_0 -pt topic416_6_1 -u 0.08466446883372161 > ./result_8chains/node416_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_7_1 -p 975 -st topic416_7_0 -pt topic416_7_1 -u 0.014145058407700426 > ./result_8chains/node416_7_1.txt &
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
    "./result_8chains/node416_0_1.txt 90"
    "./result_8chains/node416_1_1.txt 89"
    "./result_8chains/node416_2_1.txt 88"
    "./result_8chains/node416_3_1.txt 87"
    "./result_8chains/node416_4_1.txt 86"
    "./result_8chains/node416_5_1.txt 85"
    "./result_8chains/node416_6_1.txt 84"
    "./result_8chains/node416_7_1.txt 83"
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

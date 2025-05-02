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
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_1 -p 54 -st topic266_0_0 -pt topic266_0_1 -u 0.014969980178523468 > ./result_8chains/node266_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_1 -p 192 -st topic266_1_0 -pt topic266_1_1 -u 0.016364142086095768 > ./result_8chains/node266_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_1 -p 355 -st topic266_2_0 -pt topic266_2_1 -u 0.009936574477065752 > ./result_8chains/node266_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_1 -p 457 -st topic266_3_0 -pt topic266_3_1 -u 0.014267765272980182 > ./result_8chains/node266_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_1 -p 658 -st topic266_4_0 -pt topic266_4_1 -u 0.05026461586229877 > ./result_8chains/node266_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_1 -p 820 -st topic266_5_0 -pt topic266_5_1 -u 0.007470703617096147 > ./result_8chains/node266_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_6_1 -p 886 -st topic266_6_0 -pt topic266_6_1 -u 0.010540366546118785 > ./result_8chains/node266_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_7_1 -p 903 -st topic266_7_0 -pt topic266_7_1 -u 0.0403248283608234 > ./result_8chains/node266_7_1.txt &
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
    "./result_8chains/node266_0_1.txt 90"
    "./result_8chains/node266_1_1.txt 89"
    "./result_8chains/node266_2_1.txt 88"
    "./result_8chains/node266_3_1.txt 87"
    "./result_8chains/node266_4_1.txt 86"
    "./result_8chains/node266_5_1.txt 85"
    "./result_8chains/node266_6_1.txt 84"
    "./result_8chains/node266_7_1.txt 83"
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

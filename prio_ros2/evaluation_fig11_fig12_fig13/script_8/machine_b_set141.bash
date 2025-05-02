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
ros2 run evaluation_3_randomdag uunifast_node -n node141_0_1 -p 95 -st topic141_0_0 -pt topic141_0_1 -u 0.015538999033215428 > ./result_8chains/node141_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_1_1 -p 445 -st topic141_1_0 -pt topic141_1_1 -u 0.022750475345057086 > ./result_8chains/node141_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_2_1 -p 482 -st topic141_2_0 -pt topic141_2_1 -u 0.020500272301930467 > ./result_8chains/node141_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_3_1 -p 499 -st topic141_3_0 -pt topic141_3_1 -u 0.01757761058023133 > ./result_8chains/node141_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_4_1 -p 548 -st topic141_4_0 -pt topic141_4_1 -u 0.00521374777636277 > ./result_8chains/node141_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_5_1 -p 673 -st topic141_5_0 -pt topic141_5_1 -u 0.010800557295435498 > ./result_8chains/node141_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_6_1 -p 820 -st topic141_6_0 -pt topic141_6_1 -u 0.030629751194639218 > ./result_8chains/node141_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node141_7_1 -p 876 -st topic141_7_0 -pt topic141_7_1 -u 0.022023194075920672 > ./result_8chains/node141_7_1.txt &
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
    "./result_8chains/node141_0_1.txt 90"
    "./result_8chains/node141_1_1.txt 89"
    "./result_8chains/node141_2_1.txt 88"
    "./result_8chains/node141_3_1.txt 87"
    "./result_8chains/node141_4_1.txt 86"
    "./result_8chains/node141_5_1.txt 85"
    "./result_8chains/node141_6_1.txt 84"
    "./result_8chains/node141_7_1.txt 83"
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

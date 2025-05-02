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
ros2 run evaluation_3_randomdag uunifast_node -n node44_0_1 -p 34 -st topic44_0_0 -pt topic44_0_1 -u 0.0010850943604693297 > ./result_10chains/node44_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_1_1 -p 140 -st topic44_1_0 -pt topic44_1_1 -u 0.0895983444106277 > ./result_10chains/node44_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_2_1 -p 387 -st topic44_2_0 -pt topic44_2_1 -u 0.028015398363088084 > ./result_10chains/node44_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_3_1 -p 403 -st topic44_3_0 -pt topic44_3_1 -u 0.03278019855502548 > ./result_10chains/node44_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_4_1 -p 680 -st topic44_4_0 -pt topic44_4_1 -u 0.00024040003058195536 > ./result_10chains/node44_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_5_1 -p 743 -st topic44_5_0 -pt topic44_5_1 -u 0.010717412012285932 > ./result_10chains/node44_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_6_1 -p 795 -st topic44_6_0 -pt topic44_6_1 -u 0.002679241869709803 > ./result_10chains/node44_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_7_1 -p 845 -st topic44_7_0 -pt topic44_7_1 -u 0.013610547076382457 > ./result_10chains/node44_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_8_1 -p 939 -st topic44_8_0 -pt topic44_8_1 -u 0.0025886041677919552 > ./result_10chains/node44_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node44_9_1 -p 949 -st topic44_9_0 -pt topic44_9_1 -u 0.006768077026013362 > ./result_10chains/node44_9_1.txt &
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
    "./result_10chains/node44_0_1.txt 90"
    "./result_10chains/node44_1_1.txt 89"
    "./result_10chains/node44_2_1.txt 88"
    "./result_10chains/node44_3_1.txt 87"
    "./result_10chains/node44_4_1.txt 86"
    "./result_10chains/node44_5_1.txt 85"
    "./result_10chains/node44_6_1.txt 84"
    "./result_10chains/node44_7_1.txt 83"
    "./result_10chains/node44_8_1.txt 82"
    "./result_10chains/node44_9_1.txt 81"
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

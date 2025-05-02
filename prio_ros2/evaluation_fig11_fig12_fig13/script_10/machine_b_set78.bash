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
ros2 run evaluation_3_randomdag uunifast_node -n node78_0_1 -p 47 -st topic78_0_0 -pt topic78_0_1 -u 0.009246987395715167 > ./result_10chains/node78_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_1_1 -p 58 -st topic78_1_0 -pt topic78_1_1 -u 0.011623731215333999 > ./result_10chains/node78_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_2_1 -p 429 -st topic78_2_0 -pt topic78_2_1 -u 0.010607712006341918 > ./result_10chains/node78_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_3_1 -p 454 -st topic78_3_0 -pt topic78_3_1 -u 0.021427828158045614 > ./result_10chains/node78_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_4_1 -p 552 -st topic78_4_0 -pt topic78_4_1 -u 0.008959620678162972 > ./result_10chains/node78_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_5_1 -p 582 -st topic78_5_0 -pt topic78_5_1 -u 0.01475715709025549 > ./result_10chains/node78_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_6_1 -p 814 -st topic78_6_0 -pt topic78_6_1 -u 0.007188134018657671 > ./result_10chains/node78_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_7_1 -p 873 -st topic78_7_0 -pt topic78_7_1 -u 0.006874624019119077 > ./result_10chains/node78_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_8_1 -p 880 -st topic78_8_0 -pt topic78_8_1 -u 0.014249176261742436 > ./result_10chains/node78_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node78_9_1 -p 953 -st topic78_9_0 -pt topic78_9_1 -u 0.016583777763527506 > ./result_10chains/node78_9_1.txt &
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
    "./result_10chains/node78_0_1.txt 90"
    "./result_10chains/node78_1_1.txt 89"
    "./result_10chains/node78_2_1.txt 88"
    "./result_10chains/node78_3_1.txt 87"
    "./result_10chains/node78_4_1.txt 86"
    "./result_10chains/node78_5_1.txt 85"
    "./result_10chains/node78_6_1.txt 84"
    "./result_10chains/node78_7_1.txt 83"
    "./result_10chains/node78_8_1.txt 82"
    "./result_10chains/node78_9_1.txt 81"
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

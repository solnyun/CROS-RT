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
ros2 run evaluation_3_randomdag uunifast_node -n node333_0_1 -p 119 -st topic333_0_0 -pt topic333_0_1 -u 0.028871676850888317 > ./result_8chains/node333_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_1_1 -p 212 -st topic333_1_0 -pt topic333_1_1 -u 0.003892287377860293 > ./result_8chains/node333_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_2_1 -p 300 -st topic333_2_0 -pt topic333_2_1 -u 0.06738373740503506 > ./result_8chains/node333_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_3_1 -p 402 -st topic333_3_0 -pt topic333_3_1 -u 0.04415637402837391 > ./result_8chains/node333_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_4_1 -p 604 -st topic333_4_0 -pt topic333_4_1 -u 0.033042009617950174 > ./result_8chains/node333_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_5_1 -p 770 -st topic333_5_0 -pt topic333_5_1 -u 0.0019698439075718777 > ./result_8chains/node333_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_6_1 -p 798 -st topic333_6_0 -pt topic333_6_1 -u 0.012265013217796092 > ./result_8chains/node333_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node333_7_1 -p 938 -st topic333_7_0 -pt topic333_7_1 -u 0.028666784791505442 > ./result_8chains/node333_7_1.txt &
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
    "./result_8chains/node333_0_1.txt 90"
    "./result_8chains/node333_1_1.txt 89"
    "./result_8chains/node333_2_1.txt 88"
    "./result_8chains/node333_3_1.txt 87"
    "./result_8chains/node333_4_1.txt 86"
    "./result_8chains/node333_5_1.txt 85"
    "./result_8chains/node333_6_1.txt 84"
    "./result_8chains/node333_7_1.txt 83"
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

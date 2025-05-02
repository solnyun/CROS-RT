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
ros2 run evaluation_3_randomdag uunifast_node -n node411_0_1 -p 20 -st topic411_0_0 -pt topic411_0_1 -u 0.0026365848028832017 > ./result_10chains/node411_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_1_1 -p 81 -st topic411_1_0 -pt topic411_1_1 -u 0.0034479976356751596 > ./result_10chains/node411_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_2_1 -p 164 -st topic411_2_0 -pt topic411_2_1 -u 0.007600403103481923 > ./result_10chains/node411_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_3_1 -p 297 -st topic411_3_0 -pt topic411_3_1 -u 0.002445784890923286 > ./result_10chains/node411_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_4_1 -p 507 -st topic411_4_0 -pt topic411_4_1 -u 0.01698972031418977 > ./result_10chains/node411_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_5_1 -p 754 -st topic411_5_0 -pt topic411_5_1 -u 0.007641425597067375 > ./result_10chains/node411_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_6_1 -p 757 -st topic411_6_0 -pt topic411_6_1 -u 0.013903279832080617 > ./result_10chains/node411_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_7_1 -p 860 -st topic411_7_0 -pt topic411_7_1 -u 0.027693552582140013 > ./result_10chains/node411_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_8_1 -p 931 -st topic411_8_0 -pt topic411_8_1 -u 0.0069245241390010065 > ./result_10chains/node411_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node411_9_1 -p 985 -st topic411_9_0 -pt topic411_9_1 -u 0.013034966064612826 > ./result_10chains/node411_9_1.txt &
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
    "./result_10chains/node411_0_1.txt 90"
    "./result_10chains/node411_1_1.txt 89"
    "./result_10chains/node411_2_1.txt 88"
    "./result_10chains/node411_3_1.txt 87"
    "./result_10chains/node411_4_1.txt 86"
    "./result_10chains/node411_5_1.txt 85"
    "./result_10chains/node411_6_1.txt 84"
    "./result_10chains/node411_7_1.txt 83"
    "./result_10chains/node411_8_1.txt 82"
    "./result_10chains/node411_9_1.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node92_0_1 -p 13 -st topic92_0_0 -pt topic92_0_1 -u 0.04048528641933313 > ./result_10chains/node92_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_1_1 -p 47 -st topic92_1_0 -pt topic92_1_1 -u 0.0008809162222316314 > ./result_10chains/node92_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_2_1 -p 184 -st topic92_2_0 -pt topic92_2_1 -u 0.034789209859192205 > ./result_10chains/node92_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_3_1 -p 338 -st topic92_3_0 -pt topic92_3_1 -u 0.022037143821677707 > ./result_10chains/node92_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_4_1 -p 353 -st topic92_4_0 -pt topic92_4_1 -u 0.009875701238265117 > ./result_10chains/node92_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_5_1 -p 391 -st topic92_5_0 -pt topic92_5_1 -u 0.01220741121765434 > ./result_10chains/node92_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_6_1 -p 409 -st topic92_6_0 -pt topic92_6_1 -u 0.011299879265989687 > ./result_10chains/node92_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_7_1 -p 539 -st topic92_7_0 -pt topic92_7_1 -u 0.022197327350155338 > ./result_10chains/node92_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_8_1 -p 858 -st topic92_8_0 -pt topic92_8_1 -u 0.015233396268445831 > ./result_10chains/node92_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_9_1 -p 900 -st topic92_9_0 -pt topic92_9_1 -u 0.01717197947983628 > ./result_10chains/node92_9_1.txt &
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
    "./result_10chains/node92_0_1.txt 90"
    "./result_10chains/node92_1_1.txt 89"
    "./result_10chains/node92_2_1.txt 88"
    "./result_10chains/node92_3_1.txt 87"
    "./result_10chains/node92_4_1.txt 86"
    "./result_10chains/node92_5_1.txt 85"
    "./result_10chains/node92_6_1.txt 84"
    "./result_10chains/node92_7_1.txt 83"
    "./result_10chains/node92_8_1.txt 82"
    "./result_10chains/node92_9_1.txt 81"
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

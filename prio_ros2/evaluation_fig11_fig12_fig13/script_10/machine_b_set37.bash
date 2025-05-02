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
ros2 run evaluation_3_randomdag uunifast_node -n node37_0_1 -p 126 -st topic37_0_0 -pt topic37_0_1 -u 0.03236055237197155 > ./result_10chains/node37_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_1_1 -p 364 -st topic37_1_0 -pt topic37_1_1 -u 0.015303462316447691 > ./result_10chains/node37_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_2_1 -p 449 -st topic37_2_0 -pt topic37_2_1 -u 0.01065328298165824 > ./result_10chains/node37_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_3_1 -p 548 -st topic37_3_0 -pt topic37_3_1 -u 0.010462948723360344 > ./result_10chains/node37_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_4_1 -p 654 -st topic37_4_0 -pt topic37_4_1 -u 0.009957357703007819 > ./result_10chains/node37_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_5_1 -p 675 -st topic37_5_0 -pt topic37_5_1 -u 0.006784976541017285 > ./result_10chains/node37_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_6_1 -p 699 -st topic37_6_0 -pt topic37_6_1 -u 0.02733305098123831 > ./result_10chains/node37_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_7_1 -p 702 -st topic37_7_0 -pt topic37_7_1 -u 0.0014412637353654334 > ./result_10chains/node37_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_8_1 -p 729 -st topic37_8_0 -pt topic37_8_1 -u 0.040352005672264823 > ./result_10chains/node37_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node37_9_1 -p 731 -st topic37_9_0 -pt topic37_9_1 -u 0.006670138260506086 > ./result_10chains/node37_9_1.txt &
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
    "./result_10chains/node37_0_1.txt 90"
    "./result_10chains/node37_1_1.txt 89"
    "./result_10chains/node37_2_1.txt 88"
    "./result_10chains/node37_3_1.txt 87"
    "./result_10chains/node37_4_1.txt 86"
    "./result_10chains/node37_5_1.txt 85"
    "./result_10chains/node37_6_1.txt 84"
    "./result_10chains/node37_7_1.txt 83"
    "./result_10chains/node37_8_1.txt 82"
    "./result_10chains/node37_9_1.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node144_0_1 -p 150 -st topic144_0_0 -pt topic144_0_1 -u 0.024581928406729514 > ./result_10chains/node144_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_1_1 -p 156 -st topic144_1_0 -pt topic144_1_1 -u 0.07218793243332577 > ./result_10chains/node144_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_2_1 -p 351 -st topic144_2_0 -pt topic144_2_1 -u 0.02263060169714387 > ./result_10chains/node144_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_3_1 -p 387 -st topic144_3_0 -pt topic144_3_1 -u 0.0010196111567803978 > ./result_10chains/node144_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_4_1 -p 428 -st topic144_4_0 -pt topic144_4_1 -u 0.029680400743621133 > ./result_10chains/node144_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_5_1 -p 549 -st topic144_5_0 -pt topic144_5_1 -u 0.007842824196374554 > ./result_10chains/node144_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_6_1 -p 562 -st topic144_6_0 -pt topic144_6_1 -u 0.017147229901399108 > ./result_10chains/node144_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_7_1 -p 649 -st topic144_7_0 -pt topic144_7_1 -u 0.03319976016609692 > ./result_10chains/node144_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_8_1 -p 906 -st topic144_8_0 -pt topic144_8_1 -u 0.029524334602183136 > ./result_10chains/node144_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node144_9_1 -p 939 -st topic144_9_0 -pt topic144_9_1 -u 0.023195740350656035 > ./result_10chains/node144_9_1.txt &
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
    "./result_10chains/node144_0_1.txt 90"
    "./result_10chains/node144_1_1.txt 89"
    "./result_10chains/node144_2_1.txt 88"
    "./result_10chains/node144_3_1.txt 87"
    "./result_10chains/node144_4_1.txt 86"
    "./result_10chains/node144_5_1.txt 85"
    "./result_10chains/node144_6_1.txt 84"
    "./result_10chains/node144_7_1.txt 83"
    "./result_10chains/node144_8_1.txt 82"
    "./result_10chains/node144_9_1.txt 81"
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

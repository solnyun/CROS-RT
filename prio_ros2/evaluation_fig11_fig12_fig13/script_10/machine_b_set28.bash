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
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_1 -p 32 -st topic28_0_0 -pt topic28_0_1 -u 0.000881547008604433 > ./result_10chains/node28_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_1 -p 406 -st topic28_1_0 -pt topic28_1_1 -u 0.00848908383749608 > ./result_10chains/node28_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_1 -p 460 -st topic28_2_0 -pt topic28_2_1 -u 0.052711300258744376 > ./result_10chains/node28_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_1 -p 502 -st topic28_3_0 -pt topic28_3_1 -u 0.026387695728919747 > ./result_10chains/node28_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_1 -p 514 -st topic28_4_0 -pt topic28_4_1 -u 0.029492798190510927 > ./result_10chains/node28_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_1 -p 518 -st topic28_5_0 -pt topic28_5_1 -u 0.003735837536330361 > ./result_10chains/node28_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_6_1 -p 646 -st topic28_6_0 -pt topic28_6_1 -u 0.0093667696855127 > ./result_10chains/node28_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_7_1 -p 813 -st topic28_7_0 -pt topic28_7_1 -u 0.00943712266908403 > ./result_10chains/node28_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_8_1 -p 826 -st topic28_8_0 -pt topic28_8_1 -u 0.07341185587730462 > ./result_10chains/node28_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node28_9_1 -p 926 -st topic28_9_0 -pt topic28_9_1 -u 0.0015101199932285592 > ./result_10chains/node28_9_1.txt &
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
    "./result_10chains/node28_0_1.txt 90"
    "./result_10chains/node28_1_1.txt 89"
    "./result_10chains/node28_2_1.txt 88"
    "./result_10chains/node28_3_1.txt 87"
    "./result_10chains/node28_4_1.txt 86"
    "./result_10chains/node28_5_1.txt 85"
    "./result_10chains/node28_6_1.txt 84"
    "./result_10chains/node28_7_1.txt 83"
    "./result_10chains/node28_8_1.txt 82"
    "./result_10chains/node28_9_1.txt 81"
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

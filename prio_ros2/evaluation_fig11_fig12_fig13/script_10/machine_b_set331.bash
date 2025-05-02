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
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_1 -p 208 -st topic331_0_0 -pt topic331_0_1 -u 0.017316720258393425 > ./result_10chains/node331_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_1 -p 252 -st topic331_1_0 -pt topic331_1_1 -u 0.005568319336099081 > ./result_10chains/node331_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_1 -p 399 -st topic331_2_0 -pt topic331_2_1 -u 0.003944510337634377 > ./result_10chains/node331_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_1 -p 494 -st topic331_3_0 -pt topic331_3_1 -u 0.006771312017007813 > ./result_10chains/node331_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_1 -p 528 -st topic331_4_0 -pt topic331_4_1 -u 0.032400566594873115 > ./result_10chains/node331_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_1 -p 682 -st topic331_5_0 -pt topic331_5_1 -u 0.015862082320150017 > ./result_10chains/node331_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_6_1 -p 866 -st topic331_6_0 -pt topic331_6_1 -u 0.007707465012260328 > ./result_10chains/node331_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_7_1 -p 902 -st topic331_7_0 -pt topic331_7_1 -u 0.044543355730534445 > ./result_10chains/node331_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_8_1 -p 938 -st topic331_8_0 -pt topic331_8_1 -u 0.031141455289482006 > ./result_10chains/node331_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_9_1 -p 948 -st topic331_9_0 -pt topic331_9_1 -u 0.030503360004204384 > ./result_10chains/node331_9_1.txt &
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
    "./result_10chains/node331_0_1.txt 90"
    "./result_10chains/node331_1_1.txt 89"
    "./result_10chains/node331_2_1.txt 88"
    "./result_10chains/node331_3_1.txt 87"
    "./result_10chains/node331_4_1.txt 86"
    "./result_10chains/node331_5_1.txt 85"
    "./result_10chains/node331_6_1.txt 84"
    "./result_10chains/node331_7_1.txt 83"
    "./result_10chains/node331_8_1.txt 82"
    "./result_10chains/node331_9_1.txt 81"
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

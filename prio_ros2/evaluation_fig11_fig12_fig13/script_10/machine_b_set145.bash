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
ros2 run evaluation_3_randomdag uunifast_node -n node145_0_1 -p 15 -st topic145_0_0 -pt topic145_0_1 -u 0.021335178658883958 > ./result_10chains/node145_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_1_1 -p 88 -st topic145_1_0 -pt topic145_1_1 -u 0.004235543758435212 > ./result_10chains/node145_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_2_1 -p 194 -st topic145_2_0 -pt topic145_2_1 -u 0.04968757513467098 > ./result_10chains/node145_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_3_1 -p 484 -st topic145_3_0 -pt topic145_3_1 -u 0.016994873128829302 > ./result_10chains/node145_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_4_1 -p 527 -st topic145_4_0 -pt topic145_4_1 -u 0.011918644246531274 > ./result_10chains/node145_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_5_1 -p 773 -st topic145_5_0 -pt topic145_5_1 -u 0.008351894246931751 > ./result_10chains/node145_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_6_1 -p 789 -st topic145_6_0 -pt topic145_6_1 -u 0.009294030521790009 > ./result_10chains/node145_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_7_1 -p 799 -st topic145_7_0 -pt topic145_7_1 -u 0.0027041763949983977 > ./result_10chains/node145_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_8_1 -p 813 -st topic145_8_0 -pt topic145_8_1 -u 0.005328703441672175 > ./result_10chains/node145_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node145_9_1 -p 930 -st topic145_9_0 -pt topic145_9_1 -u 0.01923697709454881 > ./result_10chains/node145_9_1.txt &
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
    "./result_10chains/node145_0_1.txt 90"
    "./result_10chains/node145_1_1.txt 89"
    "./result_10chains/node145_2_1.txt 88"
    "./result_10chains/node145_3_1.txt 87"
    "./result_10chains/node145_4_1.txt 86"
    "./result_10chains/node145_5_1.txt 85"
    "./result_10chains/node145_6_1.txt 84"
    "./result_10chains/node145_7_1.txt 83"
    "./result_10chains/node145_8_1.txt 82"
    "./result_10chains/node145_9_1.txt 81"
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

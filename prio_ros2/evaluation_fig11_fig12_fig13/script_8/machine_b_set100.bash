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
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_1 -p 62 -st topic100_0_0 -pt topic100_0_1 -u 0.001562160093230791 > ./result_8chains/node100_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_1 -p 209 -st topic100_1_0 -pt topic100_1_1 -u 0.002710032062268164 > ./result_8chains/node100_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_1 -p 210 -st topic100_2_0 -pt topic100_2_1 -u 0.023621336353824463 > ./result_8chains/node100_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_1 -p 325 -st topic100_3_0 -pt topic100_3_1 -u 0.0011381466491143244 > ./result_8chains/node100_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_1 -p 484 -st topic100_4_0 -pt topic100_4_1 -u 0.028383829040238617 > ./result_8chains/node100_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_1 -p 555 -st topic100_5_0 -pt topic100_5_1 -u 0.024647200654015794 > ./result_8chains/node100_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_6_1 -p 935 -st topic100_6_0 -pt topic100_6_1 -u 0.026003837773221544 > ./result_8chains/node100_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_7_1 -p 949 -st topic100_7_0 -pt topic100_7_1 -u 0.009019370952907842 > ./result_8chains/node100_7_1.txt &
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
    "./result_8chains/node100_0_1.txt 90"
    "./result_8chains/node100_1_1.txt 89"
    "./result_8chains/node100_2_1.txt 88"
    "./result_8chains/node100_3_1.txt 87"
    "./result_8chains/node100_4_1.txt 86"
    "./result_8chains/node100_5_1.txt 85"
    "./result_8chains/node100_6_1.txt 84"
    "./result_8chains/node100_7_1.txt 83"
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

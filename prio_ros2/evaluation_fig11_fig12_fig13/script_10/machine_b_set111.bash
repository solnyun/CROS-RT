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
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_1 -p 47 -st topic111_0_0 -pt topic111_0_1 -u 0.0011166106063668635 > ./result_10chains/node111_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_1 -p 83 -st topic111_1_0 -pt topic111_1_1 -u 0.004508307182718885 > ./result_10chains/node111_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_1 -p 103 -st topic111_2_0 -pt topic111_2_1 -u 0.02197229737846329 > ./result_10chains/node111_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_1 -p 108 -st topic111_3_0 -pt topic111_3_1 -u 0.0038290513048024333 > ./result_10chains/node111_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_1 -p 181 -st topic111_4_0 -pt topic111_4_1 -u 0.015518779215989598 > ./result_10chains/node111_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_1 -p 214 -st topic111_5_0 -pt topic111_5_1 -u 0.00014522290259466608 > ./result_10chains/node111_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_6_1 -p 231 -st topic111_6_0 -pt topic111_6_1 -u 0.048620842238306816 > ./result_10chains/node111_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_7_1 -p 456 -st topic111_7_0 -pt topic111_7_1 -u 0.0305223973752152 > ./result_10chains/node111_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_8_1 -p 528 -st topic111_8_0 -pt topic111_8_1 -u 0.02033531594124506 > ./result_10chains/node111_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_9_1 -p 721 -st topic111_9_0 -pt topic111_9_1 -u 0.02586277019257566 > ./result_10chains/node111_9_1.txt &
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
    "./result_10chains/node111_0_1.txt 90"
    "./result_10chains/node111_1_1.txt 89"
    "./result_10chains/node111_2_1.txt 88"
    "./result_10chains/node111_3_1.txt 87"
    "./result_10chains/node111_4_1.txt 86"
    "./result_10chains/node111_5_1.txt 85"
    "./result_10chains/node111_6_1.txt 84"
    "./result_10chains/node111_7_1.txt 83"
    "./result_10chains/node111_8_1.txt 82"
    "./result_10chains/node111_9_1.txt 81"
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

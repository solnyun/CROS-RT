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
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_1 -p 46 -st topic30_0_0 -pt topic30_0_1 -u 0.024724860345993527 > ./result_8chains/node30_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_1 -p 87 -st topic30_1_0 -pt topic30_1_1 -u 0.006918529327832823 > ./result_8chains/node30_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_1 -p 486 -st topic30_2_0 -pt topic30_2_1 -u 0.008397530209493131 > ./result_8chains/node30_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_1 -p 519 -st topic30_3_0 -pt topic30_3_1 -u 0.0032365863392226912 > ./result_8chains/node30_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_1 -p 539 -st topic30_4_0 -pt topic30_4_1 -u 0.028777500489049868 > ./result_8chains/node30_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_1 -p 656 -st topic30_5_0 -pt topic30_5_1 -u 0.005506987689074178 > ./result_8chains/node30_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_6_1 -p 694 -st topic30_6_0 -pt topic30_6_1 -u 0.0026700542719941267 > ./result_8chains/node30_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node30_7_1 -p 922 -st topic30_7_0 -pt topic30_7_1 -u 0.010901646579770066 > ./result_8chains/node30_7_1.txt &
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
    "./result_8chains/node30_0_1.txt 90"
    "./result_8chains/node30_1_1.txt 89"
    "./result_8chains/node30_2_1.txt 88"
    "./result_8chains/node30_3_1.txt 87"
    "./result_8chains/node30_4_1.txt 86"
    "./result_8chains/node30_5_1.txt 85"
    "./result_8chains/node30_6_1.txt 84"
    "./result_8chains/node30_7_1.txt 83"
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

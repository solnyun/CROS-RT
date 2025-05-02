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
ros2 run evaluation_3_randomdag uunifast_node -n node397_0_1 -p 82 -st topic397_0_0 -pt topic397_0_1 -u 0.0013085685799527624 > ./result_8chains/node397_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_1_1 -p 215 -st topic397_1_0 -pt topic397_1_1 -u 0.018640174949977995 > ./result_8chains/node397_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_2_1 -p 378 -st topic397_2_0 -pt topic397_2_1 -u 0.030782616754246428 > ./result_8chains/node397_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_3_1 -p 571 -st topic397_3_0 -pt topic397_3_1 -u 0.012152368678420067 > ./result_8chains/node397_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_4_1 -p 689 -st topic397_4_0 -pt topic397_4_1 -u 0.0034322982321952356 > ./result_8chains/node397_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_5_1 -p 840 -st topic397_5_0 -pt topic397_5_1 -u 0.032306075436983966 > ./result_8chains/node397_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_6_1 -p 895 -st topic397_6_0 -pt topic397_6_1 -u 0.020021468780809945 > ./result_8chains/node397_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node397_7_1 -p 923 -st topic397_7_0 -pt topic397_7_1 -u 0.01615282389619209 > ./result_8chains/node397_7_1.txt &
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
    "./result_8chains/node397_0_1.txt 90"
    "./result_8chains/node397_1_1.txt 89"
    "./result_8chains/node397_2_1.txt 88"
    "./result_8chains/node397_3_1.txt 87"
    "./result_8chains/node397_4_1.txt 86"
    "./result_8chains/node397_5_1.txt 85"
    "./result_8chains/node397_6_1.txt 84"
    "./result_8chains/node397_7_1.txt 83"
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

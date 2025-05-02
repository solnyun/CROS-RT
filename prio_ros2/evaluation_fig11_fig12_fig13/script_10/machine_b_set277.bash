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
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_1 -p 303 -st topic277_0_0 -pt topic277_0_1 -u 0.009361806183464993 > ./result_10chains/node277_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_1 -p 357 -st topic277_1_0 -pt topic277_1_1 -u 0.002624020481831857 > ./result_10chains/node277_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_1 -p 425 -st topic277_2_0 -pt topic277_2_1 -u 0.012332065245264978 > ./result_10chains/node277_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_1 -p 458 -st topic277_3_0 -pt topic277_3_1 -u 0.009821745803741067 > ./result_10chains/node277_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_1 -p 542 -st topic277_4_0 -pt topic277_4_1 -u 0.06491120101904002 > ./result_10chains/node277_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_1 -p 625 -st topic277_5_0 -pt topic277_5_1 -u 0.0041564599867275065 > ./result_10chains/node277_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_6_1 -p 800 -st topic277_6_0 -pt topic277_6_1 -u 0.0423627357282379 > ./result_10chains/node277_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_7_1 -p 854 -st topic277_7_0 -pt topic277_7_1 -u 0.00493515412141618 > ./result_10chains/node277_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_8_1 -p 895 -st topic277_8_0 -pt topic277_8_1 -u 0.014921850699340627 > ./result_10chains/node277_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_9_1 -p 978 -st topic277_9_0 -pt topic277_9_1 -u 0.016659013626848653 > ./result_10chains/node277_9_1.txt &
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
    "./result_10chains/node277_0_1.txt 90"
    "./result_10chains/node277_1_1.txt 89"
    "./result_10chains/node277_2_1.txt 88"
    "./result_10chains/node277_3_1.txt 87"
    "./result_10chains/node277_4_1.txt 86"
    "./result_10chains/node277_5_1.txt 85"
    "./result_10chains/node277_6_1.txt 84"
    "./result_10chains/node277_7_1.txt 83"
    "./result_10chains/node277_8_1.txt 82"
    "./result_10chains/node277_9_1.txt 81"
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

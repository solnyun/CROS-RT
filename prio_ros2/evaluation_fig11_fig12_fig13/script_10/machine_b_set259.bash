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
ros2 run evaluation_3_randomdag uunifast_node -n node259_0_1 -p 139 -st topic259_0_0 -pt topic259_0_1 -u 0.017021969055738162 > ./result_10chains/node259_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_1_1 -p 193 -st topic259_1_0 -pt topic259_1_1 -u 0.0154753367229164 > ./result_10chains/node259_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_2_1 -p 226 -st topic259_2_0 -pt topic259_2_1 -u 0.044774058393026894 > ./result_10chains/node259_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_3_1 -p 352 -st topic259_3_0 -pt topic259_3_1 -u 0.008335903104527365 > ./result_10chains/node259_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_4_1 -p 375 -st topic259_4_0 -pt topic259_4_1 -u 0.00021190294824960376 > ./result_10chains/node259_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_5_1 -p 443 -st topic259_5_0 -pt topic259_5_1 -u 0.004064947039917416 > ./result_10chains/node259_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_6_1 -p 559 -st topic259_6_0 -pt topic259_6_1 -u 0.0017939649798653645 > ./result_10chains/node259_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_7_1 -p 575 -st topic259_7_0 -pt topic259_7_1 -u 0.06482910673426387 > ./result_10chains/node259_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_8_1 -p 620 -st topic259_8_0 -pt topic259_8_1 -u 0.01744662158658951 > ./result_10chains/node259_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node259_9_1 -p 654 -st topic259_9_0 -pt topic259_9_1 -u 0.010990473599127486 > ./result_10chains/node259_9_1.txt &
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
    "./result_10chains/node259_0_1.txt 90"
    "./result_10chains/node259_1_1.txt 89"
    "./result_10chains/node259_2_1.txt 88"
    "./result_10chains/node259_3_1.txt 87"
    "./result_10chains/node259_4_1.txt 86"
    "./result_10chains/node259_5_1.txt 85"
    "./result_10chains/node259_6_1.txt 84"
    "./result_10chains/node259_7_1.txt 83"
    "./result_10chains/node259_8_1.txt 82"
    "./result_10chains/node259_9_1.txt 81"
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

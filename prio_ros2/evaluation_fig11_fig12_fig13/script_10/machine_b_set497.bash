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
ros2 run evaluation_3_randomdag uunifast_node -n node497_0_1 -p 54 -st topic497_0_0 -pt topic497_0_1 -u 0.035339254406111575 > ./result_10chains/node497_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_1_1 -p 70 -st topic497_1_0 -pt topic497_1_1 -u 0.00016181507831419806 > ./result_10chains/node497_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_2_1 -p 173 -st topic497_2_0 -pt topic497_2_1 -u 0.013726222972409607 > ./result_10chains/node497_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_3_1 -p 225 -st topic497_3_0 -pt topic497_3_1 -u 0.015800480847556253 > ./result_10chains/node497_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_4_1 -p 240 -st topic497_4_0 -pt topic497_4_1 -u 0.02503577413864455 > ./result_10chains/node497_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_5_1 -p 332 -st topic497_5_0 -pt topic497_5_1 -u 0.005058827977835245 > ./result_10chains/node497_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_6_1 -p 360 -st topic497_6_0 -pt topic497_6_1 -u 0.003048357236227095 > ./result_10chains/node497_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_7_1 -p 478 -st topic497_7_0 -pt topic497_7_1 -u 0.006175088607171059 > ./result_10chains/node497_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_8_1 -p 699 -st topic497_8_0 -pt topic497_8_1 -u 0.012700485084391241 > ./result_10chains/node497_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node497_9_1 -p 797 -st topic497_9_0 -pt topic497_9_1 -u 0.013365465707801364 > ./result_10chains/node497_9_1.txt &
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
    "./result_10chains/node497_0_1.txt 90"
    "./result_10chains/node497_1_1.txt 89"
    "./result_10chains/node497_2_1.txt 88"
    "./result_10chains/node497_3_1.txt 87"
    "./result_10chains/node497_4_1.txt 86"
    "./result_10chains/node497_5_1.txt 85"
    "./result_10chains/node497_6_1.txt 84"
    "./result_10chains/node497_7_1.txt 83"
    "./result_10chains/node497_8_1.txt 82"
    "./result_10chains/node497_9_1.txt 81"
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

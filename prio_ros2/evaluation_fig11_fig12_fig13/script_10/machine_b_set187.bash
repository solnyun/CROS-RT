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
ros2 run evaluation_3_randomdag uunifast_node -n node187_0_1 -p 68 -st topic187_0_0 -pt topic187_0_1 -u 0.008425363237052563 > ./result_10chains/node187_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_1_1 -p 95 -st topic187_1_0 -pt topic187_1_1 -u 0.014548777842624427 > ./result_10chains/node187_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_2_1 -p 112 -st topic187_2_0 -pt topic187_2_1 -u 0.0063861798277770054 > ./result_10chains/node187_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_3_1 -p 155 -st topic187_3_0 -pt topic187_3_1 -u 0.05674584032281965 > ./result_10chains/node187_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_4_1 -p 349 -st topic187_4_0 -pt topic187_4_1 -u 0.009607608759366226 > ./result_10chains/node187_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_5_1 -p 509 -st topic187_5_0 -pt topic187_5_1 -u 0.010695552241598905 > ./result_10chains/node187_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_6_1 -p 551 -st topic187_6_0 -pt topic187_6_1 -u 0.013796030340356175 > ./result_10chains/node187_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_7_1 -p 703 -st topic187_7_0 -pt topic187_7_1 -u 0.0029099098771020043 > ./result_10chains/node187_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_8_1 -p 711 -st topic187_8_0 -pt topic187_8_1 -u 0.006841719372631859 > ./result_10chains/node187_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node187_9_1 -p 777 -st topic187_9_0 -pt topic187_9_1 -u 0.00550652974465261 > ./result_10chains/node187_9_1.txt &
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
    "./result_10chains/node187_0_1.txt 90"
    "./result_10chains/node187_1_1.txt 89"
    "./result_10chains/node187_2_1.txt 88"
    "./result_10chains/node187_3_1.txt 87"
    "./result_10chains/node187_4_1.txt 86"
    "./result_10chains/node187_5_1.txt 85"
    "./result_10chains/node187_6_1.txt 84"
    "./result_10chains/node187_7_1.txt 83"
    "./result_10chains/node187_8_1.txt 82"
    "./result_10chains/node187_9_1.txt 81"
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

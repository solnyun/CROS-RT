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
ros2 run evaluation_3_randomdag uunifast_node -n node90_0_1 -p 45 -st topic90_0_0 -pt topic90_0_1 -u 0.012062384696191586 > ./result_8chains/node90_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_1_1 -p 198 -st topic90_1_0 -pt topic90_1_1 -u 0.009066064358248638 > ./result_8chains/node90_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_2_1 -p 284 -st topic90_2_0 -pt topic90_2_1 -u 0.013025106081940407 > ./result_8chains/node90_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_3_1 -p 414 -st topic90_3_0 -pt topic90_3_1 -u 0.05526293300965146 > ./result_8chains/node90_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_4_1 -p 513 -st topic90_4_0 -pt topic90_4_1 -u 0.041950366677612205 > ./result_8chains/node90_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_5_1 -p 538 -st topic90_5_0 -pt topic90_5_1 -u 0.01798467199450511 > ./result_8chains/node90_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_6_1 -p 756 -st topic90_6_0 -pt topic90_6_1 -u 0.015827415572782916 > ./result_8chains/node90_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node90_7_1 -p 835 -st topic90_7_0 -pt topic90_7_1 -u 0.0008893339918793139 > ./result_8chains/node90_7_1.txt &
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
    "./result_8chains/node90_0_1.txt 90"
    "./result_8chains/node90_1_1.txt 89"
    "./result_8chains/node90_2_1.txt 88"
    "./result_8chains/node90_3_1.txt 87"
    "./result_8chains/node90_4_1.txt 86"
    "./result_8chains/node90_5_1.txt 85"
    "./result_8chains/node90_6_1.txt 84"
    "./result_8chains/node90_7_1.txt 83"
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

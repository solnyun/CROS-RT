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
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_1 -p 37 -st topic118_0_0 -pt topic118_0_1 -u 0.008716695565247845 > ./result_8chains/node118_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_1 -p 198 -st topic118_1_0 -pt topic118_1_1 -u 0.031092607799335314 > ./result_8chains/node118_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_1 -p 298 -st topic118_2_0 -pt topic118_2_1 -u 0.025500556976612854 > ./result_8chains/node118_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_1 -p 441 -st topic118_3_0 -pt topic118_3_1 -u 0.04297078546262384 > ./result_8chains/node118_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_1 -p 675 -st topic118_4_0 -pt topic118_4_1 -u 0.05454743052055705 > ./result_8chains/node118_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_1 -p 756 -st topic118_5_0 -pt topic118_5_1 -u 0.032190913792646506 > ./result_8chains/node118_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_6_1 -p 768 -st topic118_6_0 -pt topic118_6_1 -u 0.0037342662991016254 > ./result_8chains/node118_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_7_1 -p 960 -st topic118_7_0 -pt topic118_7_1 -u 0.011378373324477727 > ./result_8chains/node118_7_1.txt &
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
    "./result_8chains/node118_0_1.txt 90"
    "./result_8chains/node118_1_1.txt 89"
    "./result_8chains/node118_2_1.txt 88"
    "./result_8chains/node118_3_1.txt 87"
    "./result_8chains/node118_4_1.txt 86"
    "./result_8chains/node118_5_1.txt 85"
    "./result_8chains/node118_6_1.txt 84"
    "./result_8chains/node118_7_1.txt 83"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node271_0_1 -p 94 -st topic271_0_0 -pt topic271_0_1 -u 0.0019939137274579966 > ./result_8chains/node271_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_1_1 -p 137 -st topic271_1_0 -pt topic271_1_1 -u 0.03074830420239405 > ./result_8chains/node271_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_2_1 -p 363 -st topic271_2_0 -pt topic271_2_1 -u 0.003174416525796364 > ./result_8chains/node271_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_3_1 -p 477 -st topic271_3_0 -pt topic271_3_1 -u 0.004786838921794712 > ./result_8chains/node271_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_4_1 -p 506 -st topic271_4_0 -pt topic271_4_1 -u 0.034783685327369696 > ./result_8chains/node271_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_5_1 -p 545 -st topic271_5_0 -pt topic271_5_1 -u 0.023277060375802183 > ./result_8chains/node271_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_6_1 -p 606 -st topic271_6_0 -pt topic271_6_1 -u 0.0007085293721784125 > ./result_8chains/node271_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node271_7_1 -p 934 -st topic271_7_0 -pt topic271_7_1 -u 0.06597447258505186 > ./result_8chains/node271_7_1.txt &
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
    "./result_8chains/node271_0_1.txt 90"
    "./result_8chains/node271_1_1.txt 89"
    "./result_8chains/node271_2_1.txt 88"
    "./result_8chains/node271_3_1.txt 87"
    "./result_8chains/node271_4_1.txt 86"
    "./result_8chains/node271_5_1.txt 85"
    "./result_8chains/node271_6_1.txt 84"
    "./result_8chains/node271_7_1.txt 83"
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

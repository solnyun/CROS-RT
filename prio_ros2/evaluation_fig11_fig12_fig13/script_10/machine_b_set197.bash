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
ros2 run evaluation_3_randomdag uunifast_node -n node197_0_1 -p 77 -st topic197_0_0 -pt topic197_0_1 -u 0.024187137609602782 > ./result_10chains/node197_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_1_1 -p 166 -st topic197_1_0 -pt topic197_1_1 -u 0.016878322880103103 > ./result_10chains/node197_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_2_1 -p 184 -st topic197_2_0 -pt topic197_2_1 -u 0.001274530903189186 > ./result_10chains/node197_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_3_1 -p 253 -st topic197_3_0 -pt topic197_3_1 -u 0.007350775245312302 > ./result_10chains/node197_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_4_1 -p 267 -st topic197_4_0 -pt topic197_4_1 -u 0.004464385609074889 > ./result_10chains/node197_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_5_1 -p 303 -st topic197_5_0 -pt topic197_5_1 -u 0.017388276616295884 > ./result_10chains/node197_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_6_1 -p 454 -st topic197_6_0 -pt topic197_6_1 -u 0.002338440086785021 > ./result_10chains/node197_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_7_1 -p 551 -st topic197_7_0 -pt topic197_7_1 -u 0.016398566728246966 > ./result_10chains/node197_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_8_1 -p 772 -st topic197_8_0 -pt topic197_8_1 -u 0.018222466320148525 > ./result_10chains/node197_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node197_9_1 -p 951 -st topic197_9_0 -pt topic197_9_1 -u 0.002534452367267879 > ./result_10chains/node197_9_1.txt &
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
    "./result_10chains/node197_0_1.txt 90"
    "./result_10chains/node197_1_1.txt 89"
    "./result_10chains/node197_2_1.txt 88"
    "./result_10chains/node197_3_1.txt 87"
    "./result_10chains/node197_4_1.txt 86"
    "./result_10chains/node197_5_1.txt 85"
    "./result_10chains/node197_6_1.txt 84"
    "./result_10chains/node197_7_1.txt 83"
    "./result_10chains/node197_8_1.txt 82"
    "./result_10chains/node197_9_1.txt 81"
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

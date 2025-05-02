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
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_1 -p 99 -st topic338_0_0 -pt topic338_0_1 -u 0.027989738619182858 > ./result_8chains/node338_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_1 -p 438 -st topic338_1_0 -pt topic338_1_1 -u 0.03655089731793271 > ./result_8chains/node338_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_1 -p 442 -st topic338_2_0 -pt topic338_2_1 -u 0.0006403400522835834 > ./result_8chains/node338_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_1 -p 562 -st topic338_3_0 -pt topic338_3_1 -u 0.008503148854955622 > ./result_8chains/node338_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_1 -p 570 -st topic338_4_0 -pt topic338_4_1 -u 0.010160510202849277 > ./result_8chains/node338_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_1 -p 616 -st topic338_5_0 -pt topic338_5_1 -u 0.00039130729340998427 > ./result_8chains/node338_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_6_1 -p 959 -st topic338_6_0 -pt topic338_6_1 -u 0.008190840012099583 > ./result_8chains/node338_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_7_1 -p 975 -st topic338_7_0 -pt topic338_7_1 -u 0.00039755556882259055 > ./result_8chains/node338_7_1.txt &
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
    "./result_8chains/node338_0_1.txt 90"
    "./result_8chains/node338_1_1.txt 89"
    "./result_8chains/node338_2_1.txt 88"
    "./result_8chains/node338_3_1.txt 87"
    "./result_8chains/node338_4_1.txt 86"
    "./result_8chains/node338_5_1.txt 85"
    "./result_8chains/node338_6_1.txt 84"
    "./result_8chains/node338_7_1.txt 83"
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

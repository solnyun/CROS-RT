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
ros2 run evaluation_3_randomdag uunifast_node -n node388_0_1 -p 128 -st topic388_0_0 -pt topic388_0_1 -u 0.007549582311810021 > ./result_8chains/node388_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_1_1 -p 216 -st topic388_1_0 -pt topic388_1_1 -u 0.02458904764130232 > ./result_8chains/node388_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_2_1 -p 277 -st topic388_2_0 -pt topic388_2_1 -u 0.0694050134930182 > ./result_8chains/node388_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_3_1 -p 377 -st topic388_3_0 -pt topic388_3_1 -u 0.0014929636681255132 > ./result_8chains/node388_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_4_1 -p 421 -st topic388_4_0 -pt topic388_4_1 -u 0.0019020532127959622 > ./result_8chains/node388_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_5_1 -p 559 -st topic388_5_0 -pt topic388_5_1 -u 0.0010034326858414377 > ./result_8chains/node388_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_6_1 -p 573 -st topic388_6_0 -pt topic388_6_1 -u 0.008352010969450416 > ./result_8chains/node388_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node388_7_1 -p 899 -st topic388_7_0 -pt topic388_7_1 -u 0.012328914943171485 > ./result_8chains/node388_7_1.txt &
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
    "./result_8chains/node388_0_1.txt 90"
    "./result_8chains/node388_1_1.txt 89"
    "./result_8chains/node388_2_1.txt 88"
    "./result_8chains/node388_3_1.txt 87"
    "./result_8chains/node388_4_1.txt 86"
    "./result_8chains/node388_5_1.txt 85"
    "./result_8chains/node388_6_1.txt 84"
    "./result_8chains/node388_7_1.txt 83"
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

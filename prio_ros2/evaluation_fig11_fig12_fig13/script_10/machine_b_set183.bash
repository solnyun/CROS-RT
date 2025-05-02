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
ros2 run evaluation_3_randomdag uunifast_node -n node183_0_1 -p 59 -st topic183_0_0 -pt topic183_0_1 -u 0.0006954869193121493 > ./result_10chains/node183_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_1_1 -p 77 -st topic183_1_0 -pt topic183_1_1 -u 0.0068992681282689095 > ./result_10chains/node183_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_2_1 -p 155 -st topic183_2_0 -pt topic183_2_1 -u 0.05603420261888864 > ./result_10chains/node183_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_3_1 -p 198 -st topic183_3_0 -pt topic183_3_1 -u 0.01614965364843024 > ./result_10chains/node183_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_4_1 -p 293 -st topic183_4_0 -pt topic183_4_1 -u 0.010659993105004872 > ./result_10chains/node183_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_5_1 -p 438 -st topic183_5_0 -pt topic183_5_1 -u 0.008368192343689296 > ./result_10chains/node183_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_6_1 -p 475 -st topic183_6_0 -pt topic183_6_1 -u 0.0015682994741404443 > ./result_10chains/node183_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_7_1 -p 581 -st topic183_7_0 -pt topic183_7_1 -u 0.019662123545908933 > ./result_10chains/node183_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_8_1 -p 631 -st topic183_8_0 -pt topic183_8_1 -u 0.00041388929928593 > ./result_10chains/node183_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_9_1 -p 775 -st topic183_9_0 -pt topic183_9_1 -u 0.03798583904122663 > ./result_10chains/node183_9_1.txt &
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
    "./result_10chains/node183_0_1.txt 90"
    "./result_10chains/node183_1_1.txt 89"
    "./result_10chains/node183_2_1.txt 88"
    "./result_10chains/node183_3_1.txt 87"
    "./result_10chains/node183_4_1.txt 86"
    "./result_10chains/node183_5_1.txt 85"
    "./result_10chains/node183_6_1.txt 84"
    "./result_10chains/node183_7_1.txt 83"
    "./result_10chains/node183_8_1.txt 82"
    "./result_10chains/node183_9_1.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node110_0_1 -p 16 -st topic110_0_0 -pt topic110_0_1 -u 0.010310280451488352 > ./result_10chains/node110_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_1_1 -p 126 -st topic110_1_0 -pt topic110_1_1 -u 0.018009574540717388 > ./result_10chains/node110_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_2_1 -p 208 -st topic110_2_0 -pt topic110_2_1 -u 0.020527963485045764 > ./result_10chains/node110_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_3_1 -p 351 -st topic110_3_0 -pt topic110_3_1 -u 0.005151154622998755 > ./result_10chains/node110_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_4_1 -p 509 -st topic110_4_0 -pt topic110_4_1 -u 0.007892567077290247 > ./result_10chains/node110_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_5_1 -p 540 -st topic110_5_0 -pt topic110_5_1 -u 0.014322386697176087 > ./result_10chains/node110_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_6_1 -p 593 -st topic110_6_0 -pt topic110_6_1 -u 0.005670996966539721 > ./result_10chains/node110_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_7_1 -p 617 -st topic110_7_0 -pt topic110_7_1 -u 0.03646238650049195 > ./result_10chains/node110_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_8_1 -p 701 -st topic110_8_0 -pt topic110_8_1 -u 0.0012540555171946383 > ./result_10chains/node110_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node110_9_1 -p 797 -st topic110_9_0 -pt topic110_9_1 -u 0.00029055679422766365 > ./result_10chains/node110_9_1.txt &
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
    "./result_10chains/node110_0_1.txt 90"
    "./result_10chains/node110_1_1.txt 89"
    "./result_10chains/node110_2_1.txt 88"
    "./result_10chains/node110_3_1.txt 87"
    "./result_10chains/node110_4_1.txt 86"
    "./result_10chains/node110_5_1.txt 85"
    "./result_10chains/node110_6_1.txt 84"
    "./result_10chains/node110_7_1.txt 83"
    "./result_10chains/node110_8_1.txt 82"
    "./result_10chains/node110_9_1.txt 81"
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

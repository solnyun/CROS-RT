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
ros2 run evaluation_3_randomdag uunifast_node -n node326_0_1 -p 34 -st topic326_0_0 -pt topic326_0_1 -u 0.0004473819671332313 > ./result_10chains/node326_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_1_1 -p 81 -st topic326_1_0 -pt topic326_1_1 -u 0.0024773913449778195 > ./result_10chains/node326_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_2_1 -p 95 -st topic326_2_0 -pt topic326_2_1 -u 0.012666510504029171 > ./result_10chains/node326_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_3_1 -p 336 -st topic326_3_0 -pt topic326_3_1 -u 0.03611896967056577 > ./result_10chains/node326_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_4_1 -p 468 -st topic326_4_0 -pt topic326_4_1 -u 0.008444370119230826 > ./result_10chains/node326_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_5_1 -p 494 -st topic326_5_0 -pt topic326_5_1 -u 0.005022745147916063 > ./result_10chains/node326_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_6_1 -p 614 -st topic326_6_0 -pt topic326_6_1 -u 0.012142904657700432 > ./result_10chains/node326_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_7_1 -p 671 -st topic326_7_0 -pt topic326_7_1 -u 0.006150187047685884 > ./result_10chains/node326_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_8_1 -p 802 -st topic326_8_0 -pt topic326_8_1 -u 0.006703802903998822 > ./result_10chains/node326_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node326_9_1 -p 854 -st topic326_9_0 -pt topic326_9_1 -u 0.0095786994608906 > ./result_10chains/node326_9_1.txt &
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
    "./result_10chains/node326_0_1.txt 90"
    "./result_10chains/node326_1_1.txt 89"
    "./result_10chains/node326_2_1.txt 88"
    "./result_10chains/node326_3_1.txt 87"
    "./result_10chains/node326_4_1.txt 86"
    "./result_10chains/node326_5_1.txt 85"
    "./result_10chains/node326_6_1.txt 84"
    "./result_10chains/node326_7_1.txt 83"
    "./result_10chains/node326_8_1.txt 82"
    "./result_10chains/node326_9_1.txt 81"
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

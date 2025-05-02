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
ros2 run evaluation_3_randomdag uunifast_node -n node448_0_1 -p 130 -st topic448_0_0 -pt topic448_0_1 -u 0.02239181860121625 > ./result_10chains/node448_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_1_1 -p 133 -st topic448_1_0 -pt topic448_1_1 -u 0.013745719500466547 > ./result_10chains/node448_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_2_1 -p 241 -st topic448_2_0 -pt topic448_2_1 -u 0.04121264231575905 > ./result_10chains/node448_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_3_1 -p 446 -st topic448_3_0 -pt topic448_3_1 -u 0.011758043516207961 > ./result_10chains/node448_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_4_1 -p 485 -st topic448_4_0 -pt topic448_4_1 -u 0.003112664510364238 > ./result_10chains/node448_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_5_1 -p 539 -st topic448_5_0 -pt topic448_5_1 -u 0.019958626662756274 > ./result_10chains/node448_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_6_1 -p 779 -st topic448_6_0 -pt topic448_6_1 -u 0.0016875713650952306 > ./result_10chains/node448_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_7_1 -p 789 -st topic448_7_0 -pt topic448_7_1 -u 0.04665187459727908 > ./result_10chains/node448_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_8_1 -p 829 -st topic448_8_0 -pt topic448_8_1 -u 0.0033690459148511265 > ./result_10chains/node448_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node448_9_1 -p 947 -st topic448_9_0 -pt topic448_9_1 -u 0.012744953188837236 > ./result_10chains/node448_9_1.txt &
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
    "./result_10chains/node448_0_1.txt 90"
    "./result_10chains/node448_1_1.txt 89"
    "./result_10chains/node448_2_1.txt 88"
    "./result_10chains/node448_3_1.txt 87"
    "./result_10chains/node448_4_1.txt 86"
    "./result_10chains/node448_5_1.txt 85"
    "./result_10chains/node448_6_1.txt 84"
    "./result_10chains/node448_7_1.txt 83"
    "./result_10chains/node448_8_1.txt 82"
    "./result_10chains/node448_9_1.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node363_0_1 -p 50 -st topic363_0_0 -pt topic363_0_1 -u 0.020758095179021496 > ./result_10chains/node363_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_1_1 -p 107 -st topic363_1_0 -pt topic363_1_1 -u 0.007682089646488255 > ./result_10chains/node363_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_2_1 -p 183 -st topic363_2_0 -pt topic363_2_1 -u 0.05441498268386369 > ./result_10chains/node363_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_3_1 -p 305 -st topic363_3_0 -pt topic363_3_1 -u 0.04217937212958828 > ./result_10chains/node363_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_4_1 -p 386 -st topic363_4_0 -pt topic363_4_1 -u 0.009073020904571516 > ./result_10chains/node363_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_5_1 -p 395 -st topic363_5_0 -pt topic363_5_1 -u 0.0032554157274595763 > ./result_10chains/node363_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_6_1 -p 520 -st topic363_6_0 -pt topic363_6_1 -u 0.007691824550843815 > ./result_10chains/node363_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_7_1 -p 589 -st topic363_7_0 -pt topic363_7_1 -u 0.012010357264702523 > ./result_10chains/node363_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_8_1 -p 624 -st topic363_8_0 -pt topic363_8_1 -u 0.012155300697760309 > ./result_10chains/node363_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node363_9_1 -p 676 -st topic363_9_0 -pt topic363_9_1 -u 0.008596738008158352 > ./result_10chains/node363_9_1.txt &
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
    "./result_10chains/node363_0_1.txt 90"
    "./result_10chains/node363_1_1.txt 89"
    "./result_10chains/node363_2_1.txt 88"
    "./result_10chains/node363_3_1.txt 87"
    "./result_10chains/node363_4_1.txt 86"
    "./result_10chains/node363_5_1.txt 85"
    "./result_10chains/node363_6_1.txt 84"
    "./result_10chains/node363_7_1.txt 83"
    "./result_10chains/node363_8_1.txt 82"
    "./result_10chains/node363_9_1.txt 81"
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

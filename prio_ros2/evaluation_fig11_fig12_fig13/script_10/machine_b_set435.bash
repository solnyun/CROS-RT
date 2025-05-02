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
ros2 run evaluation_3_randomdag uunifast_node -n node435_0_1 -p 160 -st topic435_0_0 -pt topic435_0_1 -u 0.011071911341179519 > ./result_10chains/node435_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_1_1 -p 180 -st topic435_1_0 -pt topic435_1_1 -u 0.027729379137760912 > ./result_10chains/node435_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_2_1 -p 228 -st topic435_2_0 -pt topic435_2_1 -u 0.016319923054039343 > ./result_10chains/node435_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_3_1 -p 385 -st topic435_3_0 -pt topic435_3_1 -u 0.026465182882268623 > ./result_10chains/node435_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_4_1 -p 467 -st topic435_4_0 -pt topic435_4_1 -u 0.008626085966721486 > ./result_10chains/node435_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_5_1 -p 478 -st topic435_5_0 -pt topic435_5_1 -u 0.012995423132534711 > ./result_10chains/node435_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_6_1 -p 649 -st topic435_6_0 -pt topic435_6_1 -u 0.006841725213888206 > ./result_10chains/node435_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_7_1 -p 740 -st topic435_7_0 -pt topic435_7_1 -u 0.039756740398441626 > ./result_10chains/node435_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_8_1 -p 914 -st topic435_8_0 -pt topic435_8_1 -u 0.04334771442362209 > ./result_10chains/node435_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node435_9_1 -p 928 -st topic435_9_0 -pt topic435_9_1 -u 0.0016720982332950728 > ./result_10chains/node435_9_1.txt &
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
    "./result_10chains/node435_0_1.txt 90"
    "./result_10chains/node435_1_1.txt 89"
    "./result_10chains/node435_2_1.txt 88"
    "./result_10chains/node435_3_1.txt 87"
    "./result_10chains/node435_4_1.txt 86"
    "./result_10chains/node435_5_1.txt 85"
    "./result_10chains/node435_6_1.txt 84"
    "./result_10chains/node435_7_1.txt 83"
    "./result_10chains/node435_8_1.txt 82"
    "./result_10chains/node435_9_1.txt 81"
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

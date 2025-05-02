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
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_1 -p 214 -st topic82_0_0 -pt topic82_0_1 -u 0.013587030170999659 > ./result_10chains/node82_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_1 -p 254 -st topic82_1_0 -pt topic82_1_1 -u 0.004586343135947801 > ./result_10chains/node82_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_1 -p 276 -st topic82_2_0 -pt topic82_2_1 -u 0.00392337308408236 > ./result_10chains/node82_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_1 -p 305 -st topic82_3_0 -pt topic82_3_1 -u 0.0022640227624223797 > ./result_10chains/node82_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_1 -p 350 -st topic82_4_0 -pt topic82_4_1 -u 0.017916711729851542 > ./result_10chains/node82_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_1 -p 440 -st topic82_5_0 -pt topic82_5_1 -u 0.0027235092893020396 > ./result_10chains/node82_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_6_1 -p 469 -st topic82_6_0 -pt topic82_6_1 -u 0.002622106918778122 > ./result_10chains/node82_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_7_1 -p 578 -st topic82_7_0 -pt topic82_7_1 -u 0.0005565994722836753 > ./result_10chains/node82_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_8_1 -p 616 -st topic82_8_0 -pt topic82_8_1 -u 0.015664722172412077 > ./result_10chains/node82_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_9_1 -p 969 -st topic82_9_0 -pt topic82_9_1 -u 0.05936639273287638 > ./result_10chains/node82_9_1.txt &
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
    "./result_10chains/node82_0_1.txt 90"
    "./result_10chains/node82_1_1.txt 89"
    "./result_10chains/node82_2_1.txt 88"
    "./result_10chains/node82_3_1.txt 87"
    "./result_10chains/node82_4_1.txt 86"
    "./result_10chains/node82_5_1.txt 85"
    "./result_10chains/node82_6_1.txt 84"
    "./result_10chains/node82_7_1.txt 83"
    "./result_10chains/node82_8_1.txt 82"
    "./result_10chains/node82_9_1.txt 81"
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

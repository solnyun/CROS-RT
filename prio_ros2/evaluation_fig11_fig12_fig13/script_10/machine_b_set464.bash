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
ros2 run evaluation_3_randomdag uunifast_node -n node464_0_1 -p 130 -st topic464_0_0 -pt topic464_0_1 -u 0.015622636696743908 > ./result_10chains/node464_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_1_1 -p 162 -st topic464_1_0 -pt topic464_1_1 -u 0.010597532150635858 > ./result_10chains/node464_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_2_1 -p 185 -st topic464_2_0 -pt topic464_2_1 -u 0.027169024492820437 > ./result_10chains/node464_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_3_1 -p 428 -st topic464_3_0 -pt topic464_3_1 -u 0.009501343397917805 > ./result_10chains/node464_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_4_1 -p 672 -st topic464_4_0 -pt topic464_4_1 -u 0.011117586331580387 > ./result_10chains/node464_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_5_1 -p 763 -st topic464_5_0 -pt topic464_5_1 -u 0.0033263658333392843 > ./result_10chains/node464_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_6_1 -p 808 -st topic464_6_0 -pt topic464_6_1 -u 0.013867221591104484 > ./result_10chains/node464_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_7_1 -p 962 -st topic464_7_0 -pt topic464_7_1 -u 0.013885766905963742 > ./result_10chains/node464_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_8_1 -p 973 -st topic464_8_0 -pt topic464_8_1 -u 0.002202550817891863 > ./result_10chains/node464_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node464_9_1 -p 988 -st topic464_9_0 -pt topic464_9_1 -u 0.04638049304660784 > ./result_10chains/node464_9_1.txt &
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
    "./result_10chains/node464_0_1.txt 90"
    "./result_10chains/node464_1_1.txt 89"
    "./result_10chains/node464_2_1.txt 88"
    "./result_10chains/node464_3_1.txt 87"
    "./result_10chains/node464_4_1.txt 86"
    "./result_10chains/node464_5_1.txt 85"
    "./result_10chains/node464_6_1.txt 84"
    "./result_10chains/node464_7_1.txt 83"
    "./result_10chains/node464_8_1.txt 82"
    "./result_10chains/node464_9_1.txt 81"
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

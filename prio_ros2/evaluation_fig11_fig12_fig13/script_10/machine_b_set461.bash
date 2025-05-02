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
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_1 -p 168 -st topic461_0_0 -pt topic461_0_1 -u 0.0006983006176747297 > ./result_10chains/node461_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_1 -p 345 -st topic461_1_0 -pt topic461_1_1 -u 0.021626466731613503 > ./result_10chains/node461_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_1 -p 483 -st topic461_2_0 -pt topic461_2_1 -u 0.015834837951525904 > ./result_10chains/node461_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_1 -p 509 -st topic461_3_0 -pt topic461_3_1 -u 0.00648848884543457 > ./result_10chains/node461_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_1 -p 833 -st topic461_4_0 -pt topic461_4_1 -u 0.01979157308617524 > ./result_10chains/node461_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_1 -p 847 -st topic461_5_0 -pt topic461_5_1 -u 0.02245458765249167 > ./result_10chains/node461_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_6_1 -p 895 -st topic461_6_0 -pt topic461_6_1 -u 0.024279605442098257 > ./result_10chains/node461_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_7_1 -p 899 -st topic461_7_0 -pt topic461_7_1 -u 0.03180582054838687 > ./result_10chains/node461_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_8_1 -p 961 -st topic461_8_0 -pt topic461_8_1 -u 0.0019651535399912573 > ./result_10chains/node461_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_9_1 -p 973 -st topic461_9_0 -pt topic461_9_1 -u 0.0027960569634604138 > ./result_10chains/node461_9_1.txt &
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
    "./result_10chains/node461_0_1.txt 90"
    "./result_10chains/node461_1_1.txt 89"
    "./result_10chains/node461_2_1.txt 88"
    "./result_10chains/node461_3_1.txt 87"
    "./result_10chains/node461_4_1.txt 86"
    "./result_10chains/node461_5_1.txt 85"
    "./result_10chains/node461_6_1.txt 84"
    "./result_10chains/node461_7_1.txt 83"
    "./result_10chains/node461_8_1.txt 82"
    "./result_10chains/node461_9_1.txt 81"
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

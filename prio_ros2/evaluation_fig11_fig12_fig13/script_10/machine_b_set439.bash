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
ros2 run evaluation_3_randomdag uunifast_node -n node439_0_1 -p 82 -st topic439_0_0 -pt topic439_0_1 -u 0.03691757218794678 > ./result_10chains/node439_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_1_1 -p 311 -st topic439_1_0 -pt topic439_1_1 -u 0.02861720377244592 > ./result_10chains/node439_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_2_1 -p 358 -st topic439_2_0 -pt topic439_2_1 -u 0.001477106325619204 > ./result_10chains/node439_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_3_1 -p 463 -st topic439_3_0 -pt topic439_3_1 -u 0.03989868578044953 > ./result_10chains/node439_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_4_1 -p 536 -st topic439_4_0 -pt topic439_4_1 -u 0.0072319714117267675 > ./result_10chains/node439_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_5_1 -p 542 -st topic439_5_0 -pt topic439_5_1 -u 0.01589319283460275 > ./result_10chains/node439_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_6_1 -p 569 -st topic439_6_0 -pt topic439_6_1 -u 0.0011229930889017081 > ./result_10chains/node439_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_7_1 -p 598 -st topic439_7_0 -pt topic439_7_1 -u 0.014296338136859363 > ./result_10chains/node439_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_8_1 -p 635 -st topic439_8_0 -pt topic439_8_1 -u 0.0047465185574396 > ./result_10chains/node439_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node439_9_1 -p 719 -st topic439_9_0 -pt topic439_9_1 -u 0.03157578795527657 > ./result_10chains/node439_9_1.txt &
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
    "./result_10chains/node439_0_1.txt 90"
    "./result_10chains/node439_1_1.txt 89"
    "./result_10chains/node439_2_1.txt 88"
    "./result_10chains/node439_3_1.txt 87"
    "./result_10chains/node439_4_1.txt 86"
    "./result_10chains/node439_5_1.txt 85"
    "./result_10chains/node439_6_1.txt 84"
    "./result_10chains/node439_7_1.txt 83"
    "./result_10chains/node439_8_1.txt 82"
    "./result_10chains/node439_9_1.txt 81"
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

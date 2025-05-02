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
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_1 -p 200 -st topic469_0_0 -pt topic469_0_1 -u 0.011585520868596266 > ./result_10chains/node469_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_1 -p 203 -st topic469_1_0 -pt topic469_1_1 -u 0.001376587860973666 > ./result_10chains/node469_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_1 -p 237 -st topic469_2_0 -pt topic469_2_1 -u 0.0009484840487650747 > ./result_10chains/node469_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_1 -p 329 -st topic469_3_0 -pt topic469_3_1 -u 0.008515650787433604 > ./result_10chains/node469_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_1 -p 416 -st topic469_4_0 -pt topic469_4_1 -u 0.006939906302668608 > ./result_10chains/node469_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_1 -p 517 -st topic469_5_0 -pt topic469_5_1 -u 0.07488499604846263 > ./result_10chains/node469_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_6_1 -p 600 -st topic469_6_0 -pt topic469_6_1 -u 0.0011993727538092691 > ./result_10chains/node469_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_7_1 -p 638 -st topic469_7_0 -pt topic469_7_1 -u 0.0631714057523442 > ./result_10chains/node469_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_8_1 -p 747 -st topic469_8_0 -pt topic469_8_1 -u 0.01520111254587149 > ./result_10chains/node469_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_9_1 -p 790 -st topic469_9_0 -pt topic469_9_1 -u 0.006997212525838567 > ./result_10chains/node469_9_1.txt &
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
    "./result_10chains/node469_0_1.txt 90"
    "./result_10chains/node469_1_1.txt 89"
    "./result_10chains/node469_2_1.txt 88"
    "./result_10chains/node469_3_1.txt 87"
    "./result_10chains/node469_4_1.txt 86"
    "./result_10chains/node469_5_1.txt 85"
    "./result_10chains/node469_6_1.txt 84"
    "./result_10chains/node469_7_1.txt 83"
    "./result_10chains/node469_8_1.txt 82"
    "./result_10chains/node469_9_1.txt 81"
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

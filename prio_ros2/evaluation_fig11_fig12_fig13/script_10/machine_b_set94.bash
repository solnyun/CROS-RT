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
ros2 run evaluation_3_randomdag uunifast_node -n node94_0_1 -p 519 -st topic94_0_0 -pt topic94_0_1 -u 0.08257908208303755 > ./result_10chains/node94_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_1_1 -p 579 -st topic94_1_0 -pt topic94_1_1 -u 0.03612981289046435 > ./result_10chains/node94_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_2_1 -p 582 -st topic94_2_0 -pt topic94_2_1 -u 0.008542341440996942 > ./result_10chains/node94_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_3_1 -p 643 -st topic94_3_0 -pt topic94_3_1 -u 0.019420036228621318 > ./result_10chains/node94_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_4_1 -p 684 -st topic94_4_0 -pt topic94_4_1 -u 0.0007689293166570632 > ./result_10chains/node94_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_5_1 -p 734 -st topic94_5_0 -pt topic94_5_1 -u 0.005758738086406784 > ./result_10chains/node94_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_6_1 -p 767 -st topic94_6_0 -pt topic94_6_1 -u 0.014735649334248396 > ./result_10chains/node94_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_7_1 -p 791 -st topic94_7_0 -pt topic94_7_1 -u 0.004917720729110606 > ./result_10chains/node94_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_8_1 -p 822 -st topic94_8_0 -pt topic94_8_1 -u 0.021507102856657044 > ./result_10chains/node94_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node94_9_1 -p 948 -st topic94_9_0 -pt topic94_9_1 -u 0.016862788438525532 > ./result_10chains/node94_9_1.txt &
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
    "./result_10chains/node94_0_1.txt 90"
    "./result_10chains/node94_1_1.txt 89"
    "./result_10chains/node94_2_1.txt 88"
    "./result_10chains/node94_3_1.txt 87"
    "./result_10chains/node94_4_1.txt 86"
    "./result_10chains/node94_5_1.txt 85"
    "./result_10chains/node94_6_1.txt 84"
    "./result_10chains/node94_7_1.txt 83"
    "./result_10chains/node94_8_1.txt 82"
    "./result_10chains/node94_9_1.txt 81"
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

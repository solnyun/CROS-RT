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
ros2 run evaluation_3_randomdag uunifast_node -n node204_0_1 -p 66 -st topic204_0_0 -pt topic204_0_1 -u 0.005680307287037778 > ./result_10chains/node204_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_1_1 -p 144 -st topic204_1_0 -pt topic204_1_1 -u 0.0007560801881854595 > ./result_10chains/node204_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_2_1 -p 240 -st topic204_2_0 -pt topic204_2_1 -u 0.008916993158430309 > ./result_10chains/node204_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_3_1 -p 335 -st topic204_3_0 -pt topic204_3_1 -u 0.0074623490585903896 > ./result_10chains/node204_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_4_1 -p 385 -st topic204_4_0 -pt topic204_4_1 -u 0.004728178211915901 > ./result_10chains/node204_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_5_1 -p 407 -st topic204_5_0 -pt topic204_5_1 -u 0.0006598030178946446 > ./result_10chains/node204_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_6_1 -p 420 -st topic204_6_0 -pt topic204_6_1 -u 0.020077010330636302 > ./result_10chains/node204_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_7_1 -p 812 -st topic204_7_0 -pt topic204_7_1 -u 0.00741056572607765 > ./result_10chains/node204_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_8_1 -p 879 -st topic204_8_0 -pt topic204_8_1 -u 0.011896839357829522 > ./result_10chains/node204_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node204_9_1 -p 956 -st topic204_9_0 -pt topic204_9_1 -u 0.040804334248546764 > ./result_10chains/node204_9_1.txt &
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
    "./result_10chains/node204_0_1.txt 90"
    "./result_10chains/node204_1_1.txt 89"
    "./result_10chains/node204_2_1.txt 88"
    "./result_10chains/node204_3_1.txt 87"
    "./result_10chains/node204_4_1.txt 86"
    "./result_10chains/node204_5_1.txt 85"
    "./result_10chains/node204_6_1.txt 84"
    "./result_10chains/node204_7_1.txt 83"
    "./result_10chains/node204_8_1.txt 82"
    "./result_10chains/node204_9_1.txt 81"
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

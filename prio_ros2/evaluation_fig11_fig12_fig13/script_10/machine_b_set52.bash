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
ros2 run evaluation_3_randomdag uunifast_node -n node52_0_1 -p 31 -st topic52_0_0 -pt topic52_0_1 -u 0.0054140373372605355 > ./result_10chains/node52_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_1_1 -p 102 -st topic52_1_0 -pt topic52_1_1 -u 0.0032444342559965755 > ./result_10chains/node52_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_2_1 -p 281 -st topic52_2_0 -pt topic52_2_1 -u 0.009605823264197677 > ./result_10chains/node52_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_3_1 -p 500 -st topic52_3_0 -pt topic52_3_1 -u 0.010953363675584415 > ./result_10chains/node52_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_4_1 -p 577 -st topic52_4_0 -pt topic52_4_1 -u 0.09013927074362754 > ./result_10chains/node52_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_5_1 -p 635 -st topic52_5_0 -pt topic52_5_1 -u 0.010970882592529624 > ./result_10chains/node52_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_6_1 -p 778 -st topic52_6_0 -pt topic52_6_1 -u 0.011511865700631424 > ./result_10chains/node52_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_7_1 -p 954 -st topic52_7_0 -pt topic52_7_1 -u 0.0039027663116386335 > ./result_10chains/node52_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_8_1 -p 985 -st topic52_8_0 -pt topic52_8_1 -u 0.02140403510859412 > ./result_10chains/node52_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node52_9_1 -p 986 -st topic52_9_0 -pt topic52_9_1 -u 0.011675352880652148 > ./result_10chains/node52_9_1.txt &
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
    "./result_10chains/node52_0_1.txt 90"
    "./result_10chains/node52_1_1.txt 89"
    "./result_10chains/node52_2_1.txt 88"
    "./result_10chains/node52_3_1.txt 87"
    "./result_10chains/node52_4_1.txt 86"
    "./result_10chains/node52_5_1.txt 85"
    "./result_10chains/node52_6_1.txt 84"
    "./result_10chains/node52_7_1.txt 83"
    "./result_10chains/node52_8_1.txt 82"
    "./result_10chains/node52_9_1.txt 81"
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

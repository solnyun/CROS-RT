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
ros2 run evaluation_3_randomdag uunifast_node -n node218_0_1 -p 46 -st topic218_0_0 -pt topic218_0_1 -u 0.007380315326624753 > ./result_10chains/node218_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_1_1 -p 54 -st topic218_1_0 -pt topic218_1_1 -u 0.034635763164520716 > ./result_10chains/node218_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_2_1 -p 170 -st topic218_2_0 -pt topic218_2_1 -u 0.003913746840062682 > ./result_10chains/node218_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_3_1 -p 299 -st topic218_3_0 -pt topic218_3_1 -u 0.013534180772890814 > ./result_10chains/node218_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_4_1 -p 335 -st topic218_4_0 -pt topic218_4_1 -u 0.007777823044414711 > ./result_10chains/node218_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_5_1 -p 362 -st topic218_5_0 -pt topic218_5_1 -u 0.02200329005667162 > ./result_10chains/node218_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_6_1 -p 425 -st topic218_6_0 -pt topic218_6_1 -u 0.02979204049827397 > ./result_10chains/node218_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_7_1 -p 670 -st topic218_7_0 -pt topic218_7_1 -u 0.028400919988685713 > ./result_10chains/node218_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_8_1 -p 858 -st topic218_8_0 -pt topic218_8_1 -u 0.05089559525932799 > ./result_10chains/node218_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node218_9_1 -p 870 -st topic218_9_0 -pt topic218_9_1 -u 0.002151079954304984 > ./result_10chains/node218_9_1.txt &
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
    "./result_10chains/node218_0_1.txt 90"
    "./result_10chains/node218_1_1.txt 89"
    "./result_10chains/node218_2_1.txt 88"
    "./result_10chains/node218_3_1.txt 87"
    "./result_10chains/node218_4_1.txt 86"
    "./result_10chains/node218_5_1.txt 85"
    "./result_10chains/node218_6_1.txt 84"
    "./result_10chains/node218_7_1.txt 83"
    "./result_10chains/node218_8_1.txt 82"
    "./result_10chains/node218_9_1.txt 81"
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

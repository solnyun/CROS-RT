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
ros2 run evaluation_3_randomdag uunifast_node -n node245_0_1 -p 47 -st topic245_0_0 -pt topic245_0_1 -u 0.002635416021621928 > ./result_10chains/node245_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_1_1 -p 88 -st topic245_1_0 -pt topic245_1_1 -u 0.01840628408786643 > ./result_10chains/node245_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_2_1 -p 192 -st topic245_2_0 -pt topic245_2_1 -u 0.02612846091739468 > ./result_10chains/node245_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_3_1 -p 388 -st topic245_3_0 -pt topic245_3_1 -u 0.004520543210440875 > ./result_10chains/node245_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_4_1 -p 424 -st topic245_4_0 -pt topic245_4_1 -u 0.02860560877340279 > ./result_10chains/node245_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_5_1 -p 547 -st topic245_5_0 -pt topic245_5_1 -u 0.01593102005165331 > ./result_10chains/node245_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_6_1 -p 651 -st topic245_6_0 -pt topic245_6_1 -u 0.005531004288153396 > ./result_10chains/node245_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_7_1 -p 804 -st topic245_7_0 -pt topic245_7_1 -u 0.005917972018607914 > ./result_10chains/node245_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_8_1 -p 916 -st topic245_8_0 -pt topic245_8_1 -u 0.09586348136315796 > ./result_10chains/node245_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node245_9_1 -p 917 -st topic245_9_0 -pt topic245_9_1 -u 0.011123799194117946 > ./result_10chains/node245_9_1.txt &
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
    "./result_10chains/node245_0_1.txt 90"
    "./result_10chains/node245_1_1.txt 89"
    "./result_10chains/node245_2_1.txt 88"
    "./result_10chains/node245_3_1.txt 87"
    "./result_10chains/node245_4_1.txt 86"
    "./result_10chains/node245_5_1.txt 85"
    "./result_10chains/node245_6_1.txt 84"
    "./result_10chains/node245_7_1.txt 83"
    "./result_10chains/node245_8_1.txt 82"
    "./result_10chains/node245_9_1.txt 81"
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

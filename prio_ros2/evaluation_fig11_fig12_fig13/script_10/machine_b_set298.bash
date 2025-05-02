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
ros2 run evaluation_3_randomdag uunifast_node -n node298_0_1 -p 22 -st topic298_0_0 -pt topic298_0_1 -u 0.003179291658807981 > ./result_10chains/node298_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_1_1 -p 86 -st topic298_1_0 -pt topic298_1_1 -u 0.02052902543790086 > ./result_10chains/node298_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_2_1 -p 101 -st topic298_2_0 -pt topic298_2_1 -u 0.02002389718761788 > ./result_10chains/node298_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_3_1 -p 136 -st topic298_3_0 -pt topic298_3_1 -u 0.003888856120810247 > ./result_10chains/node298_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_4_1 -p 316 -st topic298_4_0 -pt topic298_4_1 -u 0.014140528797961238 > ./result_10chains/node298_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_5_1 -p 321 -st topic298_5_0 -pt topic298_5_1 -u 0.02552199746588879 > ./result_10chains/node298_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_6_1 -p 351 -st topic298_6_0 -pt topic298_6_1 -u 0.0002690563519166522 > ./result_10chains/node298_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_7_1 -p 471 -st topic298_7_0 -pt topic298_7_1 -u 0.02111498716209123 > ./result_10chains/node298_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_8_1 -p 535 -st topic298_8_0 -pt topic298_8_1 -u 0.001406781141058619 > ./result_10chains/node298_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node298_9_1 -p 729 -st topic298_9_0 -pt topic298_9_1 -u 0.015832841469513567 > ./result_10chains/node298_9_1.txt &
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
    "./result_10chains/node298_0_1.txt 90"
    "./result_10chains/node298_1_1.txt 89"
    "./result_10chains/node298_2_1.txt 88"
    "./result_10chains/node298_3_1.txt 87"
    "./result_10chains/node298_4_1.txt 86"
    "./result_10chains/node298_5_1.txt 85"
    "./result_10chains/node298_6_1.txt 84"
    "./result_10chains/node298_7_1.txt 83"
    "./result_10chains/node298_8_1.txt 82"
    "./result_10chains/node298_9_1.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node479_0_1 -p 33 -st topic479_0_0 -pt topic479_0_1 -u 0.03899575900272684 > ./result_10chains/node479_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_1_1 -p 46 -st topic479_1_0 -pt topic479_1_1 -u 0.013021335635878928 > ./result_10chains/node479_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_2_1 -p 162 -st topic479_2_0 -pt topic479_2_1 -u 0.018656085516070176 > ./result_10chains/node479_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_3_1 -p 178 -st topic479_3_0 -pt topic479_3_1 -u 0.004214125807825209 > ./result_10chains/node479_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_4_1 -p 262 -st topic479_4_0 -pt topic479_4_1 -u 0.012767202578205183 > ./result_10chains/node479_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_5_1 -p 465 -st topic479_5_0 -pt topic479_5_1 -u 0.0029861232484033606 > ./result_10chains/node479_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_6_1 -p 772 -st topic479_6_0 -pt topic479_6_1 -u 0.005406955416811521 > ./result_10chains/node479_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_7_1 -p 840 -st topic479_7_0 -pt topic479_7_1 -u 0.005033845664585007 > ./result_10chains/node479_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_8_1 -p 878 -st topic479_8_0 -pt topic479_8_1 -u 0.009233930175531535 > ./result_10chains/node479_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node479_9_1 -p 927 -st topic479_9_0 -pt topic479_9_1 -u 0.061308752537214406 > ./result_10chains/node479_9_1.txt &
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
    "./result_10chains/node479_0_1.txt 90"
    "./result_10chains/node479_1_1.txt 89"
    "./result_10chains/node479_2_1.txt 88"
    "./result_10chains/node479_3_1.txt 87"
    "./result_10chains/node479_4_1.txt 86"
    "./result_10chains/node479_5_1.txt 85"
    "./result_10chains/node479_6_1.txt 84"
    "./result_10chains/node479_7_1.txt 83"
    "./result_10chains/node479_8_1.txt 82"
    "./result_10chains/node479_9_1.txt 81"
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

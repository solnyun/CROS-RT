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
ros2 run evaluation_3_randomdag uunifast_node -n node103_0_1 -p 37 -st topic103_0_0 -pt topic103_0_1 -u 0.014399925634684507 > ./result_10chains/node103_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_1_1 -p 222 -st topic103_1_0 -pt topic103_1_1 -u 0.004662735720042166 > ./result_10chains/node103_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_2_1 -p 237 -st topic103_2_0 -pt topic103_2_1 -u 0.008883673722739793 > ./result_10chains/node103_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_3_1 -p 391 -st topic103_3_0 -pt topic103_3_1 -u 0.0054385619645531125 > ./result_10chains/node103_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_4_1 -p 466 -st topic103_4_0 -pt topic103_4_1 -u 0.014878214550677948 > ./result_10chains/node103_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_5_1 -p 520 -st topic103_5_0 -pt topic103_5_1 -u 0.0070940185931382405 > ./result_10chains/node103_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_6_1 -p 588 -st topic103_6_0 -pt topic103_6_1 -u 0.032612639342671806 > ./result_10chains/node103_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_7_1 -p 724 -st topic103_7_0 -pt topic103_7_1 -u 0.029158955682161147 > ./result_10chains/node103_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_8_1 -p 902 -st topic103_8_0 -pt topic103_8_1 -u 0.03872433491511008 > ./result_10chains/node103_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node103_9_1 -p 943 -st topic103_9_0 -pt topic103_9_1 -u 0.0048466091360383394 > ./result_10chains/node103_9_1.txt &
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
    "./result_10chains/node103_0_1.txt 90"
    "./result_10chains/node103_1_1.txt 89"
    "./result_10chains/node103_2_1.txt 88"
    "./result_10chains/node103_3_1.txt 87"
    "./result_10chains/node103_4_1.txt 86"
    "./result_10chains/node103_5_1.txt 85"
    "./result_10chains/node103_6_1.txt 84"
    "./result_10chains/node103_7_1.txt 83"
    "./result_10chains/node103_8_1.txt 82"
    "./result_10chains/node103_9_1.txt 81"
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

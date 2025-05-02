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
ros2 run evaluation_3_randomdag uunifast_node -n node149_0_1 -p 10 -st topic149_0_0 -pt topic149_0_1 -u 0.009728784361269949 > ./result_10chains/node149_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_1_1 -p 76 -st topic149_1_0 -pt topic149_1_1 -u 0.0025953762593500795 > ./result_10chains/node149_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_2_1 -p 229 -st topic149_2_0 -pt topic149_2_1 -u 0.0046873762482750325 > ./result_10chains/node149_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_3_1 -p 256 -st topic149_3_0 -pt topic149_3_1 -u 0.05234275028695656 > ./result_10chains/node149_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_4_1 -p 274 -st topic149_4_0 -pt topic149_4_1 -u 0.0002589978467539833 > ./result_10chains/node149_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_5_1 -p 298 -st topic149_5_0 -pt topic149_5_1 -u 0.04140291046029254 > ./result_10chains/node149_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_6_1 -p 343 -st topic149_6_0 -pt topic149_6_1 -u 0.0006407316835668753 > ./result_10chains/node149_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_7_1 -p 498 -st topic149_7_0 -pt topic149_7_1 -u 0.02084976411150094 > ./result_10chains/node149_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_8_1 -p 818 -st topic149_8_0 -pt topic149_8_1 -u 0.0001142986408302904 > ./result_10chains/node149_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node149_9_1 -p 874 -st topic149_9_0 -pt topic149_9_1 -u 0.014716459671377219 > ./result_10chains/node149_9_1.txt &
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
    "./result_10chains/node149_0_1.txt 90"
    "./result_10chains/node149_1_1.txt 89"
    "./result_10chains/node149_2_1.txt 88"
    "./result_10chains/node149_3_1.txt 87"
    "./result_10chains/node149_4_1.txt 86"
    "./result_10chains/node149_5_1.txt 85"
    "./result_10chains/node149_6_1.txt 84"
    "./result_10chains/node149_7_1.txt 83"
    "./result_10chains/node149_8_1.txt 82"
    "./result_10chains/node149_9_1.txt 81"
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

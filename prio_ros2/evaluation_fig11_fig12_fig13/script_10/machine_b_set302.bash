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
ros2 run evaluation_3_randomdag uunifast_node -n node302_0_1 -p 66 -st topic302_0_0 -pt topic302_0_1 -u 0.006246717521256884 > ./result_10chains/node302_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_1_1 -p 178 -st topic302_1_0 -pt topic302_1_1 -u 0.022310722713831055 > ./result_10chains/node302_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_2_1 -p 257 -st topic302_2_0 -pt topic302_2_1 -u 0.024225049872158122 > ./result_10chains/node302_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_3_1 -p 409 -st topic302_3_0 -pt topic302_3_1 -u 0.010445854595127368 > ./result_10chains/node302_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_4_1 -p 622 -st topic302_4_0 -pt topic302_4_1 -u 0.01574617853689908 > ./result_10chains/node302_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_5_1 -p 728 -st topic302_5_0 -pt topic302_5_1 -u 0.003345415287460407 > ./result_10chains/node302_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_6_1 -p 732 -st topic302_6_0 -pt topic302_6_1 -u 0.04523878533390718 > ./result_10chains/node302_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_7_1 -p 746 -st topic302_7_0 -pt topic302_7_1 -u 0.01361396536798258 > ./result_10chains/node302_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_8_1 -p 838 -st topic302_8_0 -pt topic302_8_1 -u 0.005484133816627185 > ./result_10chains/node302_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_9_1 -p 993 -st topic302_9_0 -pt topic302_9_1 -u 0.011452469590227325 > ./result_10chains/node302_9_1.txt &
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
    "./result_10chains/node302_0_1.txt 90"
    "./result_10chains/node302_1_1.txt 89"
    "./result_10chains/node302_2_1.txt 88"
    "./result_10chains/node302_3_1.txt 87"
    "./result_10chains/node302_4_1.txt 86"
    "./result_10chains/node302_5_1.txt 85"
    "./result_10chains/node302_6_1.txt 84"
    "./result_10chains/node302_7_1.txt 83"
    "./result_10chains/node302_8_1.txt 82"
    "./result_10chains/node302_9_1.txt 81"
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

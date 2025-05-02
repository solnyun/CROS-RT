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
ros2 run evaluation_3_randomdag uunifast_node -n node105_0_1 -p 122 -st topic105_0_0 -pt topic105_0_1 -u 0.004558906326476098 > ./result_10chains/node105_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_1_1 -p 133 -st topic105_1_0 -pt topic105_1_1 -u 0.006620522698221221 > ./result_10chains/node105_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_2_1 -p 199 -st topic105_2_0 -pt topic105_2_1 -u 0.05665582927225449 > ./result_10chains/node105_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_3_1 -p 382 -st topic105_3_0 -pt topic105_3_1 -u 0.08127816773510244 > ./result_10chains/node105_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_4_1 -p 450 -st topic105_4_0 -pt topic105_4_1 -u 0.0025705727605420114 > ./result_10chains/node105_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_5_1 -p 544 -st topic105_5_0 -pt topic105_5_1 -u 0.0029160096907845934 > ./result_10chains/node105_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_6_1 -p 610 -st topic105_6_0 -pt topic105_6_1 -u 0.04289083681468259 > ./result_10chains/node105_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_7_1 -p 626 -st topic105_7_0 -pt topic105_7_1 -u 0.014151566300710974 > ./result_10chains/node105_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_8_1 -p 657 -st topic105_8_0 -pt topic105_8_1 -u 0.027991271888795514 > ./result_10chains/node105_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_9_1 -p 913 -st topic105_9_0 -pt topic105_9_1 -u 0.010642955504767054 > ./result_10chains/node105_9_1.txt &
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
    "./result_10chains/node105_0_1.txt 90"
    "./result_10chains/node105_1_1.txt 89"
    "./result_10chains/node105_2_1.txt 88"
    "./result_10chains/node105_3_1.txt 87"
    "./result_10chains/node105_4_1.txt 86"
    "./result_10chains/node105_5_1.txt 85"
    "./result_10chains/node105_6_1.txt 84"
    "./result_10chains/node105_7_1.txt 83"
    "./result_10chains/node105_8_1.txt 82"
    "./result_10chains/node105_9_1.txt 81"
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

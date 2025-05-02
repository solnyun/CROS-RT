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
ros2 run evaluation_3_randomdag uunifast_node -n node383_0_1 -p 71 -st topic383_0_0 -pt topic383_0_1 -u 0.011534327370843644 > ./result_10chains/node383_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_1_1 -p 212 -st topic383_1_0 -pt topic383_1_1 -u 0.01563849754885399 > ./result_10chains/node383_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_2_1 -p 249 -st topic383_2_0 -pt topic383_2_1 -u 0.0003100827903490533 > ./result_10chains/node383_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_3_1 -p 272 -st topic383_3_0 -pt topic383_3_1 -u 0.013259587178805543 > ./result_10chains/node383_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_4_1 -p 355 -st topic383_4_0 -pt topic383_4_1 -u 0.008771754273250387 > ./result_10chains/node383_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_5_1 -p 387 -st topic383_5_0 -pt topic383_5_1 -u 0.00447096228036481 > ./result_10chains/node383_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_6_1 -p 447 -st topic383_6_0 -pt topic383_6_1 -u 0.012110494672236488 > ./result_10chains/node383_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_7_1 -p 485 -st topic383_7_0 -pt topic383_7_1 -u 0.005494403671685882 > ./result_10chains/node383_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_8_1 -p 747 -st topic383_8_0 -pt topic383_8_1 -u 0.045050407204235074 > ./result_10chains/node383_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node383_9_1 -p 915 -st topic383_9_0 -pt topic383_9_1 -u 0.004040045217083413 > ./result_10chains/node383_9_1.txt &
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
    "./result_10chains/node383_0_1.txt 90"
    "./result_10chains/node383_1_1.txt 89"
    "./result_10chains/node383_2_1.txt 88"
    "./result_10chains/node383_3_1.txt 87"
    "./result_10chains/node383_4_1.txt 86"
    "./result_10chains/node383_5_1.txt 85"
    "./result_10chains/node383_6_1.txt 84"
    "./result_10chains/node383_7_1.txt 83"
    "./result_10chains/node383_8_1.txt 82"
    "./result_10chains/node383_9_1.txt 81"
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

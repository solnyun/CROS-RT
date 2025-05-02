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
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_1 -p 54 -st topic179_0_0 -pt topic179_0_1 -u 0.001574332017955593 > ./result_10chains/node179_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_1 -p 136 -st topic179_1_0 -pt topic179_1_1 -u 0.004796817053864533 > ./result_10chains/node179_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_1 -p 243 -st topic179_2_0 -pt topic179_2_1 -u 0.019445451419366044 > ./result_10chains/node179_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_1 -p 389 -st topic179_3_0 -pt topic179_3_1 -u 0.007269727312232799 > ./result_10chains/node179_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_1 -p 421 -st topic179_4_0 -pt topic179_4_1 -u 0.02622463355081034 > ./result_10chains/node179_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_1 -p 539 -st topic179_5_0 -pt topic179_5_1 -u 0.02636967701746218 > ./result_10chains/node179_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_6_1 -p 692 -st topic179_6_0 -pt topic179_6_1 -u 0.013434369992849804 > ./result_10chains/node179_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_7_1 -p 776 -st topic179_7_0 -pt topic179_7_1 -u 0.026356972785854027 > ./result_10chains/node179_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_8_1 -p 856 -st topic179_8_0 -pt topic179_8_1 -u 0.022205008349640898 > ./result_10chains/node179_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_9_1 -p 934 -st topic179_9_0 -pt topic179_9_1 -u 0.022345719158229096 > ./result_10chains/node179_9_1.txt &
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
    "./result_10chains/node179_0_1.txt 90"
    "./result_10chains/node179_1_1.txt 89"
    "./result_10chains/node179_2_1.txt 88"
    "./result_10chains/node179_3_1.txt 87"
    "./result_10chains/node179_4_1.txt 86"
    "./result_10chains/node179_5_1.txt 85"
    "./result_10chains/node179_6_1.txt 84"
    "./result_10chains/node179_7_1.txt 83"
    "./result_10chains/node179_8_1.txt 82"
    "./result_10chains/node179_9_1.txt 81"
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

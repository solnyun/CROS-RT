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
ros2 run evaluation_3_randomdag uunifast_node -n node263_0_1 -p 78 -st topic263_0_0 -pt topic263_0_1 -u 0.0049622166292685455 > ./result_8chains/node263_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_1_1 -p 164 -st topic263_1_0 -pt topic263_1_1 -u 0.036327176280946394 > ./result_8chains/node263_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_2_1 -p 232 -st topic263_2_0 -pt topic263_2_1 -u 0.005856722346296306 > ./result_8chains/node263_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_3_1 -p 573 -st topic263_3_0 -pt topic263_3_1 -u 0.035156861452099675 > ./result_8chains/node263_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_4_1 -p 785 -st topic263_4_0 -pt topic263_4_1 -u 0.026552647689688846 > ./result_8chains/node263_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_5_1 -p 790 -st topic263_5_0 -pt topic263_5_1 -u 0.03248561551124693 > ./result_8chains/node263_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_6_1 -p 824 -st topic263_6_0 -pt topic263_6_1 -u 0.05039731412148005 > ./result_8chains/node263_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node263_7_1 -p 851 -st topic263_7_0 -pt topic263_7_1 -u 0.03916727707321203 > ./result_8chains/node263_7_1.txt &
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
    "./result_8chains/node263_0_1.txt 90"
    "./result_8chains/node263_1_1.txt 89"
    "./result_8chains/node263_2_1.txt 88"
    "./result_8chains/node263_3_1.txt 87"
    "./result_8chains/node263_4_1.txt 86"
    "./result_8chains/node263_5_1.txt 85"
    "./result_8chains/node263_6_1.txt 84"
    "./result_8chains/node263_7_1.txt 83"
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

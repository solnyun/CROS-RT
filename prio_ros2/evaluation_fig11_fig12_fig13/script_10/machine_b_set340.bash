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
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_1 -p 84 -st topic340_0_0 -pt topic340_0_1 -u 0.05267148510122893 > ./result_10chains/node340_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_1 -p 121 -st topic340_1_0 -pt topic340_1_1 -u 0.005703710270238527 > ./result_10chains/node340_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_1 -p 324 -st topic340_2_0 -pt topic340_2_1 -u 0.018518893208242404 > ./result_10chains/node340_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_1 -p 452 -st topic340_3_0 -pt topic340_3_1 -u 0.026978166441317647 > ./result_10chains/node340_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_4_1 -p 474 -st topic340_4_0 -pt topic340_4_1 -u 0.0007461550845945797 > ./result_10chains/node340_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_5_1 -p 569 -st topic340_5_0 -pt topic340_5_1 -u 0.009523585288161662 > ./result_10chains/node340_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_6_1 -p 691 -st topic340_6_0 -pt topic340_6_1 -u 0.0050811637383209735 > ./result_10chains/node340_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_7_1 -p 788 -st topic340_7_0 -pt topic340_7_1 -u 0.04445938325895605 > ./result_10chains/node340_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_8_1 -p 803 -st topic340_8_0 -pt topic340_8_1 -u 0.01774520940856683 > ./result_10chains/node340_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_9_1 -p 855 -st topic340_9_0 -pt topic340_9_1 -u 0.004437780818864382 > ./result_10chains/node340_9_1.txt &
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
    "./result_10chains/node340_0_1.txt 90"
    "./result_10chains/node340_1_1.txt 89"
    "./result_10chains/node340_2_1.txt 88"
    "./result_10chains/node340_3_1.txt 87"
    "./result_10chains/node340_4_1.txt 86"
    "./result_10chains/node340_5_1.txt 85"
    "./result_10chains/node340_6_1.txt 84"
    "./result_10chains/node340_7_1.txt 83"
    "./result_10chains/node340_8_1.txt 82"
    "./result_10chains/node340_9_1.txt 81"
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

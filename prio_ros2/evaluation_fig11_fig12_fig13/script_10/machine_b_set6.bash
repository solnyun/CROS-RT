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
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_1 -p 455 -st topic6_0_0 -pt topic6_0_1 -u 0.0020593171391003473 > ./result_10chains/node6_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_1 -p 508 -st topic6_1_0 -pt topic6_1_1 -u 0.019802125082564737 > ./result_10chains/node6_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_1 -p 622 -st topic6_2_0 -pt topic6_2_1 -u 0.07117994548878437 > ./result_10chains/node6_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_1 -p 673 -st topic6_3_0 -pt topic6_3_1 -u 0.03883722614812718 > ./result_10chains/node6_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_1 -p 678 -st topic6_4_0 -pt topic6_4_1 -u 0.012739721197172538 > ./result_10chains/node6_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_1 -p 715 -st topic6_5_0 -pt topic6_5_1 -u 0.03796497492803458 > ./result_10chains/node6_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_6_1 -p 734 -st topic6_6_0 -pt topic6_6_1 -u 0.009572239474822664 > ./result_10chains/node6_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_7_1 -p 741 -st topic6_7_0 -pt topic6_7_1 -u 0.03231708480491964 > ./result_10chains/node6_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_8_1 -p 924 -st topic6_8_0 -pt topic6_8_1 -u 0.010500460661213292 > ./result_10chains/node6_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node6_9_1 -p 956 -st topic6_9_0 -pt topic6_9_1 -u 0.003113468676373213 > ./result_10chains/node6_9_1.txt &
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
    "./result_10chains/node6_0_1.txt 90"
    "./result_10chains/node6_1_1.txt 89"
    "./result_10chains/node6_2_1.txt 88"
    "./result_10chains/node6_3_1.txt 87"
    "./result_10chains/node6_4_1.txt 86"
    "./result_10chains/node6_5_1.txt 85"
    "./result_10chains/node6_6_1.txt 84"
    "./result_10chains/node6_7_1.txt 83"
    "./result_10chains/node6_8_1.txt 82"
    "./result_10chains/node6_9_1.txt 81"
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

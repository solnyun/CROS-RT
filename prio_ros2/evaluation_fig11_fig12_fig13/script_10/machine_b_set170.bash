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
ros2 run evaluation_3_randomdag uunifast_node -n node170_0_1 -p 58 -st topic170_0_0 -pt topic170_0_1 -u 0.011869720349123647 > ./result_10chains/node170_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_1_1 -p 295 -st topic170_1_0 -pt topic170_1_1 -u 0.023274786809379 > ./result_10chains/node170_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_2_1 -p 344 -st topic170_2_0 -pt topic170_2_1 -u 0.018780785196416905 > ./result_10chains/node170_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_3_1 -p 424 -st topic170_3_0 -pt topic170_3_1 -u 0.014316395666421233 > ./result_10chains/node170_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_4_1 -p 436 -st topic170_4_0 -pt topic170_4_1 -u 0.01533183615732292 > ./result_10chains/node170_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_5_1 -p 569 -st topic170_5_0 -pt topic170_5_1 -u 0.002485842649652903 > ./result_10chains/node170_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_6_1 -p 699 -st topic170_6_0 -pt topic170_6_1 -u 0.02369868115918103 > ./result_10chains/node170_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_7_1 -p 774 -st topic170_7_0 -pt topic170_7_1 -u 0.014214874908922925 > ./result_10chains/node170_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_8_1 -p 821 -st topic170_8_0 -pt topic170_8_1 -u 0.008325076672432742 > ./result_10chains/node170_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node170_9_1 -p 995 -st topic170_9_0 -pt topic170_9_1 -u 0.00693633083601871 > ./result_10chains/node170_9_1.txt &
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
    "./result_10chains/node170_0_1.txt 90"
    "./result_10chains/node170_1_1.txt 89"
    "./result_10chains/node170_2_1.txt 88"
    "./result_10chains/node170_3_1.txt 87"
    "./result_10chains/node170_4_1.txt 86"
    "./result_10chains/node170_5_1.txt 85"
    "./result_10chains/node170_6_1.txt 84"
    "./result_10chains/node170_7_1.txt 83"
    "./result_10chains/node170_8_1.txt 82"
    "./result_10chains/node170_9_1.txt 81"
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

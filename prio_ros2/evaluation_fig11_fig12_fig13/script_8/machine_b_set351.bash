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
ros2 run evaluation_3_randomdag uunifast_node -n node351_0_1 -p 53 -st topic351_0_0 -pt topic351_0_1 -u 0.0017737889481124203 > ./result_8chains/node351_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_1_1 -p 165 -st topic351_1_0 -pt topic351_1_1 -u 0.010123752681566567 > ./result_8chains/node351_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_2_1 -p 196 -st topic351_2_0 -pt topic351_2_1 -u 0.006667388905792826 > ./result_8chains/node351_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_3_1 -p 211 -st topic351_3_0 -pt topic351_3_1 -u 0.0029666417281150603 > ./result_8chains/node351_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_4_1 -p 282 -st topic351_4_0 -pt topic351_4_1 -u 0.0008964331983760676 > ./result_8chains/node351_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_5_1 -p 312 -st topic351_5_0 -pt topic351_5_1 -u 0.004205059399921579 > ./result_8chains/node351_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_6_1 -p 656 -st topic351_6_0 -pt topic351_6_1 -u 0.05427354551419716 > ./result_8chains/node351_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_7_1 -p 906 -st topic351_7_0 -pt topic351_7_1 -u 0.04654617188937758 > ./result_8chains/node351_7_1.txt &
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
    "./result_8chains/node351_0_1.txt 90"
    "./result_8chains/node351_1_1.txt 89"
    "./result_8chains/node351_2_1.txt 88"
    "./result_8chains/node351_3_1.txt 87"
    "./result_8chains/node351_4_1.txt 86"
    "./result_8chains/node351_5_1.txt 85"
    "./result_8chains/node351_6_1.txt 84"
    "./result_8chains/node351_7_1.txt 83"
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

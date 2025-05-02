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
ros2 run evaluation_3_randomdag uunifast_node -n node1_0_1 -p 116 -st topic1_0_0 -pt topic1_0_1 -u 0.016391724999505863 > ./result_10chains/node1_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_1_1 -p 219 -st topic1_1_0 -pt topic1_1_1 -u 0.006267086430246038 > ./result_10chains/node1_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_2_1 -p 387 -st topic1_2_0 -pt topic1_2_1 -u 0.00228380210747936 > ./result_10chains/node1_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_3_1 -p 398 -st topic1_3_0 -pt topic1_3_1 -u 0.009800444228125704 > ./result_10chains/node1_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_4_1 -p 454 -st topic1_4_0 -pt topic1_4_1 -u 0.038703284890367784 > ./result_10chains/node1_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_5_1 -p 495 -st topic1_5_0 -pt topic1_5_1 -u 0.02605377025943653 > ./result_10chains/node1_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_6_1 -p 738 -st topic1_6_0 -pt topic1_6_1 -u 0.002699992244423355 > ./result_10chains/node1_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_7_1 -p 838 -st topic1_7_0 -pt topic1_7_1 -u 0.02361200038849011 > ./result_10chains/node1_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_8_1 -p 855 -st topic1_8_0 -pt topic1_8_1 -u 0.0063393635186276415 > ./result_10chains/node1_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node1_9_1 -p 979 -st topic1_9_0 -pt topic1_9_1 -u 0.0013856987011907212 > ./result_10chains/node1_9_1.txt &
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
    "./result_10chains/node1_0_1.txt 90"
    "./result_10chains/node1_1_1.txt 89"
    "./result_10chains/node1_2_1.txt 88"
    "./result_10chains/node1_3_1.txt 87"
    "./result_10chains/node1_4_1.txt 86"
    "./result_10chains/node1_5_1.txt 85"
    "./result_10chains/node1_6_1.txt 84"
    "./result_10chains/node1_7_1.txt 83"
    "./result_10chains/node1_8_1.txt 82"
    "./result_10chains/node1_9_1.txt 81"
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

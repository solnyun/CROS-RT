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
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_1 -p 239 -st topic311_0_0 -pt topic311_0_1 -u 0.0032155306324535005 > ./result_8chains/node311_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_1 -p 406 -st topic311_1_0 -pt topic311_1_1 -u 0.004436053425066089 > ./result_8chains/node311_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_1 -p 435 -st topic311_2_0 -pt topic311_2_1 -u 0.01744667693153379 > ./result_8chains/node311_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_1 -p 442 -st topic311_3_0 -pt topic311_3_1 -u 0.0121252555923545 > ./result_8chains/node311_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_4_1 -p 577 -st topic311_4_0 -pt topic311_4_1 -u 0.00820205557032011 > ./result_8chains/node311_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_5_1 -p 660 -st topic311_5_0 -pt topic311_5_1 -u 0.04144511307181084 > ./result_8chains/node311_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_6_1 -p 770 -st topic311_6_0 -pt topic311_6_1 -u 0.03247166447762799 > ./result_8chains/node311_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_7_1 -p 954 -st topic311_7_0 -pt topic311_7_1 -u 0.08697143575716593 > ./result_8chains/node311_7_1.txt &
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
    "./result_8chains/node311_0_1.txt 90"
    "./result_8chains/node311_1_1.txt 89"
    "./result_8chains/node311_2_1.txt 88"
    "./result_8chains/node311_3_1.txt 87"
    "./result_8chains/node311_4_1.txt 86"
    "./result_8chains/node311_5_1.txt 85"
    "./result_8chains/node311_6_1.txt 84"
    "./result_8chains/node311_7_1.txt 83"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_1 -p 297 -st topic378_0_0 -pt topic378_0_1 -u 0.03623989772463193 > ./result_10chains/node378_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_1 -p 326 -st topic378_1_0 -pt topic378_1_1 -u 0.004861988390753413 > ./result_10chains/node378_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_1 -p 498 -st topic378_2_0 -pt topic378_2_1 -u 0.06298255167095185 > ./result_10chains/node378_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_1 -p 640 -st topic378_3_0 -pt topic378_3_1 -u 0.004490448599896779 > ./result_10chains/node378_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_1 -p 666 -st topic378_4_0 -pt topic378_4_1 -u 0.016639835949017162 > ./result_10chains/node378_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_1 -p 677 -st topic378_5_0 -pt topic378_5_1 -u 0.018194408927099337 > ./result_10chains/node378_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_6_1 -p 781 -st topic378_6_0 -pt topic378_6_1 -u 0.05236843399130012 > ./result_10chains/node378_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_7_1 -p 789 -st topic378_7_0 -pt topic378_7_1 -u 0.015404833809494582 > ./result_10chains/node378_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_8_1 -p 862 -st topic378_8_0 -pt topic378_8_1 -u 0.0013596941360851933 > ./result_10chains/node378_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_9_1 -p 864 -st topic378_9_0 -pt topic378_9_1 -u 0.004008685416301895 > ./result_10chains/node378_9_1.txt &
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
    "./result_10chains/node378_0_1.txt 90"
    "./result_10chains/node378_1_1.txt 89"
    "./result_10chains/node378_2_1.txt 88"
    "./result_10chains/node378_3_1.txt 87"
    "./result_10chains/node378_4_1.txt 86"
    "./result_10chains/node378_5_1.txt 85"
    "./result_10chains/node378_6_1.txt 84"
    "./result_10chains/node378_7_1.txt 83"
    "./result_10chains/node378_8_1.txt 82"
    "./result_10chains/node378_9_1.txt 81"
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

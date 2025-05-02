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
ros2 run evaluation_3_randomdag uunifast_node -n node114_0_1 -p 245 -st topic114_0_0 -pt topic114_0_1 -u 0.011987711260181222 > ./result_8chains/node114_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_1_1 -p 292 -st topic114_1_0 -pt topic114_1_1 -u 0.010544701599657424 > ./result_8chains/node114_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_2_1 -p 393 -st topic114_2_0 -pt topic114_2_1 -u 0.034161549434263916 > ./result_8chains/node114_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_3_1 -p 531 -st topic114_3_0 -pt topic114_3_1 -u 0.024196917480875824 > ./result_8chains/node114_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_4_1 -p 551 -st topic114_4_0 -pt topic114_4_1 -u 0.04589943371392963 > ./result_8chains/node114_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_5_1 -p 671 -st topic114_5_0 -pt topic114_5_1 -u 0.042753024018749156 > ./result_8chains/node114_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_6_1 -p 797 -st topic114_6_0 -pt topic114_6_1 -u 0.01503529927427872 > ./result_8chains/node114_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node114_7_1 -p 936 -st topic114_7_0 -pt topic114_7_1 -u 0.0025548173753059 > ./result_8chains/node114_7_1.txt &
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
    "./result_8chains/node114_0_1.txt 90"
    "./result_8chains/node114_1_1.txt 89"
    "./result_8chains/node114_2_1.txt 88"
    "./result_8chains/node114_3_1.txt 87"
    "./result_8chains/node114_4_1.txt 86"
    "./result_8chains/node114_5_1.txt 85"
    "./result_8chains/node114_6_1.txt 84"
    "./result_8chains/node114_7_1.txt 83"
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

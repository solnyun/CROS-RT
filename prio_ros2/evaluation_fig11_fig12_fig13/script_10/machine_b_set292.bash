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
ros2 run evaluation_3_randomdag uunifast_node -n node292_0_1 -p 49 -st topic292_0_0 -pt topic292_0_1 -u 0.026232172572277224 > ./result_10chains/node292_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_1_1 -p 85 -st topic292_1_0 -pt topic292_1_1 -u 0.002761348010707765 > ./result_10chains/node292_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_2_1 -p 208 -st topic292_2_0 -pt topic292_2_1 -u 0.0036761963686045562 > ./result_10chains/node292_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_3_1 -p 210 -st topic292_3_0 -pt topic292_3_1 -u 0.03112985200146573 > ./result_10chains/node292_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_4_1 -p 365 -st topic292_4_0 -pt topic292_4_1 -u 0.027953918398676558 > ./result_10chains/node292_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_5_1 -p 708 -st topic292_5_0 -pt topic292_5_1 -u 0.004545822165003599 > ./result_10chains/node292_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_6_1 -p 728 -st topic292_6_0 -pt topic292_6_1 -u 0.03950399932045873 > ./result_10chains/node292_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_7_1 -p 779 -st topic292_7_0 -pt topic292_7_1 -u 0.012796334095864587 > ./result_10chains/node292_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_8_1 -p 792 -st topic292_8_0 -pt topic292_8_1 -u 0.0048400369139900735 > ./result_10chains/node292_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node292_9_1 -p 867 -st topic292_9_0 -pt topic292_9_1 -u 0.005202830645034301 > ./result_10chains/node292_9_1.txt &
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
    "./result_10chains/node292_0_1.txt 90"
    "./result_10chains/node292_1_1.txt 89"
    "./result_10chains/node292_2_1.txt 88"
    "./result_10chains/node292_3_1.txt 87"
    "./result_10chains/node292_4_1.txt 86"
    "./result_10chains/node292_5_1.txt 85"
    "./result_10chains/node292_6_1.txt 84"
    "./result_10chains/node292_7_1.txt 83"
    "./result_10chains/node292_8_1.txt 82"
    "./result_10chains/node292_9_1.txt 81"
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

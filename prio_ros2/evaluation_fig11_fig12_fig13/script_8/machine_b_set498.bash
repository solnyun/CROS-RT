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
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_1 -p 68 -st topic498_0_0 -pt topic498_0_1 -u 0.030094199163181234 > ./result_8chains/node498_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_1 -p 184 -st topic498_1_0 -pt topic498_1_1 -u 0.00851470262837728 > ./result_8chains/node498_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_1 -p 324 -st topic498_2_0 -pt topic498_2_1 -u 0.012042681883404405 > ./result_8chains/node498_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_1 -p 579 -st topic498_3_0 -pt topic498_3_1 -u 0.021187299486355032 > ./result_8chains/node498_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_1 -p 689 -st topic498_4_0 -pt topic498_4_1 -u 0.00746591807110486 > ./result_8chains/node498_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_1 -p 729 -st topic498_5_0 -pt topic498_5_1 -u 0.038811545255865096 > ./result_8chains/node498_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_6_1 -p 761 -st topic498_6_0 -pt topic498_6_1 -u 0.016169960001340453 > ./result_8chains/node498_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_7_1 -p 914 -st topic498_7_0 -pt topic498_7_1 -u 0.008521758664124798 > ./result_8chains/node498_7_1.txt &
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
    "./result_8chains/node498_0_1.txt 90"
    "./result_8chains/node498_1_1.txt 89"
    "./result_8chains/node498_2_1.txt 88"
    "./result_8chains/node498_3_1.txt 87"
    "./result_8chains/node498_4_1.txt 86"
    "./result_8chains/node498_5_1.txt 85"
    "./result_8chains/node498_6_1.txt 84"
    "./result_8chains/node498_7_1.txt 83"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node238_0_1 -p 36 -st topic238_0_0 -pt topic238_0_1 -u 0.027353150381895064 > ./result_8chains/node238_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_1_1 -p 266 -st topic238_1_0 -pt topic238_1_1 -u 0.014980897053266717 > ./result_8chains/node238_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_2_1 -p 496 -st topic238_2_0 -pt topic238_2_1 -u 0.034358114359877845 > ./result_8chains/node238_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_3_1 -p 531 -st topic238_3_0 -pt topic238_3_1 -u 0.008602392583028362 > ./result_8chains/node238_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_4_1 -p 586 -st topic238_4_0 -pt topic238_4_1 -u 0.0002896762989410273 > ./result_8chains/node238_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_5_1 -p 691 -st topic238_5_0 -pt topic238_5_1 -u 0.012728888374628794 > ./result_8chains/node238_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_6_1 -p 845 -st topic238_6_0 -pt topic238_6_1 -u 0.009970577149321827 > ./result_8chains/node238_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node238_7_1 -p 970 -st topic238_7_0 -pt topic238_7_1 -u 0.042917112874092014 > ./result_8chains/node238_7_1.txt &
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
    "./result_8chains/node238_0_1.txt 90"
    "./result_8chains/node238_1_1.txt 89"
    "./result_8chains/node238_2_1.txt 88"
    "./result_8chains/node238_3_1.txt 87"
    "./result_8chains/node238_4_1.txt 86"
    "./result_8chains/node238_5_1.txt 85"
    "./result_8chains/node238_6_1.txt 84"
    "./result_8chains/node238_7_1.txt 83"
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

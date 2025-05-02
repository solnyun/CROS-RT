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
ros2 run evaluation_3_randomdag uunifast_node -n node101_0_1 -p 21 -st topic101_0_0 -pt topic101_0_1 -u 0.013961598188843516 > ./result_8chains/node101_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_1_1 -p 86 -st topic101_1_0 -pt topic101_1_1 -u 0.004033925363227553 > ./result_8chains/node101_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_2_1 -p 132 -st topic101_2_0 -pt topic101_2_1 -u 0.0037898913312007787 > ./result_8chains/node101_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_3_1 -p 352 -st topic101_3_0 -pt topic101_3_1 -u 0.03665409152699173 > ./result_8chains/node101_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_4_1 -p 424 -st topic101_4_0 -pt topic101_4_1 -u 0.02876260980348208 > ./result_8chains/node101_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_5_1 -p 714 -st topic101_5_0 -pt topic101_5_1 -u 0.029795924887376507 > ./result_8chains/node101_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_6_1 -p 856 -st topic101_6_0 -pt topic101_6_1 -u 0.002937469106376517 > ./result_8chains/node101_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node101_7_1 -p 987 -st topic101_7_0 -pt topic101_7_1 -u 0.0011404768606446628 > ./result_8chains/node101_7_1.txt &
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
    "./result_8chains/node101_0_1.txt 90"
    "./result_8chains/node101_1_1.txt 89"
    "./result_8chains/node101_2_1.txt 88"
    "./result_8chains/node101_3_1.txt 87"
    "./result_8chains/node101_4_1.txt 86"
    "./result_8chains/node101_5_1.txt 85"
    "./result_8chains/node101_6_1.txt 84"
    "./result_8chains/node101_7_1.txt 83"
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

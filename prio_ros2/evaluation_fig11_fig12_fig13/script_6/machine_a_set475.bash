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
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_2 -p 98 -st topic475_0_1 -pt None -u 0.07060020273633238 > ./result_6chains/node475_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_2 -p 338 -st topic475_1_1 -pt None -u 0.05404232202955245 > ./result_6chains/node475_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_2 -p 464 -st topic475_2_1 -pt None -u 0.0033725247080376164 > ./result_6chains/node475_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_2 -p 580 -st topic475_3_1 -pt None -u 0.004709789547558435 > ./result_6chains/node475_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_2 -p 773 -st topic475_4_1 -pt None -u 0.0006880476548992986 > ./result_6chains/node475_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_2 -p 825 -st topic475_5_1 -pt None -u 0.006165742051575592 > ./result_6chains/node475_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_0_0 -p 98 -st none -pt topic475_0_0 -u 0.011404414639538674 > ./result_6chains/node475_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_1_0 -p 338 -st none -pt topic475_1_0 -u 0.000352463807672343 > ./result_6chains/node475_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_2_0 -p 464 -st none -pt topic475_2_0 -u 0.05959006705939893 > ./result_6chains/node475_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_3_0 -p 580 -st none -pt topic475_3_0 -u 0.026653599816869544 > ./result_6chains/node475_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node475_4_0 -p 773 -st none -pt topic475_4_0 -u 0.00467207333657832 > ./result_6chains/node475_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node475_5_0 -p 825 -st none -pt topic475_5_0 -u 0.013995225207165327 > ./result_6chains/node475_5_0.txt &
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
    "./result_6chains/node475_0_0.txt 90"
    "./result_6chains/node475_0_2.txt 90"
    "./result_6chains/node475_1_0.txt 89"
    "./result_6chains/node475_1_2.txt 89"
    "./result_6chains/node475_2_0.txt 88"
    "./result_6chains/node475_2_2.txt 88"
    "./result_6chains/node475_3_0.txt 87"
    "./result_6chains/node475_3_2.txt 87"
    "./result_6chains/node475_4_0.txt 86"
    "./result_6chains/node475_4_2.txt 86"
    "./result_6chains/node475_5_0.txt 85"
    "./result_6chains/node475_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

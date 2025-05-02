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
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_1 -p 16 -st topic452_0_0 -pt topic452_0_1 -u 0.007676071856801192 > ./result_10chains/node452_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_1 -p 39 -st topic452_1_0 -pt topic452_1_1 -u 0.007807618680703676 > ./result_10chains/node452_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_1 -p 49 -st topic452_2_0 -pt topic452_2_1 -u 0.0279135076951334 > ./result_10chains/node452_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_1 -p 78 -st topic452_3_0 -pt topic452_3_1 -u 0.019250426957951206 > ./result_10chains/node452_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_4_1 -p 267 -st topic452_4_0 -pt topic452_4_1 -u 0.0017893145559049195 > ./result_10chains/node452_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_5_1 -p 294 -st topic452_5_0 -pt topic452_5_1 -u 0.0007802331425168507 > ./result_10chains/node452_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_6_1 -p 359 -st topic452_6_0 -pt topic452_6_1 -u 0.06662487968236086 > ./result_10chains/node452_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_7_1 -p 746 -st topic452_7_0 -pt topic452_7_1 -u 0.013872416171938573 > ./result_10chains/node452_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_8_1 -p 910 -st topic452_8_0 -pt topic452_8_1 -u 0.005842504533014686 > ./result_10chains/node452_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_9_1 -p 984 -st topic452_9_0 -pt topic452_9_1 -u 0.02810983172766237 > ./result_10chains/node452_9_1.txt &
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
    "./result_10chains/node452_0_1.txt 90"
    "./result_10chains/node452_1_1.txt 89"
    "./result_10chains/node452_2_1.txt 88"
    "./result_10chains/node452_3_1.txt 87"
    "./result_10chains/node452_4_1.txt 86"
    "./result_10chains/node452_5_1.txt 85"
    "./result_10chains/node452_6_1.txt 84"
    "./result_10chains/node452_7_1.txt 83"
    "./result_10chains/node452_8_1.txt 82"
    "./result_10chains/node452_9_1.txt 81"
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

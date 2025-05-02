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
ros2 run evaluation_3_randomdag uunifast_node -n node88_0_1 -p 30 -st topic88_0_0 -pt topic88_0_1 -u 0.022278962965748994 > ./result_8chains/node88_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_1_1 -p 31 -st topic88_1_0 -pt topic88_1_1 -u 0.0029408227109928853 > ./result_8chains/node88_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_2_1 -p 333 -st topic88_2_0 -pt topic88_2_1 -u 0.008469199911877334 > ./result_8chains/node88_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_3_1 -p 473 -st topic88_3_0 -pt topic88_3_1 -u 0.008242877988945296 > ./result_8chains/node88_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_4_1 -p 566 -st topic88_4_0 -pt topic88_4_1 -u 0.008994658239458442 > ./result_8chains/node88_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_5_1 -p 630 -st topic88_5_0 -pt topic88_5_1 -u 0.011178556633216319 > ./result_8chains/node88_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_6_1 -p 696 -st topic88_6_0 -pt topic88_6_1 -u 0.006566418888042824 > ./result_8chains/node88_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_7_1 -p 741 -st topic88_7_0 -pt topic88_7_1 -u 0.007800175111555098 > ./result_8chains/node88_7_1.txt &
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
    "./result_8chains/node88_0_1.txt 90"
    "./result_8chains/node88_1_1.txt 89"
    "./result_8chains/node88_2_1.txt 88"
    "./result_8chains/node88_3_1.txt 87"
    "./result_8chains/node88_4_1.txt 86"
    "./result_8chains/node88_5_1.txt 85"
    "./result_8chains/node88_6_1.txt 84"
    "./result_8chains/node88_7_1.txt 83"
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

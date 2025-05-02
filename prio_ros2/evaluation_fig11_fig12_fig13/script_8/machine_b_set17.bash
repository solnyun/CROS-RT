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
ros2 run evaluation_3_randomdag uunifast_node -n node17_0_1 -p 300 -st topic17_0_0 -pt topic17_0_1 -u 0.024082585081338925 > ./result_8chains/node17_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_1_1 -p 351 -st topic17_1_0 -pt topic17_1_1 -u 0.010836696052998473 > ./result_8chains/node17_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_2_1 -p 480 -st topic17_2_0 -pt topic17_2_1 -u 0.013116423399315735 > ./result_8chains/node17_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_3_1 -p 579 -st topic17_3_0 -pt topic17_3_1 -u 0.0012442770305187145 > ./result_8chains/node17_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_4_1 -p 616 -st topic17_4_0 -pt topic17_4_1 -u 0.0037653552058591333 > ./result_8chains/node17_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_5_1 -p 651 -st topic17_5_0 -pt topic17_5_1 -u 0.04695679646491954 > ./result_8chains/node17_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_6_1 -p 948 -st topic17_6_0 -pt topic17_6_1 -u 0.019132705550143167 > ./result_8chains/node17_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node17_7_1 -p 950 -st topic17_7_0 -pt topic17_7_1 -u 0.03903557048680422 > ./result_8chains/node17_7_1.txt &
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
    "./result_8chains/node17_0_1.txt 90"
    "./result_8chains/node17_1_1.txt 89"
    "./result_8chains/node17_2_1.txt 88"
    "./result_8chains/node17_3_1.txt 87"
    "./result_8chains/node17_4_1.txt 86"
    "./result_8chains/node17_5_1.txt 85"
    "./result_8chains/node17_6_1.txt 84"
    "./result_8chains/node17_7_1.txt 83"
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

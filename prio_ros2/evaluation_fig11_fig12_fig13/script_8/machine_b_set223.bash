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
ros2 run evaluation_3_randomdag uunifast_node -n node223_0_1 -p 189 -st topic223_0_0 -pt topic223_0_1 -u 0.013417711776283758 > ./result_8chains/node223_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_1_1 -p 336 -st topic223_1_0 -pt topic223_1_1 -u 0.028420632980439453 > ./result_8chains/node223_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_2_1 -p 350 -st topic223_2_0 -pt topic223_2_1 -u 0.022640793573830587 > ./result_8chains/node223_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_3_1 -p 351 -st topic223_3_0 -pt topic223_3_1 -u 0.0010846605393590725 > ./result_8chains/node223_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_4_1 -p 689 -st topic223_4_0 -pt topic223_4_1 -u 0.017615646936116558 > ./result_8chains/node223_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_5_1 -p 819 -st topic223_5_0 -pt topic223_5_1 -u 0.018430266167483916 > ./result_8chains/node223_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_6_1 -p 922 -st topic223_6_0 -pt topic223_6_1 -u 0.04381777907421382 > ./result_8chains/node223_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node223_7_1 -p 986 -st topic223_7_0 -pt topic223_7_1 -u 0.03983087172686606 > ./result_8chains/node223_7_1.txt &
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
    "./result_8chains/node223_0_1.txt 90"
    "./result_8chains/node223_1_1.txt 89"
    "./result_8chains/node223_2_1.txt 88"
    "./result_8chains/node223_3_1.txt 87"
    "./result_8chains/node223_4_1.txt 86"
    "./result_8chains/node223_5_1.txt 85"
    "./result_8chains/node223_6_1.txt 84"
    "./result_8chains/node223_7_1.txt 83"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node119_0_1 -p 274 -st topic119_0_0 -pt topic119_0_1 -u 0.016777922923589428 > ./result_8chains/node119_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_1_1 -p 349 -st topic119_1_0 -pt topic119_1_1 -u 0.06955483318022071 > ./result_8chains/node119_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_2_1 -p 405 -st topic119_2_0 -pt topic119_2_1 -u 0.002106142904052144 > ./result_8chains/node119_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_3_1 -p 656 -st topic119_3_0 -pt topic119_3_1 -u 0.0010107562322934638 > ./result_8chains/node119_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_4_1 -p 672 -st topic119_4_0 -pt topic119_4_1 -u 0.016481383516583792 > ./result_8chains/node119_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_5_1 -p 725 -st topic119_5_0 -pt topic119_5_1 -u 0.04699111028816899 > ./result_8chains/node119_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_6_1 -p 764 -st topic119_6_0 -pt topic119_6_1 -u 0.014994006357927123 > ./result_8chains/node119_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node119_7_1 -p 785 -st topic119_7_0 -pt topic119_7_1 -u 0.0020769740613007523 > ./result_8chains/node119_7_1.txt &
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
    "./result_8chains/node119_0_1.txt 90"
    "./result_8chains/node119_1_1.txt 89"
    "./result_8chains/node119_2_1.txt 88"
    "./result_8chains/node119_3_1.txt 87"
    "./result_8chains/node119_4_1.txt 86"
    "./result_8chains/node119_5_1.txt 85"
    "./result_8chains/node119_6_1.txt 84"
    "./result_8chains/node119_7_1.txt 83"
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

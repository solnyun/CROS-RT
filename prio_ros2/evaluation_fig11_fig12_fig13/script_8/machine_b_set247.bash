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
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_1 -p 183 -st topic247_0_0 -pt topic247_0_1 -u 0.003001285941709786 > ./result_8chains/node247_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_1 -p 301 -st topic247_1_0 -pt topic247_1_1 -u 0.019926424607643822 > ./result_8chains/node247_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_1 -p 427 -st topic247_2_0 -pt topic247_2_1 -u 0.041956145186846705 > ./result_8chains/node247_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_1 -p 483 -st topic247_3_0 -pt topic247_3_1 -u 0.032556409686360144 > ./result_8chains/node247_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_1 -p 614 -st topic247_4_0 -pt topic247_4_1 -u 0.028614807363340933 > ./result_8chains/node247_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_1 -p 649 -st topic247_5_0 -pt topic247_5_1 -u 0.07156409334138404 > ./result_8chains/node247_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_6_1 -p 699 -st topic247_6_0 -pt topic247_6_1 -u 1.0202446906748541e-06 > ./result_8chains/node247_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_7_1 -p 965 -st topic247_7_0 -pt topic247_7_1 -u 0.01221174691186 > ./result_8chains/node247_7_1.txt &
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
    "./result_8chains/node247_0_1.txt 90"
    "./result_8chains/node247_1_1.txt 89"
    "./result_8chains/node247_2_1.txt 88"
    "./result_8chains/node247_3_1.txt 87"
    "./result_8chains/node247_4_1.txt 86"
    "./result_8chains/node247_5_1.txt 85"
    "./result_8chains/node247_6_1.txt 84"
    "./result_8chains/node247_7_1.txt 83"
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

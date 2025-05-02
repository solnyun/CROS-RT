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
ros2 run evaluation_3_randomdag uunifast_node -n node91_0_1 -p 87 -st topic91_0_0 -pt topic91_0_1 -u 0.005222727109720937 > ./result_10chains/node91_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_1_1 -p 288 -st topic91_1_0 -pt topic91_1_1 -u 0.028147057968379185 > ./result_10chains/node91_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_2_1 -p 642 -st topic91_2_0 -pt topic91_2_1 -u 0.0031651337446504946 > ./result_10chains/node91_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_3_1 -p 687 -st topic91_3_0 -pt topic91_3_1 -u 0.007609180164986906 > ./result_10chains/node91_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_4_1 -p 750 -st topic91_4_0 -pt topic91_4_1 -u 0.04730129875546485 > ./result_10chains/node91_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_5_1 -p 778 -st topic91_5_0 -pt topic91_5_1 -u 0.01702588574330252 > ./result_10chains/node91_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_6_1 -p 815 -st topic91_6_0 -pt topic91_6_1 -u 0.008265450267820607 > ./result_10chains/node91_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_7_1 -p 881 -st topic91_7_0 -pt topic91_7_1 -u 0.00014135600480844057 > ./result_10chains/node91_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_8_1 -p 957 -st topic91_8_0 -pt topic91_8_1 -u 0.046324718824342255 > ./result_10chains/node91_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node91_9_1 -p 994 -st topic91_9_0 -pt topic91_9_1 -u 0.002968016525278238 > ./result_10chains/node91_9_1.txt &
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
    "./result_10chains/node91_0_1.txt 90"
    "./result_10chains/node91_1_1.txt 89"
    "./result_10chains/node91_2_1.txt 88"
    "./result_10chains/node91_3_1.txt 87"
    "./result_10chains/node91_4_1.txt 86"
    "./result_10chains/node91_5_1.txt 85"
    "./result_10chains/node91_6_1.txt 84"
    "./result_10chains/node91_7_1.txt 83"
    "./result_10chains/node91_8_1.txt 82"
    "./result_10chains/node91_9_1.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node483_0_1 -p 14 -st topic483_0_0 -pt topic483_0_1 -u 0.02074557552570755 > ./result_10chains/node483_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_1_1 -p 39 -st topic483_1_0 -pt topic483_1_1 -u 0.05309520255090833 > ./result_10chains/node483_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_2_1 -p 64 -st topic483_2_0 -pt topic483_2_1 -u 0.0032824962049834983 > ./result_10chains/node483_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_3_1 -p 123 -st topic483_3_0 -pt topic483_3_1 -u 0.02649408180793894 > ./result_10chains/node483_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_4_1 -p 200 -st topic483_4_0 -pt topic483_4_1 -u 0.007332150582253616 > ./result_10chains/node483_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_5_1 -p 373 -st topic483_5_0 -pt topic483_5_1 -u 0.032383761182256804 > ./result_10chains/node483_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_6_1 -p 560 -st topic483_6_0 -pt topic483_6_1 -u 0.04833717811432918 > ./result_10chains/node483_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_7_1 -p 597 -st topic483_7_0 -pt topic483_7_1 -u 0.008963932986425276 > ./result_10chains/node483_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_8_1 -p 817 -st topic483_8_0 -pt topic483_8_1 -u 0.006316946006219959 > ./result_10chains/node483_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node483_9_1 -p 835 -st topic483_9_0 -pt topic483_9_1 -u 0.0015912032182531892 > ./result_10chains/node483_9_1.txt &
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
    "./result_10chains/node483_0_1.txt 90"
    "./result_10chains/node483_1_1.txt 89"
    "./result_10chains/node483_2_1.txt 88"
    "./result_10chains/node483_3_1.txt 87"
    "./result_10chains/node483_4_1.txt 86"
    "./result_10chains/node483_5_1.txt 85"
    "./result_10chains/node483_6_1.txt 84"
    "./result_10chains/node483_7_1.txt 83"
    "./result_10chains/node483_8_1.txt 82"
    "./result_10chains/node483_9_1.txt 81"
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

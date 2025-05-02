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
ros2 run evaluation_3_randomdag uunifast_node -n node441_0_1 -p 15 -st topic441_0_0 -pt topic441_0_1 -u 0.015584554022417596 > ./result_8chains/node441_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_1_1 -p 188 -st topic441_1_0 -pt topic441_1_1 -u 0.016285662505687137 > ./result_8chains/node441_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_2_1 -p 216 -st topic441_2_0 -pt topic441_2_1 -u 0.017048459930156246 > ./result_8chains/node441_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_3_1 -p 288 -st topic441_3_0 -pt topic441_3_1 -u 0.02342573503265183 > ./result_8chains/node441_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_4_1 -p 493 -st topic441_4_0 -pt topic441_4_1 -u 0.01586631357954149 > ./result_8chains/node441_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_5_1 -p 704 -st topic441_5_0 -pt topic441_5_1 -u 0.0007892533953148262 > ./result_8chains/node441_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_6_1 -p 837 -st topic441_6_0 -pt topic441_6_1 -u 0.02630955468883875 > ./result_8chains/node441_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node441_7_1 -p 942 -st topic441_7_0 -pt topic441_7_1 -u 0.02874266408948282 > ./result_8chains/node441_7_1.txt &
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
    "./result_8chains/node441_0_1.txt 90"
    "./result_8chains/node441_1_1.txt 89"
    "./result_8chains/node441_2_1.txt 88"
    "./result_8chains/node441_3_1.txt 87"
    "./result_8chains/node441_4_1.txt 86"
    "./result_8chains/node441_5_1.txt 85"
    "./result_8chains/node441_6_1.txt 84"
    "./result_8chains/node441_7_1.txt 83"
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

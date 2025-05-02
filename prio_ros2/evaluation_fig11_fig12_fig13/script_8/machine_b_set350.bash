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
ros2 run evaluation_3_randomdag uunifast_node -n node350_0_1 -p 362 -st topic350_0_0 -pt topic350_0_1 -u 0.026600950942271107 > ./result_8chains/node350_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_1_1 -p 416 -st topic350_1_0 -pt topic350_1_1 -u 0.06393706223420942 > ./result_8chains/node350_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_2_1 -p 463 -st topic350_2_0 -pt topic350_2_1 -u 0.018030666334510115 > ./result_8chains/node350_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_3_1 -p 491 -st topic350_3_0 -pt topic350_3_1 -u 0.0043887504409246825 > ./result_8chains/node350_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_4_1 -p 686 -st topic350_4_0 -pt topic350_4_1 -u 0.01956773569654119 > ./result_8chains/node350_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_5_1 -p 859 -st topic350_5_0 -pt topic350_5_1 -u 0.03302476637589685 > ./result_8chains/node350_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_6_1 -p 919 -st topic350_6_0 -pt topic350_6_1 -u 0.00016241981773501557 > ./result_8chains/node350_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node350_7_1 -p 984 -st topic350_7_0 -pt topic350_7_1 -u 0.008956674410123752 > ./result_8chains/node350_7_1.txt &
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
    "./result_8chains/node350_0_1.txt 90"
    "./result_8chains/node350_1_1.txt 89"
    "./result_8chains/node350_2_1.txt 88"
    "./result_8chains/node350_3_1.txt 87"
    "./result_8chains/node350_4_1.txt 86"
    "./result_8chains/node350_5_1.txt 85"
    "./result_8chains/node350_6_1.txt 84"
    "./result_8chains/node350_7_1.txt 83"
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

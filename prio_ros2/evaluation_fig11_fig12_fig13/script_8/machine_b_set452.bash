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
ros2 run evaluation_3_randomdag uunifast_node -n node452_0_1 -p 72 -st topic452_0_0 -pt topic452_0_1 -u 0.056497555687493595 > ./result_8chains/node452_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_1_1 -p 440 -st topic452_1_0 -pt topic452_1_1 -u 0.008348962228548862 > ./result_8chains/node452_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_2_1 -p 465 -st topic452_2_0 -pt topic452_2_1 -u 0.018164288844875087 > ./result_8chains/node452_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_3_1 -p 474 -st topic452_3_0 -pt topic452_3_1 -u 0.010702249456755297 > ./result_8chains/node452_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_4_1 -p 729 -st topic452_4_0 -pt topic452_4_1 -u 0.025998771995063924 > ./result_8chains/node452_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_5_1 -p 756 -st topic452_5_0 -pt topic452_5_1 -u 0.011278700277561282 > ./result_8chains/node452_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_6_1 -p 804 -st topic452_6_0 -pt topic452_6_1 -u 0.00672016183663883 > ./result_8chains/node452_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node452_7_1 -p 937 -st topic452_7_0 -pt topic452_7_1 -u 0.005538776758281187 > ./result_8chains/node452_7_1.txt &
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
    "./result_8chains/node452_0_1.txt 90"
    "./result_8chains/node452_1_1.txt 89"
    "./result_8chains/node452_2_1.txt 88"
    "./result_8chains/node452_3_1.txt 87"
    "./result_8chains/node452_4_1.txt 86"
    "./result_8chains/node452_5_1.txt 85"
    "./result_8chains/node452_6_1.txt 84"
    "./result_8chains/node452_7_1.txt 83"
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

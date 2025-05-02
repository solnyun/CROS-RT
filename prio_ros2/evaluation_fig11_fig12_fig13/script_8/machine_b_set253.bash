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
ros2 run evaluation_3_randomdag uunifast_node -n node253_0_1 -p 45 -st topic253_0_0 -pt topic253_0_1 -u 0.08175245578868423 > ./result_8chains/node253_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_1_1 -p 121 -st topic253_1_0 -pt topic253_1_1 -u 0.006982415922061502 > ./result_8chains/node253_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_2_1 -p 192 -st topic253_2_0 -pt topic253_2_1 -u 0.016432391044137018 > ./result_8chains/node253_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_3_1 -p 394 -st topic253_3_0 -pt topic253_3_1 -u 0.03799619960107675 > ./result_8chains/node253_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_4_1 -p 479 -st topic253_4_0 -pt topic253_4_1 -u 0.03972799267158966 > ./result_8chains/node253_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_5_1 -p 596 -st topic253_5_0 -pt topic253_5_1 -u 0.01945127895143932 > ./result_8chains/node253_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_6_1 -p 746 -st topic253_6_0 -pt topic253_6_1 -u 0.018135776049224686 > ./result_8chains/node253_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node253_7_1 -p 839 -st topic253_7_0 -pt topic253_7_1 -u 0.0021700701379300576 > ./result_8chains/node253_7_1.txt &
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
    "./result_8chains/node253_0_1.txt 90"
    "./result_8chains/node253_1_1.txt 89"
    "./result_8chains/node253_2_1.txt 88"
    "./result_8chains/node253_3_1.txt 87"
    "./result_8chains/node253_4_1.txt 86"
    "./result_8chains/node253_5_1.txt 85"
    "./result_8chains/node253_6_1.txt 84"
    "./result_8chains/node253_7_1.txt 83"
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

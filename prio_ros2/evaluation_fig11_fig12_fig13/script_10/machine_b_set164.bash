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
ros2 run evaluation_3_randomdag uunifast_node -n node164_0_1 -p 24 -st topic164_0_0 -pt topic164_0_1 -u 0.02332398898107846 > ./result_10chains/node164_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_1_1 -p 287 -st topic164_1_0 -pt topic164_1_1 -u 0.00826291262856943 > ./result_10chains/node164_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_2_1 -p 376 -st topic164_2_0 -pt topic164_2_1 -u 0.014415270210290432 > ./result_10chains/node164_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_3_1 -p 486 -st topic164_3_0 -pt topic164_3_1 -u 0.0021673472927529747 > ./result_10chains/node164_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_4_1 -p 615 -st topic164_4_0 -pt topic164_4_1 -u 0.011906160982373959 > ./result_10chains/node164_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_5_1 -p 616 -st topic164_5_0 -pt topic164_5_1 -u 0.008855815544099838 > ./result_10chains/node164_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_6_1 -p 754 -st topic164_6_0 -pt topic164_6_1 -u 0.03740281847709326 > ./result_10chains/node164_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_7_1 -p 803 -st topic164_7_0 -pt topic164_7_1 -u 0.01576348584779151 > ./result_10chains/node164_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_8_1 -p 854 -st topic164_8_0 -pt topic164_8_1 -u 0.0007672928866016802 > ./result_10chains/node164_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node164_9_1 -p 987 -st topic164_9_0 -pt topic164_9_1 -u 0.0042086878333124425 > ./result_10chains/node164_9_1.txt &
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
    "./result_10chains/node164_0_1.txt 90"
    "./result_10chains/node164_1_1.txt 89"
    "./result_10chains/node164_2_1.txt 88"
    "./result_10chains/node164_3_1.txt 87"
    "./result_10chains/node164_4_1.txt 86"
    "./result_10chains/node164_5_1.txt 85"
    "./result_10chains/node164_6_1.txt 84"
    "./result_10chains/node164_7_1.txt 83"
    "./result_10chains/node164_8_1.txt 82"
    "./result_10chains/node164_9_1.txt 81"
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

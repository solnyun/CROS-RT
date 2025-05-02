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
ros2 run evaluation_3_randomdag uunifast_node -n node225_0_1 -p 89 -st topic225_0_0 -pt topic225_0_1 -u 0.02123388190280684 > ./result_8chains/node225_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_1_1 -p 147 -st topic225_1_0 -pt topic225_1_1 -u 0.048677700352855735 > ./result_8chains/node225_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_2_1 -p 235 -st topic225_2_0 -pt topic225_2_1 -u 0.01633649722704167 > ./result_8chains/node225_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_3_1 -p 567 -st topic225_3_0 -pt topic225_3_1 -u 0.0007714000809885269 > ./result_8chains/node225_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_4_1 -p 635 -st topic225_4_0 -pt topic225_4_1 -u 0.02831044439279745 > ./result_8chains/node225_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_5_1 -p 663 -st topic225_5_0 -pt topic225_5_1 -u 0.028545862414833978 > ./result_8chains/node225_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_6_1 -p 837 -st topic225_6_0 -pt topic225_6_1 -u 0.03505935026973927 > ./result_8chains/node225_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node225_7_1 -p 844 -st topic225_7_0 -pt topic225_7_1 -u 0.013056243618593597 > ./result_8chains/node225_7_1.txt &
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
    "./result_8chains/node225_0_1.txt 90"
    "./result_8chains/node225_1_1.txt 89"
    "./result_8chains/node225_2_1.txt 88"
    "./result_8chains/node225_3_1.txt 87"
    "./result_8chains/node225_4_1.txt 86"
    "./result_8chains/node225_5_1.txt 85"
    "./result_8chains/node225_6_1.txt 84"
    "./result_8chains/node225_7_1.txt 83"
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

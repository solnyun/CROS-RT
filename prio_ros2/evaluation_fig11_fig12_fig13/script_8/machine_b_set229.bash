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
ros2 run evaluation_3_randomdag uunifast_node -n node229_0_1 -p 26 -st topic229_0_0 -pt topic229_0_1 -u 0.0035807989864503065 > ./result_8chains/node229_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_1_1 -p 99 -st topic229_1_0 -pt topic229_1_1 -u 0.02465703286745491 > ./result_8chains/node229_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_2_1 -p 322 -st topic229_2_0 -pt topic229_2_1 -u 0.0016455991766243239 > ./result_8chains/node229_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_3_1 -p 440 -st topic229_3_0 -pt topic229_3_1 -u 0.011211396249596828 > ./result_8chains/node229_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_4_1 -p 538 -st topic229_4_0 -pt topic229_4_1 -u 0.04438164293620794 > ./result_8chains/node229_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_5_1 -p 549 -st topic229_5_0 -pt topic229_5_1 -u 0.019215172909821693 > ./result_8chains/node229_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_6_1 -p 666 -st topic229_6_0 -pt topic229_6_1 -u 0.07832077169790312 > ./result_8chains/node229_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node229_7_1 -p 985 -st topic229_7_0 -pt topic229_7_1 -u 0.015297599347802707 > ./result_8chains/node229_7_1.txt &
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
    "./result_8chains/node229_0_1.txt 90"
    "./result_8chains/node229_1_1.txt 89"
    "./result_8chains/node229_2_1.txt 88"
    "./result_8chains/node229_3_1.txt 87"
    "./result_8chains/node229_4_1.txt 86"
    "./result_8chains/node229_5_1.txt 85"
    "./result_8chains/node229_6_1.txt 84"
    "./result_8chains/node229_7_1.txt 83"
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

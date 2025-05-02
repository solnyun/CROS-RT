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
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_2 -p 150 -st topic276_0_1 -pt None -u 0.0007175720549854603 > ./result_6chains/node276_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_2 -p 192 -st topic276_1_1 -pt None -u 0.009723147353301431 > ./result_6chains/node276_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_2 -p 230 -st topic276_2_1 -pt None -u 0.002199202079509577 > ./result_6chains/node276_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_2 -p 606 -st topic276_3_1 -pt None -u 0.10483239642838035 > ./result_6chains/node276_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_2 -p 699 -st topic276_4_1 -pt None -u 0.023895129122961833 > ./result_6chains/node276_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_2 -p 944 -st topic276_5_1 -pt None -u 0.004584701581070859 > ./result_6chains/node276_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_0_0 -p 150 -st none -pt topic276_0_0 -u 0.015394358364168581 > ./result_6chains/node276_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_1_0 -p 192 -st none -pt topic276_1_0 -u 0.04532825974335647 > ./result_6chains/node276_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_2_0 -p 230 -st none -pt topic276_2_0 -u 0.040775168794333905 > ./result_6chains/node276_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_3_0 -p 606 -st none -pt topic276_3_0 -u 0.036005148277484134 > ./result_6chains/node276_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node276_4_0 -p 699 -st none -pt topic276_4_0 -u 0.07382689887830154 > ./result_6chains/node276_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node276_5_0 -p 944 -st none -pt topic276_5_0 -u 2.2029563251133033e-05 > ./result_6chains/node276_5_0.txt &
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
    "./result_6chains/node276_0_0.txt 90"
    "./result_6chains/node276_0_2.txt 90"
    "./result_6chains/node276_1_0.txt 89"
    "./result_6chains/node276_1_2.txt 89"
    "./result_6chains/node276_2_0.txt 88"
    "./result_6chains/node276_2_2.txt 88"
    "./result_6chains/node276_3_0.txt 87"
    "./result_6chains/node276_3_2.txt 87"
    "./result_6chains/node276_4_0.txt 86"
    "./result_6chains/node276_4_2.txt 86"
    "./result_6chains/node276_5_0.txt 85"
    "./result_6chains/node276_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

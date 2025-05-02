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
ros2 run evaluation_3_randomdag uunifast_node -n node167_0_1 -p 101 -st topic167_0_0 -pt topic167_0_1 -u 0.014719492986484561 > ./result_8chains/node167_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_1_1 -p 246 -st topic167_1_0 -pt topic167_1_1 -u 0.0060793699835729464 > ./result_8chains/node167_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_2_1 -p 360 -st topic167_2_0 -pt topic167_2_1 -u 0.003753680810383686 > ./result_8chains/node167_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_3_1 -p 426 -st topic167_3_0 -pt topic167_3_1 -u 0.007701882889897593 > ./result_8chains/node167_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_4_1 -p 771 -st topic167_4_0 -pt topic167_4_1 -u 0.012616326006531897 > ./result_8chains/node167_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_5_1 -p 908 -st topic167_5_0 -pt topic167_5_1 -u 0.019927509902059937 > ./result_8chains/node167_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_6_1 -p 911 -st topic167_6_0 -pt topic167_6_1 -u 0.0895746329284144 > ./result_8chains/node167_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node167_7_1 -p 957 -st topic167_7_0 -pt topic167_7_1 -u 0.03475039577667021 > ./result_8chains/node167_7_1.txt &
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
    "./result_8chains/node167_0_1.txt 90"
    "./result_8chains/node167_1_1.txt 89"
    "./result_8chains/node167_2_1.txt 88"
    "./result_8chains/node167_3_1.txt 87"
    "./result_8chains/node167_4_1.txt 86"
    "./result_8chains/node167_5_1.txt 85"
    "./result_8chains/node167_6_1.txt 84"
    "./result_8chains/node167_7_1.txt 83"
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

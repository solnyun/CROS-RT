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
ros2 run evaluation_3_randomdag uunifast_node -n node447_0_2 -p 38 -st topic447_0_1 -pt None -u 0.04705572996879487 > ./result_6chains/node447_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_1_2 -p 122 -st topic447_1_1 -pt None -u 0.00970120552790793 > ./result_6chains/node447_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_2_2 -p 577 -st topic447_2_1 -pt None -u 0.04114214594230131 > ./result_6chains/node447_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_3_2 -p 678 -st topic447_3_1 -pt None -u 0.10006818925858758 > ./result_6chains/node447_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_4_2 -p 870 -st topic447_4_1 -pt None -u 0.016239274172316534 > ./result_6chains/node447_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_5_2 -p 989 -st topic447_5_1 -pt None -u 0.01226654797127119 > ./result_6chains/node447_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_0_0 -p 38 -st none -pt topic447_0_0 -u 0.039211443370149646 > ./result_6chains/node447_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_1_0 -p 122 -st none -pt topic447_1_0 -u 0.03782639238200547 > ./result_6chains/node447_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_2_0 -p 577 -st none -pt topic447_2_0 -u 0.026253318443532347 > ./result_6chains/node447_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_3_0 -p 678 -st none -pt topic447_3_0 -u 0.00466066868470702 > ./result_6chains/node447_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node447_4_0 -p 870 -st none -pt topic447_4_0 -u 0.01717903593622626 > ./result_6chains/node447_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node447_5_0 -p 989 -st none -pt topic447_5_0 -u 0.03315531129160659 > ./result_6chains/node447_5_0.txt &
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
    "./result_6chains/node447_0_0.txt 90"
    "./result_6chains/node447_0_2.txt 90"
    "./result_6chains/node447_1_0.txt 89"
    "./result_6chains/node447_1_2.txt 89"
    "./result_6chains/node447_2_0.txt 88"
    "./result_6chains/node447_2_2.txt 88"
    "./result_6chains/node447_3_0.txt 87"
    "./result_6chains/node447_3_2.txt 87"
    "./result_6chains/node447_4_0.txt 86"
    "./result_6chains/node447_4_2.txt 86"
    "./result_6chains/node447_5_0.txt 85"
    "./result_6chains/node447_5_2.txt 85"
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

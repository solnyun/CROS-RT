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
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_1 -p 104 -st topic277_0_0 -pt topic277_0_1 -u 0.019417896173319904 > ./result_6chains/node277_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_1 -p 146 -st topic277_1_0 -pt topic277_1_1 -u 0.03466504476527155 > ./result_6chains/node277_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_1 -p 414 -st topic277_2_0 -pt topic277_2_1 -u 0.03505859033680625 > ./result_6chains/node277_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_1 -p 600 -st topic277_3_0 -pt topic277_3_1 -u 0.06789032903709127 > ./result_6chains/node277_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_1 -p 918 -st topic277_4_0 -pt topic277_4_1 -u 0.027083628029585624 > ./result_6chains/node277_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_1 -p 953 -st topic277_5_0 -pt topic277_5_1 -u 0.02298365435528534 > ./result_6chains/node277_5_1.txt &
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
    "./result_6chains/node277_0_1.txt 90"
    "./result_6chains/node277_1_1.txt 89"
    "./result_6chains/node277_2_1.txt 88"
    "./result_6chains/node277_3_1.txt 87"
    "./result_6chains/node277_4_1.txt 86"
    "./result_6chains/node277_5_1.txt 85"
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

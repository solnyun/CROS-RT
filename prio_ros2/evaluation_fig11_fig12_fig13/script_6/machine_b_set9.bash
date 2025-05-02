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
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_1 -p 48 -st topic9_0_0 -pt topic9_0_1 -u 0.022316605017373647 > ./result_6chains/node9_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_1 -p 338 -st topic9_1_0 -pt topic9_1_1 -u 0.0017972284823849216 > ./result_6chains/node9_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_1 -p 393 -st topic9_2_0 -pt topic9_2_1 -u 0.02850299894235403 > ./result_6chains/node9_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_1 -p 461 -st topic9_3_0 -pt topic9_3_1 -u 0.013843389921276206 > ./result_6chains/node9_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_1 -p 823 -st topic9_4_0 -pt topic9_4_1 -u 0.03241386745605592 > ./result_6chains/node9_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_1 -p 961 -st topic9_5_0 -pt topic9_5_1 -u 0.006555257279387857 > ./result_6chains/node9_5_1.txt &
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
    "./result_6chains/node9_0_1.txt 90"
    "./result_6chains/node9_1_1.txt 89"
    "./result_6chains/node9_2_1.txt 88"
    "./result_6chains/node9_3_1.txt 87"
    "./result_6chains/node9_4_1.txt 86"
    "./result_6chains/node9_5_1.txt 85"
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

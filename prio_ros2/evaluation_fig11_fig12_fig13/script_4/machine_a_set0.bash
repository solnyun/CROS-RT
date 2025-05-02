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
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_2 -p 248 -st topic0_0_1 -pt None -u 0.03831499834838825 > ./result_4chains/node0_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_2 -p 262 -st topic0_1_1 -pt None -u 0.026683542646242897 > ./result_4chains/node0_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_2 -p 284 -st topic0_2_1 -pt None -u 0.06708815590891211 > ./result_4chains/node0_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_2 -p 810 -st topic0_3_1 -pt None -u 0.0187131419429956 > ./result_4chains/node0_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_0_0 -p 248 -st none -pt topic0_0_0 -u 0.005399137434257795 > ./result_4chains/node0_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_1_0 -p 262 -st none -pt topic0_1_0 -u 0.07196884612093585 > ./result_4chains/node0_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node0_2_0 -p 284 -st none -pt topic0_2_0 -u 0.033332302521367846 > ./result_4chains/node0_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node0_3_0 -p 810 -st none -pt topic0_3_0 -u 0.09038313900920704 > ./result_4chains/node0_3_0.txt &
sleep 10
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
    "./result_4chains/node0_0_0.txt 90"
    "./result_4chains/node0_0_2.txt 90"
    "./result_4chains/node0_1_0.txt 89"
    "./result_4chains/node0_1_2.txt 89"
    "./result_4chains/node0_2_0.txt 88"
    "./result_4chains/node0_2_2.txt 88"
    "./result_4chains/node0_3_0.txt 87"
    "./result_4chains/node0_3_2.txt 87"
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
sleep 70s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 40s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

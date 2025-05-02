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
ros2 run evaluation_3_randomdag uunifast_node -n node140_0_2 -p 85 -st topic140_0_1 -pt None -u 0.013375483584393222 > ./result_6chains/node140_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_1_2 -p 124 -st topic140_1_1 -pt None -u 0.02896565996637751 > ./result_6chains/node140_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_2_2 -p 815 -st topic140_2_1 -pt None -u 0.002460752862662674 > ./result_6chains/node140_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_3_2 -p 837 -st topic140_3_1 -pt None -u 0.03995255779242002 > ./result_6chains/node140_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_4_2 -p 842 -st topic140_4_1 -pt None -u 0.06153468889989677 > ./result_6chains/node140_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_5_2 -p 978 -st topic140_5_1 -pt None -u 0.030571249395533524 > ./result_6chains/node140_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_0_0 -p 85 -st none -pt topic140_0_0 -u 0.007970825644167234 > ./result_6chains/node140_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_1_0 -p 124 -st none -pt topic140_1_0 -u 0.03211127239903161 > ./result_6chains/node140_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_2_0 -p 815 -st none -pt topic140_2_0 -u 0.010150671101270381 > ./result_6chains/node140_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_3_0 -p 837 -st none -pt topic140_3_0 -u 0.002961288806621276 > ./result_6chains/node140_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_4_0 -p 842 -st none -pt topic140_4_0 -u 0.011950381691946732 > ./result_6chains/node140_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_5_0 -p 978 -st none -pt topic140_5_0 -u 0.04759152769689849 > ./result_6chains/node140_5_0.txt &
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
    "./result_6chains/node140_0_0.txt 90"
    "./result_6chains/node140_0_2.txt 90"
    "./result_6chains/node140_1_0.txt 89"
    "./result_6chains/node140_1_2.txt 89"
    "./result_6chains/node140_2_0.txt 88"
    "./result_6chains/node140_2_2.txt 88"
    "./result_6chains/node140_3_0.txt 87"
    "./result_6chains/node140_3_2.txt 87"
    "./result_6chains/node140_4_0.txt 86"
    "./result_6chains/node140_4_2.txt 86"
    "./result_6chains/node140_5_0.txt 85"
    "./result_6chains/node140_5_2.txt 85"
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

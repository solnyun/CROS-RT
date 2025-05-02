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
ros2 run evaluation_3_randomdag uunifast_node -n node352_0_2 -p 200 -st topic352_0_1 -pt None -u 0.02186177458271832 > ./result_6chains/node352_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_1_2 -p 441 -st topic352_1_1 -pt None -u 0.0026438650694852184 > ./result_6chains/node352_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_2_2 -p 466 -st topic352_2_1 -pt None -u 0.00634560463549938 > ./result_6chains/node352_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_3_2 -p 581 -st topic352_3_1 -pt None -u 0.028633320566451126 > ./result_6chains/node352_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_4_2 -p 792 -st topic352_4_1 -pt None -u 0.03074081809604176 > ./result_6chains/node352_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_5_2 -p 850 -st topic352_5_1 -pt None -u 0.0050193450752599855 > ./result_6chains/node352_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_0_0 -p 200 -st none -pt topic352_0_0 -u 0.003951828468706897 > ./result_6chains/node352_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_1_0 -p 441 -st none -pt topic352_1_0 -u 0.0037606299642081176 > ./result_6chains/node352_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_2_0 -p 466 -st none -pt topic352_2_0 -u 0.052905151057888955 > ./result_6chains/node352_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_3_0 -p 581 -st none -pt topic352_3_0 -u 0.016664048550201038 > ./result_6chains/node352_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node352_4_0 -p 792 -st none -pt topic352_4_0 -u 0.024521643994776687 > ./result_6chains/node352_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node352_5_0 -p 850 -st none -pt topic352_5_0 -u 0.05018767407423841 > ./result_6chains/node352_5_0.txt &
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
    "./result_6chains/node352_0_0.txt 90"
    "./result_6chains/node352_0_2.txt 90"
    "./result_6chains/node352_1_0.txt 89"
    "./result_6chains/node352_1_2.txt 89"
    "./result_6chains/node352_2_0.txt 88"
    "./result_6chains/node352_2_2.txt 88"
    "./result_6chains/node352_3_0.txt 87"
    "./result_6chains/node352_3_2.txt 87"
    "./result_6chains/node352_4_0.txt 86"
    "./result_6chains/node352_4_2.txt 86"
    "./result_6chains/node352_5_0.txt 85"
    "./result_6chains/node352_5_2.txt 85"
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

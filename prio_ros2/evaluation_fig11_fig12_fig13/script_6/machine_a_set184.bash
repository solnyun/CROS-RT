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
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_2 -p 231 -st topic184_0_1 -pt None -u 0.016778009160435703 > ./result_6chains/node184_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_2 -p 314 -st topic184_1_1 -pt None -u 0.02561794910601134 > ./result_6chains/node184_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_2 -p 451 -st topic184_2_1 -pt None -u 0.004692965777526481 > ./result_6chains/node184_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_2 -p 519 -st topic184_3_1 -pt None -u 0.05385446327709781 > ./result_6chains/node184_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_2 -p 729 -st topic184_4_1 -pt None -u 0.004877067869620864 > ./result_6chains/node184_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_2 -p 907 -st topic184_5_1 -pt None -u 0.0009820856397881061 > ./result_6chains/node184_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_0_0 -p 231 -st none -pt topic184_0_0 -u 0.08829752797722229 > ./result_6chains/node184_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_1_0 -p 314 -st none -pt topic184_1_0 -u 0.038758598094252916 > ./result_6chains/node184_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_2_0 -p 451 -st none -pt topic184_2_0 -u 0.004956729808320515 > ./result_6chains/node184_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_3_0 -p 519 -st none -pt topic184_3_0 -u 0.001403169750381128 > ./result_6chains/node184_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node184_4_0 -p 729 -st none -pt topic184_4_0 -u 0.10322177634070927 > ./result_6chains/node184_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node184_5_0 -p 907 -st none -pt topic184_5_0 -u 0.004833946916451039 > ./result_6chains/node184_5_0.txt &
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
    "./result_6chains/node184_0_0.txt 90"
    "./result_6chains/node184_0_2.txt 90"
    "./result_6chains/node184_1_0.txt 89"
    "./result_6chains/node184_1_2.txt 89"
    "./result_6chains/node184_2_0.txt 88"
    "./result_6chains/node184_2_2.txt 88"
    "./result_6chains/node184_3_0.txt 87"
    "./result_6chains/node184_3_2.txt 87"
    "./result_6chains/node184_4_0.txt 86"
    "./result_6chains/node184_4_2.txt 86"
    "./result_6chains/node184_5_0.txt 85"
    "./result_6chains/node184_5_2.txt 85"
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

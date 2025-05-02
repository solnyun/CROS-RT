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
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_2 -p 35 -st topic181_0_1 -pt None -u 0.007606818627518386 > ./result_6chains/node181_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_2 -p 410 -st topic181_1_1 -pt None -u 0.004158590487393199 > ./result_6chains/node181_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_2 -p 499 -st topic181_2_1 -pt None -u 0.011452830111261664 > ./result_6chains/node181_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_2 -p 566 -st topic181_3_1 -pt None -u 0.03416710076797183 > ./result_6chains/node181_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_4_2 -p 807 -st topic181_4_1 -pt None -u 0.013557458296277705 > ./result_6chains/node181_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_5_2 -p 918 -st topic181_5_1 -pt None -u 0.01616235057856682 > ./result_6chains/node181_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_0_0 -p 35 -st none -pt topic181_0_0 -u 0.05291622307230687 > ./result_6chains/node181_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_1_0 -p 410 -st none -pt topic181_1_0 -u 0.009394385229830882 > ./result_6chains/node181_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_2_0 -p 499 -st none -pt topic181_2_0 -u 0.052743638969226736 > ./result_6chains/node181_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_3_0 -p 566 -st none -pt topic181_3_0 -u 0.07409435699594627 > ./result_6chains/node181_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node181_4_0 -p 807 -st none -pt topic181_4_0 -u 0.028084110205105095 > ./result_6chains/node181_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node181_5_0 -p 918 -st none -pt topic181_5_0 -u 0.020011173644905712 > ./result_6chains/node181_5_0.txt &
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
    "./result_6chains/node181_0_0.txt 90"
    "./result_6chains/node181_0_2.txt 90"
    "./result_6chains/node181_1_0.txt 89"
    "./result_6chains/node181_1_2.txt 89"
    "./result_6chains/node181_2_0.txt 88"
    "./result_6chains/node181_2_2.txt 88"
    "./result_6chains/node181_3_0.txt 87"
    "./result_6chains/node181_3_2.txt 87"
    "./result_6chains/node181_4_0.txt 86"
    "./result_6chains/node181_4_2.txt 86"
    "./result_6chains/node181_5_0.txt 85"
    "./result_6chains/node181_5_2.txt 85"
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

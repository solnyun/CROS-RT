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
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_2 -p 487 -st topic152_0_1 -pt None -u 0.004319591742301898 > ./result_4chains/node152_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_2 -p 538 -st topic152_1_1 -pt None -u 0.023786860063209125 > ./result_4chains/node152_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_2 -p 695 -st topic152_2_1 -pt None -u 0.05155543197498014 > ./result_4chains/node152_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_2 -p 751 -st topic152_3_1 -pt None -u 0.16829651687693903 > ./result_4chains/node152_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_0 -p 487 -st none -pt topic152_0_0 -u 0.03242991865818956 > ./result_4chains/node152_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_0 -p 538 -st none -pt topic152_1_0 -u 0.0019579794248998916 > ./result_4chains/node152_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_0 -p 695 -st none -pt topic152_2_0 -u 0.026501226130087152 > ./result_4chains/node152_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_0 -p 751 -st none -pt topic152_3_0 -u 0.009582517454491568 > ./result_4chains/node152_3_0.txt &
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
    "./result_4chains/node152_0_0.txt 90"
    "./result_4chains/node152_0_2.txt 90"
    "./result_4chains/node152_1_0.txt 89"
    "./result_4chains/node152_1_2.txt 89"
    "./result_4chains/node152_2_0.txt 88"
    "./result_4chains/node152_2_2.txt 88"
    "./result_4chains/node152_3_0.txt 87"
    "./result_4chains/node152_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

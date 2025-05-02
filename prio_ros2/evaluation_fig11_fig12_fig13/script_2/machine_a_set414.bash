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
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_2 -p 19 -st topic414_0_1 -pt None -u 0.0877371099724128 > ./result_2chains/node414_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_2 -p 286 -st topic414_1_1 -pt None -u 0.039535622661206485 > ./result_2chains/node414_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_0 -p 19 -st none -pt topic414_0_0 -u 0.05075937692493199 > ./result_2chains/node414_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_0 -p 286 -st none -pt topic414_1_0 -u 0.2882165056897148 > ./result_2chains/node414_1_0.txt &
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
    "./result_2chains/node414_0_0.txt 90"
    "./result_2chains/node414_0_2.txt 90"
    "./result_2chains/node414_1_0.txt 89"
    "./result_2chains/node414_1_2.txt 89"
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

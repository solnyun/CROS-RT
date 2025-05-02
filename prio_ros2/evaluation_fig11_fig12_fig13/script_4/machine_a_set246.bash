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
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_2 -p 52 -st topic246_0_1 -pt None -u 0.04587515425727723 > ./result_4chains/node246_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_2 -p 161 -st topic246_1_1 -pt None -u 0.010156744020153374 > ./result_4chains/node246_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_2 -p 286 -st topic246_2_1 -pt None -u 0.005967167423222106 > ./result_4chains/node246_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_2 -p 969 -st topic246_3_1 -pt None -u 0.05968912562131676 > ./result_4chains/node246_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_0_0 -p 52 -st none -pt topic246_0_0 -u 0.05578216466416874 > ./result_4chains/node246_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_1_0 -p 161 -st none -pt topic246_1_0 -u 0.054155625888264614 > ./result_4chains/node246_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node246_2_0 -p 286 -st none -pt topic246_2_0 -u 0.04007935240905333 > ./result_4chains/node246_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node246_3_0 -p 969 -st none -pt topic246_3_0 -u 0.0004696732294738465 > ./result_4chains/node246_3_0.txt &
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
    "./result_4chains/node246_0_0.txt 90"
    "./result_4chains/node246_0_2.txt 90"
    "./result_4chains/node246_1_0.txt 89"
    "./result_4chains/node246_1_2.txt 89"
    "./result_4chains/node246_2_0.txt 88"
    "./result_4chains/node246_2_2.txt 88"
    "./result_4chains/node246_3_0.txt 87"
    "./result_4chains/node246_3_2.txt 87"
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

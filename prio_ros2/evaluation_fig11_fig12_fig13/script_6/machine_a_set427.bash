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
ros2 run evaluation_3_randomdag uunifast_node -n node427_0_2 -p 34 -st topic427_0_1 -pt None -u 0.039027758864151496 > ./result_6chains/node427_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_1_2 -p 49 -st topic427_1_1 -pt None -u 0.04174986499243294 > ./result_6chains/node427_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_2_2 -p 207 -st topic427_2_1 -pt None -u 0.018085259353899152 > ./result_6chains/node427_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_3_2 -p 659 -st topic427_3_1 -pt None -u 0.013541165288631085 > ./result_6chains/node427_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_4_2 -p 737 -st topic427_4_1 -pt None -u 0.008341581770347162 > ./result_6chains/node427_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_5_2 -p 748 -st topic427_5_1 -pt None -u 0.08421664241392464 > ./result_6chains/node427_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_0_0 -p 34 -st none -pt topic427_0_0 -u 0.05131424528324979 > ./result_6chains/node427_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_1_0 -p 49 -st none -pt topic427_1_0 -u 0.028893225426679325 > ./result_6chains/node427_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_2_0 -p 207 -st none -pt topic427_2_0 -u 0.004202249970698402 > ./result_6chains/node427_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_3_0 -p 659 -st none -pt topic427_3_0 -u 0.003078718050997298 > ./result_6chains/node427_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node427_4_0 -p 737 -st none -pt topic427_4_0 -u 0.12458380669401847 > ./result_6chains/node427_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node427_5_0 -p 748 -st none -pt topic427_5_0 -u 0.0014925576427442105 > ./result_6chains/node427_5_0.txt &
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
    "./result_6chains/node427_0_0.txt 90"
    "./result_6chains/node427_0_2.txt 90"
    "./result_6chains/node427_1_0.txt 89"
    "./result_6chains/node427_1_2.txt 89"
    "./result_6chains/node427_2_0.txt 88"
    "./result_6chains/node427_2_2.txt 88"
    "./result_6chains/node427_3_0.txt 87"
    "./result_6chains/node427_3_2.txt 87"
    "./result_6chains/node427_4_0.txt 86"
    "./result_6chains/node427_4_2.txt 86"
    "./result_6chains/node427_5_0.txt 85"
    "./result_6chains/node427_5_2.txt 85"
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

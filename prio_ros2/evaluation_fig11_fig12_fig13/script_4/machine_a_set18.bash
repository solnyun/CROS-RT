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
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_2 -p 42 -st topic18_0_1 -pt None -u 0.033806431131620795 > ./result_4chains/node18_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_2 -p 237 -st topic18_1_1 -pt None -u 0.01856351662575556 > ./result_4chains/node18_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_2 -p 320 -st topic18_2_1 -pt None -u 0.03206118867702107 > ./result_4chains/node18_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_2 -p 389 -st topic18_3_1 -pt None -u 0.007399661583149378 > ./result_4chains/node18_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_0 -p 42 -st none -pt topic18_0_0 -u 0.051132442153653423 > ./result_4chains/node18_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_0 -p 237 -st none -pt topic18_1_0 -u 0.010144707437296618 > ./result_4chains/node18_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_0 -p 320 -st none -pt topic18_2_0 -u 0.09793844797072809 > ./result_4chains/node18_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_0 -p 389 -st none -pt topic18_3_0 -u 0.023427410469408078 > ./result_4chains/node18_3_0.txt &
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
    "./result_4chains/node18_0_0.txt 90"
    "./result_4chains/node18_0_2.txt 90"
    "./result_4chains/node18_1_0.txt 89"
    "./result_4chains/node18_1_2.txt 89"
    "./result_4chains/node18_2_0.txt 88"
    "./result_4chains/node18_2_2.txt 88"
    "./result_4chains/node18_3_0.txt 87"
    "./result_4chains/node18_3_2.txt 87"
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

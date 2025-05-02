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
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_2 -p 83 -st topic186_0_1 -pt None -u 0.04161805631315807 > ./result_4chains/node186_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_2 -p 149 -st topic186_1_1 -pt None -u 0.09882252185272558 > ./result_4chains/node186_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_2 -p 225 -st topic186_2_1 -pt None -u 0.057886719810832224 > ./result_4chains/node186_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_2 -p 710 -st topic186_3_1 -pt None -u 0.05167627358450969 > ./result_4chains/node186_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_0 -p 83 -st none -pt topic186_0_0 -u 0.03662932606992364 > ./result_4chains/node186_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_0 -p 149 -st none -pt topic186_1_0 -u 0.061719577311380724 > ./result_4chains/node186_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_0 -p 225 -st none -pt topic186_2_0 -u 0.026473021364623428 > ./result_4chains/node186_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_0 -p 710 -st none -pt topic186_3_0 -u 0.023756926137793816 > ./result_4chains/node186_3_0.txt &
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
    "./result_4chains/node186_0_0.txt 90"
    "./result_4chains/node186_0_2.txt 90"
    "./result_4chains/node186_1_0.txt 89"
    "./result_4chains/node186_1_2.txt 89"
    "./result_4chains/node186_2_0.txt 88"
    "./result_4chains/node186_2_2.txt 88"
    "./result_4chains/node186_3_0.txt 87"
    "./result_4chains/node186_3_2.txt 87"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_2 -p 275 -st topic224_0_1 -pt None -u 0.062181269466303424 > ./result_4chains/node224_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_2 -p 324 -st topic224_1_1 -pt None -u 0.08130664866785359 > ./result_4chains/node224_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_2 -p 458 -st topic224_2_1 -pt None -u 0.061406844309719544 > ./result_4chains/node224_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_2 -p 957 -st topic224_3_1 -pt None -u 0.04230079983540625 > ./result_4chains/node224_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_0_0 -p 275 -st none -pt topic224_0_0 -u 0.07434565527032516 > ./result_4chains/node224_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_1_0 -p 324 -st none -pt topic224_1_0 -u 0.015948422608959067 > ./result_4chains/node224_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node224_2_0 -p 458 -st none -pt topic224_2_0 -u 0.037833049164882976 > ./result_4chains/node224_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node224_3_0 -p 957 -st none -pt topic224_3_0 -u 0.06236747315610573 > ./result_4chains/node224_3_0.txt &
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
    "./result_4chains/node224_0_0.txt 90"
    "./result_4chains/node224_0_2.txt 90"
    "./result_4chains/node224_1_0.txt 89"
    "./result_4chains/node224_1_2.txt 89"
    "./result_4chains/node224_2_0.txt 88"
    "./result_4chains/node224_2_2.txt 88"
    "./result_4chains/node224_3_0.txt 87"
    "./result_4chains/node224_3_2.txt 87"
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

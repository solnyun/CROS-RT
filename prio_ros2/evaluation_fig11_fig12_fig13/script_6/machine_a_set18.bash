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
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_2 -p 228 -st topic18_0_1 -pt None -u 0.04531627394609827 > ./result_6chains/node18_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_2 -p 436 -st topic18_1_1 -pt None -u 0.008125995826465338 > ./result_6chains/node18_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_2 -p 518 -st topic18_2_1 -pt None -u 0.003143886118427891 > ./result_6chains/node18_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_2 -p 538 -st topic18_3_1 -pt None -u 0.007430650042587347 > ./result_6chains/node18_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_4_2 -p 587 -st topic18_4_1 -pt None -u 0.029086335516954873 > ./result_6chains/node18_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_5_2 -p 606 -st topic18_5_1 -pt None -u 0.038174532800669035 > ./result_6chains/node18_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_0 -p 228 -st none -pt topic18_0_0 -u 0.006661050379529354 > ./result_6chains/node18_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_0 -p 436 -st none -pt topic18_1_0 -u 0.06808969597621722 > ./result_6chains/node18_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_0 -p 518 -st none -pt topic18_2_0 -u 0.0514012891419966 > ./result_6chains/node18_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_0 -p 538 -st none -pt topic18_3_0 -u 0.0015293029226836896 > ./result_6chains/node18_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_4_0 -p 587 -st none -pt topic18_4_0 -u 0.0040120982682420175 > ./result_6chains/node18_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_5_0 -p 606 -st none -pt topic18_5_0 -u 0.009997065669205406 > ./result_6chains/node18_5_0.txt &
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
    "./result_6chains/node18_0_0.txt 90"
    "./result_6chains/node18_0_2.txt 90"
    "./result_6chains/node18_1_0.txt 89"
    "./result_6chains/node18_1_2.txt 89"
    "./result_6chains/node18_2_0.txt 88"
    "./result_6chains/node18_2_2.txt 88"
    "./result_6chains/node18_3_0.txt 87"
    "./result_6chains/node18_3_2.txt 87"
    "./result_6chains/node18_4_0.txt 86"
    "./result_6chains/node18_4_2.txt 86"
    "./result_6chains/node18_5_0.txt 85"
    "./result_6chains/node18_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

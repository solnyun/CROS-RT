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
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_2 -p 246 -st topic118_0_1 -pt None -u 0.0034331495972693693 > ./result_6chains/node118_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_2 -p 390 -st topic118_1_1 -pt None -u 0.03247617444082718 > ./result_6chains/node118_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_2 -p 511 -st topic118_2_1 -pt None -u 0.029577204868891094 > ./result_6chains/node118_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_2 -p 927 -st topic118_3_1 -pt None -u 0.0026946803354931936 > ./result_6chains/node118_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_2 -p 928 -st topic118_4_1 -pt None -u 0.008986005867073002 > ./result_6chains/node118_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_2 -p 960 -st topic118_5_1 -pt None -u 0.02140215055669928 > ./result_6chains/node118_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_0_0 -p 246 -st none -pt topic118_0_0 -u 0.015888918565690913 > ./result_6chains/node118_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_1_0 -p 390 -st none -pt topic118_1_0 -u 0.01518757118838715 > ./result_6chains/node118_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_2_0 -p 511 -st none -pt topic118_2_0 -u 0.016342997253152525 > ./result_6chains/node118_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_3_0 -p 927 -st none -pt topic118_3_0 -u 0.013265972007428184 > ./result_6chains/node118_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node118_4_0 -p 928 -st none -pt topic118_4_0 -u 0.02105271295718246 > ./result_6chains/node118_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node118_5_0 -p 960 -st none -pt topic118_5_0 -u 0.07052428188833038 > ./result_6chains/node118_5_0.txt &
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
    "./result_6chains/node118_0_0.txt 90"
    "./result_6chains/node118_0_2.txt 90"
    "./result_6chains/node118_1_0.txt 89"
    "./result_6chains/node118_1_2.txt 89"
    "./result_6chains/node118_2_0.txt 88"
    "./result_6chains/node118_2_2.txt 88"
    "./result_6chains/node118_3_0.txt 87"
    "./result_6chains/node118_3_2.txt 87"
    "./result_6chains/node118_4_0.txt 86"
    "./result_6chains/node118_4_2.txt 86"
    "./result_6chains/node118_5_0.txt 85"
    "./result_6chains/node118_5_2.txt 85"
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

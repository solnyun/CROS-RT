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
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_2 -p 226 -st topic262_0_1 -pt None -u 0.045793807342793647 > ./result_6chains/node262_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_2 -p 594 -st topic262_1_1 -pt None -u 0.036203988292593525 > ./result_6chains/node262_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_2 -p 608 -st topic262_2_1 -pt None -u 0.021949201855354705 > ./result_6chains/node262_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_2 -p 836 -st topic262_3_1 -pt None -u 0.03354267245526549 > ./result_6chains/node262_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_2 -p 843 -st topic262_4_1 -pt None -u 0.0012308686599752094 > ./result_6chains/node262_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_2 -p 976 -st topic262_5_1 -pt None -u 0.03870353998260783 > ./result_6chains/node262_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_0_0 -p 226 -st none -pt topic262_0_0 -u 0.0008042326331409999 > ./result_6chains/node262_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_1_0 -p 594 -st none -pt topic262_1_0 -u 0.00047586056108367414 > ./result_6chains/node262_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_2_0 -p 608 -st none -pt topic262_2_0 -u 0.07380378037082819 > ./result_6chains/node262_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_3_0 -p 836 -st none -pt topic262_3_0 -u 0.015515225971626578 > ./result_6chains/node262_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node262_4_0 -p 843 -st none -pt topic262_4_0 -u 0.053865879055339946 > ./result_6chains/node262_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node262_5_0 -p 976 -st none -pt topic262_5_0 -u 0.011672271499097706 > ./result_6chains/node262_5_0.txt &
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
    "./result_6chains/node262_0_0.txt 90"
    "./result_6chains/node262_0_2.txt 90"
    "./result_6chains/node262_1_0.txt 89"
    "./result_6chains/node262_1_2.txt 89"
    "./result_6chains/node262_2_0.txt 88"
    "./result_6chains/node262_2_2.txt 88"
    "./result_6chains/node262_3_0.txt 87"
    "./result_6chains/node262_3_2.txt 87"
    "./result_6chains/node262_4_0.txt 86"
    "./result_6chains/node262_4_2.txt 86"
    "./result_6chains/node262_5_0.txt 85"
    "./result_6chains/node262_5_2.txt 85"
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

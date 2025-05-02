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
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_2 -p 174 -st topic178_0_1 -pt None -u 0.008790736677275646 > ./result_6chains/node178_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_2 -p 185 -st topic178_1_1 -pt None -u 0.0022545316766048873 > ./result_6chains/node178_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_2 -p 454 -st topic178_2_1 -pt None -u 0.0014243134726559803 > ./result_6chains/node178_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_2 -p 467 -st topic178_3_1 -pt None -u 0.0007894628081613064 > ./result_6chains/node178_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_2 -p 490 -st topic178_4_1 -pt None -u 0.013563140275624441 > ./result_6chains/node178_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_2 -p 603 -st topic178_5_1 -pt None -u 0.04845517519432884 > ./result_6chains/node178_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_0_0 -p 174 -st none -pt topic178_0_0 -u 0.0061445944994447665 > ./result_6chains/node178_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_1_0 -p 185 -st none -pt topic178_1_0 -u 0.05731001648042322 > ./result_6chains/node178_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_2_0 -p 454 -st none -pt topic178_2_0 -u 0.007553693088631408 > ./result_6chains/node178_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_3_0 -p 467 -st none -pt topic178_3_0 -u 0.009798540892971497 > ./result_6chains/node178_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node178_4_0 -p 490 -st none -pt topic178_4_0 -u 0.14391208363705585 > ./result_6chains/node178_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node178_5_0 -p 603 -st none -pt topic178_5_0 -u 0.01611616520465338 > ./result_6chains/node178_5_0.txt &
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
    "./result_6chains/node178_0_0.txt 90"
    "./result_6chains/node178_0_2.txt 90"
    "./result_6chains/node178_1_0.txt 89"
    "./result_6chains/node178_1_2.txt 89"
    "./result_6chains/node178_2_0.txt 88"
    "./result_6chains/node178_2_2.txt 88"
    "./result_6chains/node178_3_0.txt 87"
    "./result_6chains/node178_3_2.txt 87"
    "./result_6chains/node178_4_0.txt 86"
    "./result_6chains/node178_4_2.txt 86"
    "./result_6chains/node178_5_0.txt 85"
    "./result_6chains/node178_5_2.txt 85"
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

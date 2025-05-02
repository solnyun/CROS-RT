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
ros2 run evaluation_3_randomdag uunifast_node -n node88_0_2 -p 549 -st topic88_0_1 -pt None -u 0.10723556535614992 > ./result_6chains/node88_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_1_2 -p 680 -st topic88_1_1 -pt None -u 0.02133109558752405 > ./result_6chains/node88_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_2_2 -p 723 -st topic88_2_1 -pt None -u 0.014289615468772554 > ./result_6chains/node88_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_3_2 -p 820 -st topic88_3_1 -pt None -u 0.031484846696044566 > ./result_6chains/node88_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_4_2 -p 903 -st topic88_4_1 -pt None -u 0.01114628265548661 > ./result_6chains/node88_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_5_2 -p 931 -st topic88_5_1 -pt None -u 0.012193731629496937 > ./result_6chains/node88_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_0_0 -p 549 -st none -pt topic88_0_0 -u 0.004994255356941535 > ./result_6chains/node88_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_1_0 -p 680 -st none -pt topic88_1_0 -u 0.02612282626657625 > ./result_6chains/node88_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_2_0 -p 723 -st none -pt topic88_2_0 -u 0.03830442254193128 > ./result_6chains/node88_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_3_0 -p 820 -st none -pt topic88_3_0 -u 0.0029705579941984306 > ./result_6chains/node88_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node88_4_0 -p 903 -st none -pt topic88_4_0 -u 0.012498511579231458 > ./result_6chains/node88_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node88_5_0 -p 931 -st none -pt topic88_5_0 -u 0.029409716624417277 > ./result_6chains/node88_5_0.txt &
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
    "./result_6chains/node88_0_0.txt 90"
    "./result_6chains/node88_0_2.txt 90"
    "./result_6chains/node88_1_0.txt 89"
    "./result_6chains/node88_1_2.txt 89"
    "./result_6chains/node88_2_0.txt 88"
    "./result_6chains/node88_2_2.txt 88"
    "./result_6chains/node88_3_0.txt 87"
    "./result_6chains/node88_3_2.txt 87"
    "./result_6chains/node88_4_0.txt 86"
    "./result_6chains/node88_4_2.txt 86"
    "./result_6chains/node88_5_0.txt 85"
    "./result_6chains/node88_5_2.txt 85"
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

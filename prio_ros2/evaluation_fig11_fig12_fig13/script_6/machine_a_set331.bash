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
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_2 -p 279 -st topic331_0_1 -pt None -u 0.002763087168605738 > ./result_6chains/node331_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_2 -p 337 -st topic331_1_1 -pt None -u 0.007998273945225842 > ./result_6chains/node331_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_2 -p 360 -st topic331_2_1 -pt None -u 0.0669211548674116 > ./result_6chains/node331_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_2 -p 515 -st topic331_3_1 -pt None -u 0.014377682353937327 > ./result_6chains/node331_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_2 -p 745 -st topic331_4_1 -pt None -u 0.03205908270837288 > ./result_6chains/node331_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_2 -p 840 -st topic331_5_1 -pt None -u 0.0004743299341611733 > ./result_6chains/node331_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_0 -p 279 -st none -pt topic331_0_0 -u 0.02618476018875887 > ./result_6chains/node331_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_0 -p 337 -st none -pt topic331_1_0 -u 0.01669873853387127 > ./result_6chains/node331_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_0 -p 360 -st none -pt topic331_2_0 -u 0.01657694261578263 > ./result_6chains/node331_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_0 -p 515 -st none -pt topic331_3_0 -u 0.014253635562360506 > ./result_6chains/node331_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_0 -p 745 -st none -pt topic331_4_0 -u 0.038735839746373235 > ./result_6chains/node331_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_0 -p 840 -st none -pt topic331_5_0 -u 0.05066132527985907 > ./result_6chains/node331_5_0.txt &
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
    "./result_6chains/node331_0_0.txt 90"
    "./result_6chains/node331_0_2.txt 90"
    "./result_6chains/node331_1_0.txt 89"
    "./result_6chains/node331_1_2.txt 89"
    "./result_6chains/node331_2_0.txt 88"
    "./result_6chains/node331_2_2.txt 88"
    "./result_6chains/node331_3_0.txt 87"
    "./result_6chains/node331_3_2.txt 87"
    "./result_6chains/node331_4_0.txt 86"
    "./result_6chains/node331_4_2.txt 86"
    "./result_6chains/node331_5_0.txt 85"
    "./result_6chains/node331_5_2.txt 85"
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

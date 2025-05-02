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
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_2 -p 48 -st topic9_0_1 -pt None -u 0.09227375007174099 > ./result_6chains/node9_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_2 -p 338 -st topic9_1_1 -pt None -u 0.020230836698367144 > ./result_6chains/node9_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_2 -p 393 -st topic9_2_1 -pt None -u 0.014700062414160608 > ./result_6chains/node9_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_2 -p 461 -st topic9_3_1 -pt None -u 0.0006812354615201577 > ./result_6chains/node9_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_2 -p 823 -st topic9_4_1 -pt None -u 0.012197878831566693 > ./result_6chains/node9_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_2 -p 961 -st topic9_5_1 -pt None -u 0.00304694362084955 > ./result_6chains/node9_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_0_0 -p 48 -st none -pt topic9_0_0 -u 0.08373868486367886 > ./result_6chains/node9_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_1_0 -p 338 -st none -pt topic9_1_0 -u 0.07445549042812558 > ./result_6chains/node9_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_2_0 -p 393 -st none -pt topic9_2_0 -u 0.023561258983928413 > ./result_6chains/node9_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_3_0 -p 461 -st none -pt topic9_3_0 -u 0.03622609872071865 > ./result_6chains/node9_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node9_4_0 -p 823 -st none -pt topic9_4_0 -u 0.013547982226177396 > ./result_6chains/node9_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node9_5_0 -p 961 -st none -pt topic9_5_0 -u 0.019910430580333382 > ./result_6chains/node9_5_0.txt &
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
    "./result_6chains/node9_0_0.txt 90"
    "./result_6chains/node9_0_2.txt 90"
    "./result_6chains/node9_1_0.txt 89"
    "./result_6chains/node9_1_2.txt 89"
    "./result_6chains/node9_2_0.txt 88"
    "./result_6chains/node9_2_2.txt 88"
    "./result_6chains/node9_3_0.txt 87"
    "./result_6chains/node9_3_2.txt 87"
    "./result_6chains/node9_4_0.txt 86"
    "./result_6chains/node9_4_2.txt 86"
    "./result_6chains/node9_5_0.txt 85"
    "./result_6chains/node9_5_2.txt 85"
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

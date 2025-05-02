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
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_2 -p 121 -st topic191_0_1 -pt None -u 0.009018258854662509 > ./result_6chains/node191_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_2 -p 160 -st topic191_1_1 -pt None -u 0.005421108448493028 > ./result_6chains/node191_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_2 -p 677 -st topic191_2_1 -pt None -u 0.07261537551313701 > ./result_6chains/node191_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_2 -p 767 -st topic191_3_1 -pt None -u 0.007784799550488664 > ./result_6chains/node191_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_2 -p 770 -st topic191_4_1 -pt None -u 0.056256372232963134 > ./result_6chains/node191_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_2 -p 788 -st topic191_5_1 -pt None -u 0.02425123801800675 > ./result_6chains/node191_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_0_0 -p 121 -st none -pt topic191_0_0 -u 0.0011917007445317318 > ./result_6chains/node191_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_1_0 -p 160 -st none -pt topic191_1_0 -u 0.03214437592358871 > ./result_6chains/node191_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_2_0 -p 677 -st none -pt topic191_2_0 -u 0.05061454345926292 > ./result_6chains/node191_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_3_0 -p 767 -st none -pt topic191_3_0 -u 0.007982786343132542 > ./result_6chains/node191_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node191_4_0 -p 770 -st none -pt topic191_4_0 -u 0.04656126823343612 > ./result_6chains/node191_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node191_5_0 -p 788 -st none -pt topic191_5_0 -u 0.017054136208483492 > ./result_6chains/node191_5_0.txt &
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
    "./result_6chains/node191_0_0.txt 90"
    "./result_6chains/node191_0_2.txt 90"
    "./result_6chains/node191_1_0.txt 89"
    "./result_6chains/node191_1_2.txt 89"
    "./result_6chains/node191_2_0.txt 88"
    "./result_6chains/node191_2_2.txt 88"
    "./result_6chains/node191_3_0.txt 87"
    "./result_6chains/node191_3_2.txt 87"
    "./result_6chains/node191_4_0.txt 86"
    "./result_6chains/node191_4_2.txt 86"
    "./result_6chains/node191_5_0.txt 85"
    "./result_6chains/node191_5_2.txt 85"
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

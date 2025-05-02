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
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_2 -p 31 -st topic461_0_1 -pt None -u 0.002069597701247927 > ./result_6chains/node461_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_2 -p 34 -st topic461_1_1 -pt None -u 0.031087241908404395 > ./result_6chains/node461_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_2 -p 301 -st topic461_2_1 -pt None -u 0.032809752377333745 > ./result_6chains/node461_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_2 -p 539 -st topic461_3_1 -pt None -u 0.017938447092041843 > ./result_6chains/node461_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_2 -p 589 -st topic461_4_1 -pt None -u 0.02535676399102514 > ./result_6chains/node461_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_2 -p 596 -st topic461_5_1 -pt None -u 0.019730025892007643 > ./result_6chains/node461_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_0 -p 31 -st none -pt topic461_0_0 -u 0.01633484288454634 > ./result_6chains/node461_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_0 -p 34 -st none -pt topic461_1_0 -u 0.02280708110058549 > ./result_6chains/node461_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_0 -p 301 -st none -pt topic461_2_0 -u 0.0030986566445989072 > ./result_6chains/node461_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_0 -p 539 -st none -pt topic461_3_0 -u 0.11127470189459973 > ./result_6chains/node461_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_0 -p 589 -st none -pt topic461_4_0 -u 0.056903729129864716 > ./result_6chains/node461_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_0 -p 596 -st none -pt topic461_5_0 -u 0.03651367130480274 > ./result_6chains/node461_5_0.txt &
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
    "./result_6chains/node461_0_0.txt 90"
    "./result_6chains/node461_0_2.txt 90"
    "./result_6chains/node461_1_0.txt 89"
    "./result_6chains/node461_1_2.txt 89"
    "./result_6chains/node461_2_0.txt 88"
    "./result_6chains/node461_2_2.txt 88"
    "./result_6chains/node461_3_0.txt 87"
    "./result_6chains/node461_3_2.txt 87"
    "./result_6chains/node461_4_0.txt 86"
    "./result_6chains/node461_4_2.txt 86"
    "./result_6chains/node461_5_0.txt 85"
    "./result_6chains/node461_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_2 -p 218 -st topic95_0_1 -pt None -u 0.026402263313641483 > ./result_6chains/node95_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_2 -p 440 -st topic95_1_1 -pt None -u 0.031033883271500418 > ./result_6chains/node95_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_2 -p 490 -st topic95_2_1 -pt None -u 0.011264209859483093 > ./result_6chains/node95_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_2 -p 492 -st topic95_3_1 -pt None -u 0.017241923806504272 > ./result_6chains/node95_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_2 -p 614 -st topic95_4_1 -pt None -u 0.020167361892217267 > ./result_6chains/node95_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_2 -p 982 -st topic95_5_1 -pt None -u 0.010579647698011237 > ./result_6chains/node95_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_0_0 -p 218 -st none -pt topic95_0_0 -u 0.013510780297774971 > ./result_6chains/node95_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_1_0 -p 440 -st none -pt topic95_1_0 -u 0.018323090243765883 > ./result_6chains/node95_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_2_0 -p 490 -st none -pt topic95_2_0 -u 0.02332804766490476 > ./result_6chains/node95_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_3_0 -p 492 -st none -pt topic95_3_0 -u 0.02941459363415458 > ./result_6chains/node95_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node95_4_0 -p 614 -st none -pt topic95_4_0 -u 0.042755149553121125 > ./result_6chains/node95_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node95_5_0 -p 982 -st none -pt topic95_5_0 -u 0.06726714087852165 > ./result_6chains/node95_5_0.txt &
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
    "./result_6chains/node95_0_0.txt 90"
    "./result_6chains/node95_0_2.txt 90"
    "./result_6chains/node95_1_0.txt 89"
    "./result_6chains/node95_1_2.txt 89"
    "./result_6chains/node95_2_0.txt 88"
    "./result_6chains/node95_2_2.txt 88"
    "./result_6chains/node95_3_0.txt 87"
    "./result_6chains/node95_3_2.txt 87"
    "./result_6chains/node95_4_0.txt 86"
    "./result_6chains/node95_4_2.txt 86"
    "./result_6chains/node95_5_0.txt 85"
    "./result_6chains/node95_5_2.txt 85"
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

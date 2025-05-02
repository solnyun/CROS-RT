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
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_2 -p 573 -st topic416_0_1 -pt None -u 0.16584236742285519 > ./result_6chains/node416_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_2 -p 713 -st topic416_1_1 -pt None -u 0.014440641738934806 > ./result_6chains/node416_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_2 -p 724 -st topic416_2_1 -pt None -u 0.007562415369102876 > ./result_6chains/node416_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_2 -p 879 -st topic416_3_1 -pt None -u 0.010046334196960952 > ./result_6chains/node416_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_4_2 -p 923 -st topic416_4_1 -pt None -u 0.014557814435830176 > ./result_6chains/node416_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_5_2 -p 990 -st topic416_5_1 -pt None -u 0.004014141609446081 > ./result_6chains/node416_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_0 -p 573 -st none -pt topic416_0_0 -u 0.00801369897106452 > ./result_6chains/node416_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_0 -p 713 -st none -pt topic416_1_0 -u 0.015950935814137257 > ./result_6chains/node416_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_0 -p 724 -st none -pt topic416_2_0 -u 0.004240337645452674 > ./result_6chains/node416_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_0 -p 879 -st none -pt topic416_3_0 -u 0.030615941477667913 > ./result_6chains/node416_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_4_0 -p 923 -st none -pt topic416_4_0 -u 0.0030604900191115794 > ./result_6chains/node416_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_5_0 -p 990 -st none -pt topic416_5_0 -u 0.012101769881557766 > ./result_6chains/node416_5_0.txt &
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
    "./result_6chains/node416_0_0.txt 90"
    "./result_6chains/node416_0_2.txt 90"
    "./result_6chains/node416_1_0.txt 89"
    "./result_6chains/node416_1_2.txt 89"
    "./result_6chains/node416_2_0.txt 88"
    "./result_6chains/node416_2_2.txt 88"
    "./result_6chains/node416_3_0.txt 87"
    "./result_6chains/node416_3_2.txt 87"
    "./result_6chains/node416_4_0.txt 86"
    "./result_6chains/node416_4_2.txt 86"
    "./result_6chains/node416_5_0.txt 85"
    "./result_6chains/node416_5_2.txt 85"
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

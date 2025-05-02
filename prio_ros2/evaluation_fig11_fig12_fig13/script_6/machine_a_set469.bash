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
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_2 -p 30 -st topic469_0_1 -pt None -u 0.04619937640094318 > ./result_6chains/node469_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_2 -p 128 -st topic469_1_1 -pt None -u 0.02903606683289739 > ./result_6chains/node469_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_2 -p 193 -st topic469_2_1 -pt None -u 0.005554497722179752 > ./result_6chains/node469_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_2 -p 383 -st topic469_3_1 -pt None -u 0.02133446420598506 > ./result_6chains/node469_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_2 -p 530 -st topic469_4_1 -pt None -u 0.01401381384109808 > ./result_6chains/node469_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_2 -p 661 -st topic469_5_1 -pt None -u 0.045464109508227414 > ./result_6chains/node469_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_0_0 -p 30 -st none -pt topic469_0_0 -u 0.006364238712208425 > ./result_6chains/node469_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_1_0 -p 128 -st none -pt topic469_1_0 -u 0.023353371156178526 > ./result_6chains/node469_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_2_0 -p 193 -st none -pt topic469_2_0 -u 0.037198132776225634 > ./result_6chains/node469_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_3_0 -p 383 -st none -pt topic469_3_0 -u 0.007962533694969964 > ./result_6chains/node469_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node469_4_0 -p 530 -st none -pt topic469_4_0 -u 0.019592005592602713 > ./result_6chains/node469_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node469_5_0 -p 661 -st none -pt topic469_5_0 -u 0.01597512244670235 > ./result_6chains/node469_5_0.txt &
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
    "./result_6chains/node469_0_0.txt 90"
    "./result_6chains/node469_0_2.txt 90"
    "./result_6chains/node469_1_0.txt 89"
    "./result_6chains/node469_1_2.txt 89"
    "./result_6chains/node469_2_0.txt 88"
    "./result_6chains/node469_2_2.txt 88"
    "./result_6chains/node469_3_0.txt 87"
    "./result_6chains/node469_3_2.txt 87"
    "./result_6chains/node469_4_0.txt 86"
    "./result_6chains/node469_4_2.txt 86"
    "./result_6chains/node469_5_0.txt 85"
    "./result_6chains/node469_5_2.txt 85"
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

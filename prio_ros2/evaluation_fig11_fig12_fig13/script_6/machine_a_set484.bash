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
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_2 -p 10 -st topic484_0_1 -pt None -u 0.03751868910085254 > ./result_6chains/node484_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_2 -p 211 -st topic484_1_1 -pt None -u 0.028987337752150732 > ./result_6chains/node484_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_2 -p 496 -st topic484_2_1 -pt None -u 0.013595901775912467 > ./result_6chains/node484_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_2 -p 585 -st topic484_3_1 -pt None -u 0.03901697443102717 > ./result_6chains/node484_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_2 -p 668 -st topic484_4_1 -pt None -u 0.09050923364068023 > ./result_6chains/node484_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_2 -p 775 -st topic484_5_1 -pt None -u 0.019379578742735062 > ./result_6chains/node484_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_0_0 -p 10 -st none -pt topic484_0_0 -u 0.0014656808069415939 > ./result_6chains/node484_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_1_0 -p 211 -st none -pt topic484_1_0 -u 0.003097620900248621 > ./result_6chains/node484_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_2_0 -p 496 -st none -pt topic484_2_0 -u 0.028454730410307327 > ./result_6chains/node484_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_3_0 -p 585 -st none -pt topic484_3_0 -u 0.016221453795609908 > ./result_6chains/node484_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node484_4_0 -p 668 -st none -pt topic484_4_0 -u 0.03484539450408236 > ./result_6chains/node484_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node484_5_0 -p 775 -st none -pt topic484_5_0 -u 0.020103504882083123 > ./result_6chains/node484_5_0.txt &
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
    "./result_6chains/node484_0_0.txt 90"
    "./result_6chains/node484_0_2.txt 90"
    "./result_6chains/node484_1_0.txt 89"
    "./result_6chains/node484_1_2.txt 89"
    "./result_6chains/node484_2_0.txt 88"
    "./result_6chains/node484_2_2.txt 88"
    "./result_6chains/node484_3_0.txt 87"
    "./result_6chains/node484_3_2.txt 87"
    "./result_6chains/node484_4_0.txt 86"
    "./result_6chains/node484_4_2.txt 86"
    "./result_6chains/node484_5_0.txt 85"
    "./result_6chains/node484_5_2.txt 85"
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

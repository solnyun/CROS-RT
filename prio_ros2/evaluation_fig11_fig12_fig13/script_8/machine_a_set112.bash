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
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_2 -p 35 -st topic112_0_1 -pt None -u 0.018676264939934184 > ./result_8chains/node112_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_2 -p 316 -st topic112_1_1 -pt None -u 0.015124398820150153 > ./result_8chains/node112_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_2 -p 391 -st topic112_2_1 -pt None -u 0.001218914125410142 > ./result_8chains/node112_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_2 -p 399 -st topic112_3_1 -pt None -u 0.02935848575491387 > ./result_8chains/node112_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_2 -p 507 -st topic112_4_1 -pt None -u 0.04688907934279027 > ./result_8chains/node112_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_2 -p 530 -st topic112_5_1 -pt None -u 0.021314684072955697 > ./result_8chains/node112_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_6_2 -p 541 -st topic112_6_1 -pt None -u 0.051633132620489075 > ./result_8chains/node112_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_7_2 -p 845 -st topic112_7_1 -pt None -u 0.06371482357891696 > ./result_8chains/node112_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_0 -p 35 -st none -pt topic112_0_0 -u 0.0374448109595919 > ./result_8chains/node112_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_0 -p 316 -st none -pt topic112_1_0 -u 0.0816697151540704 > ./result_8chains/node112_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_0 -p 391 -st none -pt topic112_2_0 -u 0.023832359245960166 > ./result_8chains/node112_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_0 -p 399 -st none -pt topic112_3_0 -u 0.009127289279731388 > ./result_8chains/node112_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_0 -p 507 -st none -pt topic112_4_0 -u 0.013730535823459039 > ./result_8chains/node112_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_0 -p 530 -st none -pt topic112_5_0 -u 0.0028774217652244027 > ./result_8chains/node112_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_6_0 -p 541 -st none -pt topic112_6_0 -u 0.004874924564823607 > ./result_8chains/node112_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_7_0 -p 845 -st none -pt topic112_7_0 -u 0.014785228449233231 > ./result_8chains/node112_7_0.txt &
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
    "./result_8chains/node112_0_0.txt 90"
    "./result_8chains/node112_0_2.txt 90"
    "./result_8chains/node112_1_0.txt 89"
    "./result_8chains/node112_1_2.txt 89"
    "./result_8chains/node112_2_0.txt 88"
    "./result_8chains/node112_2_2.txt 88"
    "./result_8chains/node112_3_0.txt 87"
    "./result_8chains/node112_3_2.txt 87"
    "./result_8chains/node112_4_0.txt 86"
    "./result_8chains/node112_4_2.txt 86"
    "./result_8chains/node112_5_0.txt 85"
    "./result_8chains/node112_5_2.txt 85"
    "./result_8chains/node112_6_0.txt 84"
    "./result_8chains/node112_6_2.txt 84"
    "./result_8chains/node112_7_0.txt 83"
    "./result_8chains/node112_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

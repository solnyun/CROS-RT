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
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_2 -p 75 -st topic31_0_1 -pt None -u 0.031993020474283096 > ./result_6chains/node31_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_2 -p 188 -st topic31_1_1 -pt None -u 0.015730306160740892 > ./result_6chains/node31_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_2 -p 196 -st topic31_2_1 -pt None -u 0.07167487321936725 > ./result_6chains/node31_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_2 -p 359 -st topic31_3_1 -pt None -u 0.025451130708017772 > ./result_6chains/node31_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_2 -p 668 -st topic31_4_1 -pt None -u 0.012799854170191981 > ./result_6chains/node31_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_2 -p 887 -st topic31_5_1 -pt None -u 0.015705174281352187 > ./result_6chains/node31_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_0_0 -p 75 -st none -pt topic31_0_0 -u 0.010299702108034492 > ./result_6chains/node31_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_1_0 -p 188 -st none -pt topic31_1_0 -u 0.047628326760823125 > ./result_6chains/node31_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_2_0 -p 196 -st none -pt topic31_2_0 -u 0.013099135901588121 > ./result_6chains/node31_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_3_0 -p 359 -st none -pt topic31_3_0 -u 0.035557361546335514 > ./result_6chains/node31_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node31_4_0 -p 668 -st none -pt topic31_4_0 -u 0.01640546705635909 > ./result_6chains/node31_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node31_5_0 -p 887 -st none -pt topic31_5_0 -u 0.008612944291972773 > ./result_6chains/node31_5_0.txt &
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
    "./result_6chains/node31_0_0.txt 90"
    "./result_6chains/node31_0_2.txt 90"
    "./result_6chains/node31_1_0.txt 89"
    "./result_6chains/node31_1_2.txt 89"
    "./result_6chains/node31_2_0.txt 88"
    "./result_6chains/node31_2_2.txt 88"
    "./result_6chains/node31_3_0.txt 87"
    "./result_6chains/node31_3_2.txt 87"
    "./result_6chains/node31_4_0.txt 86"
    "./result_6chains/node31_4_2.txt 86"
    "./result_6chains/node31_5_0.txt 85"
    "./result_6chains/node31_5_2.txt 85"
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

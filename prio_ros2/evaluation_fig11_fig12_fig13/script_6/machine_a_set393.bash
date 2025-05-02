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
ros2 run evaluation_3_randomdag uunifast_node -n node393_0_2 -p 340 -st topic393_0_1 -pt None -u 0.0006947899491804854 > ./result_6chains/node393_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_1_2 -p 372 -st topic393_1_1 -pt None -u 0.011385377957933873 > ./result_6chains/node393_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_2_2 -p 415 -st topic393_2_1 -pt None -u 0.013102521664975109 > ./result_6chains/node393_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_3_2 -p 493 -st topic393_3_1 -pt None -u 0.0508430853701856 > ./result_6chains/node393_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_4_2 -p 821 -st topic393_4_1 -pt None -u 0.0028462838766019696 > ./result_6chains/node393_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_5_2 -p 981 -st topic393_5_1 -pt None -u 0.0008482785150551956 > ./result_6chains/node393_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_0_0 -p 340 -st none -pt topic393_0_0 -u 0.04681523418900568 > ./result_6chains/node393_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_1_0 -p 372 -st none -pt topic393_1_0 -u 0.02440931894618642 > ./result_6chains/node393_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_2_0 -p 415 -st none -pt topic393_2_0 -u 0.06270676952911386 > ./result_6chains/node393_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_3_0 -p 493 -st none -pt topic393_3_0 -u 0.0017395423787301412 > ./result_6chains/node393_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node393_4_0 -p 821 -st none -pt topic393_4_0 -u 0.00823472991726619 > ./result_6chains/node393_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node393_5_0 -p 981 -st none -pt topic393_5_0 -u 0.02379627716367263 > ./result_6chains/node393_5_0.txt &
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
    "./result_6chains/node393_0_0.txt 90"
    "./result_6chains/node393_0_2.txt 90"
    "./result_6chains/node393_1_0.txt 89"
    "./result_6chains/node393_1_2.txt 89"
    "./result_6chains/node393_2_0.txt 88"
    "./result_6chains/node393_2_2.txt 88"
    "./result_6chains/node393_3_0.txt 87"
    "./result_6chains/node393_3_2.txt 87"
    "./result_6chains/node393_4_0.txt 86"
    "./result_6chains/node393_4_2.txt 86"
    "./result_6chains/node393_5_0.txt 85"
    "./result_6chains/node393_5_2.txt 85"
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

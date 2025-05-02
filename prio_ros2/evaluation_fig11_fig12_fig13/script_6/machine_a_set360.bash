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
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_2 -p 224 -st topic360_0_1 -pt None -u 0.054841523281688564 > ./result_6chains/node360_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_2 -p 351 -st topic360_1_1 -pt None -u 0.015672518516472222 > ./result_6chains/node360_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_2 -p 398 -st topic360_2_1 -pt None -u 0.007413748617937255 > ./result_6chains/node360_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_2 -p 588 -st topic360_3_1 -pt None -u 0.04441801376195853 > ./result_6chains/node360_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_2 -p 854 -st topic360_4_1 -pt None -u 0.01918249061669558 > ./result_6chains/node360_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_2 -p 871 -st topic360_5_1 -pt None -u 0.002585414768448235 > ./result_6chains/node360_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_0_0 -p 224 -st none -pt topic360_0_0 -u 0.021915426227008095 > ./result_6chains/node360_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_1_0 -p 351 -st none -pt topic360_1_0 -u 0.06296983533879158 > ./result_6chains/node360_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_2_0 -p 398 -st none -pt topic360_2_0 -u 0.04411822820526812 > ./result_6chains/node360_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_3_0 -p 588 -st none -pt topic360_3_0 -u 0.0055240061388210915 > ./result_6chains/node360_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node360_4_0 -p 854 -st none -pt topic360_4_0 -u 0.05828611050602006 > ./result_6chains/node360_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node360_5_0 -p 871 -st none -pt topic360_5_0 -u 0.013802735778599199 > ./result_6chains/node360_5_0.txt &
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
    "./result_6chains/node360_0_0.txt 90"
    "./result_6chains/node360_0_2.txt 90"
    "./result_6chains/node360_1_0.txt 89"
    "./result_6chains/node360_1_2.txt 89"
    "./result_6chains/node360_2_0.txt 88"
    "./result_6chains/node360_2_2.txt 88"
    "./result_6chains/node360_3_0.txt 87"
    "./result_6chains/node360_3_2.txt 87"
    "./result_6chains/node360_4_0.txt 86"
    "./result_6chains/node360_4_2.txt 86"
    "./result_6chains/node360_5_0.txt 85"
    "./result_6chains/node360_5_2.txt 85"
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

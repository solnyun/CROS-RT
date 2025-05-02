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
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_2 -p 121 -st topic216_0_1 -pt None -u 0.018748466308899092 > ./result_6chains/node216_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_2 -p 142 -st topic216_1_1 -pt None -u 0.006578111413874932 > ./result_6chains/node216_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_2 -p 401 -st topic216_2_1 -pt None -u 0.01662018327829387 > ./result_6chains/node216_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_2 -p 548 -st topic216_3_1 -pt None -u 0.022344276830430027 > ./result_6chains/node216_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_2 -p 760 -st topic216_4_1 -pt None -u 0.015703428979374018 > ./result_6chains/node216_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_2 -p 810 -st topic216_5_1 -pt None -u 0.08511198608385383 > ./result_6chains/node216_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_0_0 -p 121 -st none -pt topic216_0_0 -u 0.02134964452813859 > ./result_6chains/node216_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_1_0 -p 142 -st none -pt topic216_1_0 -u 0.11798297332351931 > ./result_6chains/node216_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_2_0 -p 401 -st none -pt topic216_2_0 -u 0.050250042765834946 > ./result_6chains/node216_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_3_0 -p 548 -st none -pt topic216_3_0 -u 0.01027552915912372 > ./result_6chains/node216_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node216_4_0 -p 760 -st none -pt topic216_4_0 -u 0.03104352446318079 > ./result_6chains/node216_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node216_5_0 -p 810 -st none -pt topic216_5_0 -u 0.003903141829342177 > ./result_6chains/node216_5_0.txt &
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
    "./result_6chains/node216_0_0.txt 90"
    "./result_6chains/node216_0_2.txt 90"
    "./result_6chains/node216_1_0.txt 89"
    "./result_6chains/node216_1_2.txt 89"
    "./result_6chains/node216_2_0.txt 88"
    "./result_6chains/node216_2_2.txt 88"
    "./result_6chains/node216_3_0.txt 87"
    "./result_6chains/node216_3_2.txt 87"
    "./result_6chains/node216_4_0.txt 86"
    "./result_6chains/node216_4_2.txt 86"
    "./result_6chains/node216_5_0.txt 85"
    "./result_6chains/node216_5_2.txt 85"
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

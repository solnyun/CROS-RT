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
ros2 run evaluation_3_randomdag uunifast_node -n node235_0_2 -p 35 -st topic235_0_1 -pt None -u 0.02793929284103014 > ./result_6chains/node235_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_1_2 -p 260 -st topic235_1_1 -pt None -u 0.03289990964818035 > ./result_6chains/node235_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_2_2 -p 329 -st topic235_2_1 -pt None -u 4.761530687985571e-05 > ./result_6chains/node235_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_3_2 -p 442 -st topic235_3_1 -pt None -u 0.0640593186621487 > ./result_6chains/node235_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_4_2 -p 642 -st topic235_4_1 -pt None -u 0.0018960719694784967 > ./result_6chains/node235_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_5_2 -p 736 -st topic235_5_1 -pt None -u 0.14638389476006441 > ./result_6chains/node235_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_0_0 -p 35 -st none -pt topic235_0_0 -u 0.02308554377863392 > ./result_6chains/node235_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_1_0 -p 260 -st none -pt topic235_1_0 -u 0.015934996161676762 > ./result_6chains/node235_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_2_0 -p 329 -st none -pt topic235_2_0 -u 0.007006044838338332 > ./result_6chains/node235_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_3_0 -p 442 -st none -pt topic235_3_0 -u 0.017618585558731414 > ./result_6chains/node235_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node235_4_0 -p 642 -st none -pt topic235_4_0 -u 0.02288519442453474 > ./result_6chains/node235_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node235_5_0 -p 736 -st none -pt topic235_5_0 -u 0.03698404645353798 > ./result_6chains/node235_5_0.txt &
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
    "./result_6chains/node235_0_0.txt 90"
    "./result_6chains/node235_0_2.txt 90"
    "./result_6chains/node235_1_0.txt 89"
    "./result_6chains/node235_1_2.txt 89"
    "./result_6chains/node235_2_0.txt 88"
    "./result_6chains/node235_2_2.txt 88"
    "./result_6chains/node235_3_0.txt 87"
    "./result_6chains/node235_3_2.txt 87"
    "./result_6chains/node235_4_0.txt 86"
    "./result_6chains/node235_4_2.txt 86"
    "./result_6chains/node235_5_0.txt 85"
    "./result_6chains/node235_5_2.txt 85"
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

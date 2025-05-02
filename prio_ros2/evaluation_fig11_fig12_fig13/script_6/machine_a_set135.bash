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
ros2 run evaluation_3_randomdag uunifast_node -n node135_0_2 -p 330 -st topic135_0_1 -pt None -u 0.0037778039045794354 > ./result_6chains/node135_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_1_2 -p 401 -st topic135_1_1 -pt None -u 0.02289224850263266 > ./result_6chains/node135_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_2_2 -p 510 -st topic135_2_1 -pt None -u 0.09670897704985978 > ./result_6chains/node135_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_3_2 -p 661 -st topic135_3_1 -pt None -u 0.009451969122625109 > ./result_6chains/node135_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_4_2 -p 787 -st topic135_4_1 -pt None -u 0.0032898443908457448 > ./result_6chains/node135_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_5_2 -p 997 -st topic135_5_1 -pt None -u 0.010627753988988698 > ./result_6chains/node135_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_0_0 -p 330 -st none -pt topic135_0_0 -u 0.010653489925977033 > ./result_6chains/node135_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_1_0 -p 401 -st none -pt topic135_1_0 -u 0.04548735147509009 > ./result_6chains/node135_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_2_0 -p 510 -st none -pt topic135_2_0 -u 0.045486236222644416 > ./result_6chains/node135_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_3_0 -p 661 -st none -pt topic135_3_0 -u 0.06791973603443008 > ./result_6chains/node135_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node135_4_0 -p 787 -st none -pt topic135_4_0 -u 0.01232759544389446 > ./result_6chains/node135_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node135_5_0 -p 997 -st none -pt topic135_5_0 -u 0.03227350927946003 > ./result_6chains/node135_5_0.txt &
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
    "./result_6chains/node135_0_0.txt 90"
    "./result_6chains/node135_0_2.txt 90"
    "./result_6chains/node135_1_0.txt 89"
    "./result_6chains/node135_1_2.txt 89"
    "./result_6chains/node135_2_0.txt 88"
    "./result_6chains/node135_2_2.txt 88"
    "./result_6chains/node135_3_0.txt 87"
    "./result_6chains/node135_3_2.txt 87"
    "./result_6chains/node135_4_0.txt 86"
    "./result_6chains/node135_4_2.txt 86"
    "./result_6chains/node135_5_0.txt 85"
    "./result_6chains/node135_5_2.txt 85"
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

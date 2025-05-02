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
ros2 run evaluation_3_randomdag uunifast_node -n node490_0_2 -p 160 -st topic490_0_1 -pt None -u 0.0157073931286566 > ./result_6chains/node490_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_1_2 -p 223 -st topic490_1_1 -pt None -u 0.03076626423724288 > ./result_6chains/node490_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_2_2 -p 297 -st topic490_2_1 -pt None -u 0.059210351887251156 > ./result_6chains/node490_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_3_2 -p 499 -st topic490_3_1 -pt None -u 0.0029575709960888985 > ./result_6chains/node490_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_4_2 -p 702 -st topic490_4_1 -pt None -u 0.0013956244502957849 > ./result_6chains/node490_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_5_2 -p 865 -st topic490_5_1 -pt None -u 0.01594768454930492 > ./result_6chains/node490_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_0_0 -p 160 -st none -pt topic490_0_0 -u 0.018877666192919862 > ./result_6chains/node490_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_1_0 -p 223 -st none -pt topic490_1_0 -u 0.022466471251405273 > ./result_6chains/node490_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_2_0 -p 297 -st none -pt topic490_2_0 -u 0.07435496840571243 > ./result_6chains/node490_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_3_0 -p 499 -st none -pt topic490_3_0 -u 0.013588142878902532 > ./result_6chains/node490_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_4_0 -p 702 -st none -pt topic490_4_0 -u 0.04298278797330987 > ./result_6chains/node490_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_5_0 -p 865 -st none -pt topic490_5_0 -u 0.04751805444895364 > ./result_6chains/node490_5_0.txt &
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
    "./result_6chains/node490_0_0.txt 90"
    "./result_6chains/node490_0_2.txt 90"
    "./result_6chains/node490_1_0.txt 89"
    "./result_6chains/node490_1_2.txt 89"
    "./result_6chains/node490_2_0.txt 88"
    "./result_6chains/node490_2_2.txt 88"
    "./result_6chains/node490_3_0.txt 87"
    "./result_6chains/node490_3_2.txt 87"
    "./result_6chains/node490_4_0.txt 86"
    "./result_6chains/node490_4_2.txt 86"
    "./result_6chains/node490_5_0.txt 85"
    "./result_6chains/node490_5_2.txt 85"
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

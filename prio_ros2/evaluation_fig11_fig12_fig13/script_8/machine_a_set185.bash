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
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_2 -p 71 -st topic185_0_1 -pt None -u 0.0003019806535897174 > ./result_8chains/node185_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_2 -p 197 -st topic185_1_1 -pt None -u 0.005985990937905639 > ./result_8chains/node185_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_2 -p 590 -st topic185_2_1 -pt None -u 0.05787048622550073 > ./result_8chains/node185_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_2 -p 637 -st topic185_3_1 -pt None -u 0.017946591561097153 > ./result_8chains/node185_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_4_2 -p 652 -st topic185_4_1 -pt None -u 0.04431624374150436 > ./result_8chains/node185_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_5_2 -p 744 -st topic185_5_1 -pt None -u 0.0029047583088355478 > ./result_8chains/node185_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_6_2 -p 847 -st topic185_6_1 -pt None -u 0.008888702077782317 > ./result_8chains/node185_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_7_2 -p 990 -st topic185_7_1 -pt None -u 0.0015048745547168948 > ./result_8chains/node185_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_0_0 -p 71 -st none -pt topic185_0_0 -u 0.08438992056834194 > ./result_8chains/node185_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_1_0 -p 197 -st none -pt topic185_1_0 -u 0.019191220802940334 > ./result_8chains/node185_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_2_0 -p 590 -st none -pt topic185_2_0 -u 0.004780301317503344 > ./result_8chains/node185_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_3_0 -p 637 -st none -pt topic185_3_0 -u 0.005335977545698478 > ./result_8chains/node185_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_4_0 -p 652 -st none -pt topic185_4_0 -u 0.0411853738967313 > ./result_8chains/node185_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_5_0 -p 744 -st none -pt topic185_5_0 -u 0.0007822299555919621 > ./result_8chains/node185_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node185_6_0 -p 847 -st none -pt topic185_6_0 -u 0.0398824313945486 > ./result_8chains/node185_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node185_7_0 -p 990 -st none -pt topic185_7_0 -u 0.004318185942332735 > ./result_8chains/node185_7_0.txt &
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
    "./result_8chains/node185_0_0.txt 90"
    "./result_8chains/node185_0_2.txt 90"
    "./result_8chains/node185_1_0.txt 89"
    "./result_8chains/node185_1_2.txt 89"
    "./result_8chains/node185_2_0.txt 88"
    "./result_8chains/node185_2_2.txt 88"
    "./result_8chains/node185_3_0.txt 87"
    "./result_8chains/node185_3_2.txt 87"
    "./result_8chains/node185_4_0.txt 86"
    "./result_8chains/node185_4_2.txt 86"
    "./result_8chains/node185_5_0.txt 85"
    "./result_8chains/node185_5_2.txt 85"
    "./result_8chains/node185_6_0.txt 84"
    "./result_8chains/node185_6_2.txt 84"
    "./result_8chains/node185_7_0.txt 83"
    "./result_8chains/node185_7_2.txt 83"
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

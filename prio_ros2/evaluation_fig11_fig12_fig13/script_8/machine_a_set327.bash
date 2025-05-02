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
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_2 -p 193 -st topic327_0_1 -pt None -u 0.019936211800124226 > ./result_8chains/node327_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_2 -p 226 -st topic327_1_1 -pt None -u 0.05757687403626949 > ./result_8chains/node327_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_2 -p 311 -st topic327_2_1 -pt None -u 0.045556602893716935 > ./result_8chains/node327_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_2 -p 317 -st topic327_3_1 -pt None -u 0.005021558168015999 > ./result_8chains/node327_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_4_2 -p 440 -st topic327_4_1 -pt None -u 0.018566112346880742 > ./result_8chains/node327_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_5_2 -p 594 -st topic327_5_1 -pt None -u 0.05304970893711933 > ./result_8chains/node327_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_6_2 -p 694 -st topic327_6_1 -pt None -u 0.013137802116031591 > ./result_8chains/node327_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_7_2 -p 729 -st topic327_7_1 -pt None -u 0.007662986833671096 > ./result_8chains/node327_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_0 -p 193 -st none -pt topic327_0_0 -u 0.003274362410588705 > ./result_8chains/node327_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_0 -p 226 -st none -pt topic327_1_0 -u 0.004659210108619971 > ./result_8chains/node327_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_0 -p 311 -st none -pt topic327_2_0 -u 0.006433758705088277 > ./result_8chains/node327_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_0 -p 317 -st none -pt topic327_3_0 -u 0.009327796653298082 > ./result_8chains/node327_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_4_0 -p 440 -st none -pt topic327_4_0 -u 0.026902827185332823 > ./result_8chains/node327_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_5_0 -p 594 -st none -pt topic327_5_0 -u 0.03035441944227915 > ./result_8chains/node327_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_6_0 -p 694 -st none -pt topic327_6_0 -u 0.0012498730799755248 > ./result_8chains/node327_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_7_0 -p 729 -st none -pt topic327_7_0 -u 0.006781683383985219 > ./result_8chains/node327_7_0.txt &
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
    "./result_8chains/node327_0_0.txt 90"
    "./result_8chains/node327_0_2.txt 90"
    "./result_8chains/node327_1_0.txt 89"
    "./result_8chains/node327_1_2.txt 89"
    "./result_8chains/node327_2_0.txt 88"
    "./result_8chains/node327_2_2.txt 88"
    "./result_8chains/node327_3_0.txt 87"
    "./result_8chains/node327_3_2.txt 87"
    "./result_8chains/node327_4_0.txt 86"
    "./result_8chains/node327_4_2.txt 86"
    "./result_8chains/node327_5_0.txt 85"
    "./result_8chains/node327_5_2.txt 85"
    "./result_8chains/node327_6_0.txt 84"
    "./result_8chains/node327_6_2.txt 84"
    "./result_8chains/node327_7_0.txt 83"
    "./result_8chains/node327_7_2.txt 83"
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

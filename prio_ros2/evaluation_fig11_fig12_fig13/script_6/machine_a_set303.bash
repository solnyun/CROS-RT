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
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_2 -p 99 -st topic303_0_1 -pt None -u 0.006451095076455637 > ./result_6chains/node303_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_2 -p 137 -st topic303_1_1 -pt None -u 0.029800965127906753 > ./result_6chains/node303_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_2 -p 238 -st topic303_2_1 -pt None -u 0.01825682045800342 > ./result_6chains/node303_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_2 -p 374 -st topic303_3_1 -pt None -u 0.002734246419259345 > ./result_6chains/node303_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_2 -p 982 -st topic303_4_1 -pt None -u 0.022362823584177904 > ./result_6chains/node303_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_2 -p 998 -st topic303_5_1 -pt None -u 0.06651384118802717 > ./result_6chains/node303_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_0_0 -p 99 -st none -pt topic303_0_0 -u 0.0035764542089711804 > ./result_6chains/node303_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_1_0 -p 137 -st none -pt topic303_1_0 -u 0.01684878317327937 > ./result_6chains/node303_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_2_0 -p 238 -st none -pt topic303_2_0 -u 0.06677155961037812 > ./result_6chains/node303_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_3_0 -p 374 -st none -pt topic303_3_0 -u 0.001637332722290219 > ./result_6chains/node303_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node303_4_0 -p 982 -st none -pt topic303_4_0 -u 0.13165313556507238 > ./result_6chains/node303_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node303_5_0 -p 998 -st none -pt topic303_5_0 -u 0.01612449667154975 > ./result_6chains/node303_5_0.txt &
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
    "./result_6chains/node303_0_0.txt 90"
    "./result_6chains/node303_0_2.txt 90"
    "./result_6chains/node303_1_0.txt 89"
    "./result_6chains/node303_1_2.txt 89"
    "./result_6chains/node303_2_0.txt 88"
    "./result_6chains/node303_2_2.txt 88"
    "./result_6chains/node303_3_0.txt 87"
    "./result_6chains/node303_3_2.txt 87"
    "./result_6chains/node303_4_0.txt 86"
    "./result_6chains/node303_4_2.txt 86"
    "./result_6chains/node303_5_0.txt 85"
    "./result_6chains/node303_5_2.txt 85"
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

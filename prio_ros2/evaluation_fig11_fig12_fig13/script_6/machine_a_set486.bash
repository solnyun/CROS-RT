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
ros2 run evaluation_3_randomdag uunifast_node -n node486_0_2 -p 190 -st topic486_0_1 -pt None -u 0.0030679166724136286 > ./result_6chains/node486_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_1_2 -p 199 -st topic486_1_1 -pt None -u 0.010505683922917786 > ./result_6chains/node486_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_2_2 -p 203 -st topic486_2_1 -pt None -u 0.04710933955002283 > ./result_6chains/node486_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_3_2 -p 318 -st topic486_3_1 -pt None -u 0.02584447579014268 > ./result_6chains/node486_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_4_2 -p 526 -st topic486_4_1 -pt None -u 0.03866547636578879 > ./result_6chains/node486_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_5_2 -p 888 -st topic486_5_1 -pt None -u 0.0018693732087919138 > ./result_6chains/node486_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_0_0 -p 190 -st none -pt topic486_0_0 -u 0.01273536316892837 > ./result_6chains/node486_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_1_0 -p 199 -st none -pt topic486_1_0 -u 0.007908979979394937 > ./result_6chains/node486_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_2_0 -p 203 -st none -pt topic486_2_0 -u 0.026140271010547944 > ./result_6chains/node486_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_3_0 -p 318 -st none -pt topic486_3_0 -u 0.024602671764931472 > ./result_6chains/node486_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node486_4_0 -p 526 -st none -pt topic486_4_0 -u 0.010841981646099591 > ./result_6chains/node486_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node486_5_0 -p 888 -st none -pt topic486_5_0 -u 0.010071997878866576 > ./result_6chains/node486_5_0.txt &
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
    "./result_6chains/node486_0_0.txt 90"
    "./result_6chains/node486_0_2.txt 90"
    "./result_6chains/node486_1_0.txt 89"
    "./result_6chains/node486_1_2.txt 89"
    "./result_6chains/node486_2_0.txt 88"
    "./result_6chains/node486_2_2.txt 88"
    "./result_6chains/node486_3_0.txt 87"
    "./result_6chains/node486_3_2.txt 87"
    "./result_6chains/node486_4_0.txt 86"
    "./result_6chains/node486_4_2.txt 86"
    "./result_6chains/node486_5_0.txt 85"
    "./result_6chains/node486_5_2.txt 85"
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

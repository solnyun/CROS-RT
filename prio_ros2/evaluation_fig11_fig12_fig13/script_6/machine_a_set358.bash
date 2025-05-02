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
ros2 run evaluation_3_randomdag uunifast_node -n node358_0_2 -p 19 -st topic358_0_1 -pt None -u 0.03578105601598586 > ./result_6chains/node358_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_1_2 -p 36 -st topic358_1_1 -pt None -u 0.0427047081693554 > ./result_6chains/node358_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_2_2 -p 151 -st topic358_2_1 -pt None -u 0.04933879121031842 > ./result_6chains/node358_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_3_2 -p 410 -st topic358_3_1 -pt None -u 0.003708878688435807 > ./result_6chains/node358_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_4_2 -p 474 -st topic358_4_1 -pt None -u 0.010167382657985405 > ./result_6chains/node358_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_5_2 -p 612 -st topic358_5_1 -pt None -u 0.03400876805217941 > ./result_6chains/node358_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_0_0 -p 19 -st none -pt topic358_0_0 -u 0.021487840195082486 > ./result_6chains/node358_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_1_0 -p 36 -st none -pt topic358_1_0 -u 0.06101766150664195 > ./result_6chains/node358_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_2_0 -p 151 -st none -pt topic358_2_0 -u 0.027834472007563726 > ./result_6chains/node358_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_3_0 -p 410 -st none -pt topic358_3_0 -u 0.0038339137733636175 > ./result_6chains/node358_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_4_0 -p 474 -st none -pt topic358_4_0 -u 0.004542621763156923 > ./result_6chains/node358_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_5_0 -p 612 -st none -pt topic358_5_0 -u 0.04949705688513815 > ./result_6chains/node358_5_0.txt &
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
    "./result_6chains/node358_0_0.txt 90"
    "./result_6chains/node358_0_2.txt 90"
    "./result_6chains/node358_1_0.txt 89"
    "./result_6chains/node358_1_2.txt 89"
    "./result_6chains/node358_2_0.txt 88"
    "./result_6chains/node358_2_2.txt 88"
    "./result_6chains/node358_3_0.txt 87"
    "./result_6chains/node358_3_2.txt 87"
    "./result_6chains/node358_4_0.txt 86"
    "./result_6chains/node358_4_2.txt 86"
    "./result_6chains/node358_5_0.txt 85"
    "./result_6chains/node358_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_2 -p 71 -st topic395_0_1 -pt None -u 0.024879109149106682 > ./result_6chains/node395_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_2 -p 122 -st topic395_1_1 -pt None -u 0.00034247393529512893 > ./result_6chains/node395_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_2 -p 159 -st topic395_2_1 -pt None -u 0.037125508555052394 > ./result_6chains/node395_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_2 -p 184 -st topic395_3_1 -pt None -u 0.05038215866346321 > ./result_6chains/node395_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_2 -p 839 -st topic395_4_1 -pt None -u 0.007109562318260168 > ./result_6chains/node395_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_2 -p 918 -st topic395_5_1 -pt None -u 0.03589991967328852 > ./result_6chains/node395_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_0 -p 71 -st none -pt topic395_0_0 -u 0.006913589468600045 > ./result_6chains/node395_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_0 -p 122 -st none -pt topic395_1_0 -u 0.02534971716142642 > ./result_6chains/node395_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_0 -p 159 -st none -pt topic395_2_0 -u 0.05202904462809427 > ./result_6chains/node395_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_0 -p 184 -st none -pt topic395_3_0 -u 0.00014384111171630853 > ./result_6chains/node395_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_0 -p 839 -st none -pt topic395_4_0 -u 0.022350096820712248 > ./result_6chains/node395_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_0 -p 918 -st none -pt topic395_5_0 -u 0.04495883466632241 > ./result_6chains/node395_5_0.txt &
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
    "./result_6chains/node395_0_0.txt 90"
    "./result_6chains/node395_0_2.txt 90"
    "./result_6chains/node395_1_0.txt 89"
    "./result_6chains/node395_1_2.txt 89"
    "./result_6chains/node395_2_0.txt 88"
    "./result_6chains/node395_2_2.txt 88"
    "./result_6chains/node395_3_0.txt 87"
    "./result_6chains/node395_3_2.txt 87"
    "./result_6chains/node395_4_0.txt 86"
    "./result_6chains/node395_4_2.txt 86"
    "./result_6chains/node395_5_0.txt 85"
    "./result_6chains/node395_5_2.txt 85"
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

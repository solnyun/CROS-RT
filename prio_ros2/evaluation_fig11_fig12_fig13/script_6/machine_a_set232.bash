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
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_2 -p 55 -st topic232_0_1 -pt None -u 0.1135281080130775 > ./result_6chains/node232_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_2 -p 226 -st topic232_1_1 -pt None -u 0.002401994335390345 > ./result_6chains/node232_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_2 -p 663 -st topic232_2_1 -pt None -u 0.028056128788730317 > ./result_6chains/node232_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_2 -p 837 -st topic232_3_1 -pt None -u 0.05494748381095918 > ./result_6chains/node232_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_2 -p 929 -st topic232_4_1 -pt None -u 0.0915779202281728 > ./result_6chains/node232_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_2 -p 963 -st topic232_5_1 -pt None -u 0.004718940409864816 > ./result_6chains/node232_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_0 -p 55 -st none -pt topic232_0_0 -u 0.009709097752418239 > ./result_6chains/node232_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_0 -p 226 -st none -pt topic232_1_0 -u 0.026015393134218023 > ./result_6chains/node232_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_0 -p 663 -st none -pt topic232_2_0 -u 0.04032986981851022 > ./result_6chains/node232_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_0 -p 837 -st none -pt topic232_3_0 -u 0.009318763933500396 > ./result_6chains/node232_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_0 -p 929 -st none -pt topic232_4_0 -u 0.01297454447399829 > ./result_6chains/node232_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_0 -p 963 -st none -pt topic232_5_0 -u 0.0018576400868596105 > ./result_6chains/node232_5_0.txt &
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
    "./result_6chains/node232_0_0.txt 90"
    "./result_6chains/node232_0_2.txt 90"
    "./result_6chains/node232_1_0.txt 89"
    "./result_6chains/node232_1_2.txt 89"
    "./result_6chains/node232_2_0.txt 88"
    "./result_6chains/node232_2_2.txt 88"
    "./result_6chains/node232_3_0.txt 87"
    "./result_6chains/node232_3_2.txt 87"
    "./result_6chains/node232_4_0.txt 86"
    "./result_6chains/node232_4_2.txt 86"
    "./result_6chains/node232_5_0.txt 85"
    "./result_6chains/node232_5_2.txt 85"
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

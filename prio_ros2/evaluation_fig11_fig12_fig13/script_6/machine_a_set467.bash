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
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_2 -p 73 -st topic467_0_1 -pt None -u 0.003694659915528087 > ./result_6chains/node467_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_2 -p 79 -st topic467_1_1 -pt None -u 0.007018393428412373 > ./result_6chains/node467_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_2 -p 195 -st topic467_2_1 -pt None -u 0.007448443809301153 > ./result_6chains/node467_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_2 -p 307 -st topic467_3_1 -pt None -u 0.06537501620615621 > ./result_6chains/node467_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_2 -p 663 -st topic467_4_1 -pt None -u 0.0367009681806868 > ./result_6chains/node467_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_2 -p 947 -st topic467_5_1 -pt None -u 0.01854026930175836 > ./result_6chains/node467_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_0 -p 73 -st none -pt topic467_0_0 -u 0.0370197170514609 > ./result_6chains/node467_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_0 -p 79 -st none -pt topic467_1_0 -u 0.007155110574846191 > ./result_6chains/node467_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_0 -p 195 -st none -pt topic467_2_0 -u 0.004309027406097343 > ./result_6chains/node467_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_0 -p 307 -st none -pt topic467_3_0 -u 0.0638176924341814 > ./result_6chains/node467_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_0 -p 663 -st none -pt topic467_4_0 -u 0.013735199660090514 > ./result_6chains/node467_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_0 -p 947 -st none -pt topic467_5_0 -u 0.02915528138575159 > ./result_6chains/node467_5_0.txt &
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
    "./result_6chains/node467_0_0.txt 90"
    "./result_6chains/node467_0_2.txt 90"
    "./result_6chains/node467_1_0.txt 89"
    "./result_6chains/node467_1_2.txt 89"
    "./result_6chains/node467_2_0.txt 88"
    "./result_6chains/node467_2_2.txt 88"
    "./result_6chains/node467_3_0.txt 87"
    "./result_6chains/node467_3_2.txt 87"
    "./result_6chains/node467_4_0.txt 86"
    "./result_6chains/node467_4_2.txt 86"
    "./result_6chains/node467_5_0.txt 85"
    "./result_6chains/node467_5_2.txt 85"
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

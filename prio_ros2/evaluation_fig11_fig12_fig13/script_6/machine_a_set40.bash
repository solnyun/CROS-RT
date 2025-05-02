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
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_2 -p 357 -st topic40_0_1 -pt None -u 0.026245523519456526 > ./result_6chains/node40_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_2 -p 428 -st topic40_1_1 -pt None -u 0.012302195926736481 > ./result_6chains/node40_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_2 -p 513 -st topic40_2_1 -pt None -u 0.046145490654786625 > ./result_6chains/node40_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_2 -p 611 -st topic40_3_1 -pt None -u 0.002531576669145996 > ./result_6chains/node40_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_2 -p 707 -st topic40_4_1 -pt None -u 0.05840327771557613 > ./result_6chains/node40_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_2 -p 825 -st topic40_5_1 -pt None -u 0.013543272799241961 > ./result_6chains/node40_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_0 -p 357 -st none -pt topic40_0_0 -u 0.008763713622122193 > ./result_6chains/node40_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_0 -p 428 -st none -pt topic40_1_0 -u 0.008750198396681896 > ./result_6chains/node40_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_0 -p 513 -st none -pt topic40_2_0 -u 0.04345060705391329 > ./result_6chains/node40_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_0 -p 611 -st none -pt topic40_3_0 -u 0.0354492251077089 > ./result_6chains/node40_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_0 -p 707 -st none -pt topic40_4_0 -u 0.05079627486017363 > ./result_6chains/node40_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_0 -p 825 -st none -pt topic40_5_0 -u 0.022921197611488295 > ./result_6chains/node40_5_0.txt &
sleep 10
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
    "./result_6chains/node40_0_0.txt 90"
    "./result_6chains/node40_0_2.txt 90"
    "./result_6chains/node40_1_0.txt 89"
    "./result_6chains/node40_1_2.txt 89"
    "./result_6chains/node40_2_0.txt 88"
    "./result_6chains/node40_2_2.txt 88"
    "./result_6chains/node40_3_0.txt 87"
    "./result_6chains/node40_3_2.txt 87"
    "./result_6chains/node40_4_0.txt 86"
    "./result_6chains/node40_4_2.txt 86"
    "./result_6chains/node40_5_0.txt 85"
    "./result_6chains/node40_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

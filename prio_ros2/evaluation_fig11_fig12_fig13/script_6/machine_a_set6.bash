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
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_2 -p 240 -st topic6_0_1 -pt None -u 0.00026795816561137054 > ./result_6chains/node6_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_2 -p 243 -st topic6_1_1 -pt None -u 0.005932790092135487 > ./result_6chains/node6_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_2 -p 287 -st topic6_2_1 -pt None -u 0.003779393311356266 > ./result_6chains/node6_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_2 -p 311 -st topic6_3_1 -pt None -u 0.08874926065435976 > ./result_6chains/node6_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_2 -p 360 -st topic6_4_1 -pt None -u 0.0006969795915483662 > ./result_6chains/node6_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_2 -p 426 -st topic6_5_1 -pt None -u 0.0045238474049177175 > ./result_6chains/node6_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_0_0 -p 240 -st none -pt topic6_0_0 -u 0.00130701596388616 > ./result_6chains/node6_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_1_0 -p 243 -st none -pt topic6_1_0 -u 0.037899576553108494 > ./result_6chains/node6_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_2_0 -p 287 -st none -pt topic6_2_0 -u 0.05218037762168287 > ./result_6chains/node6_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_3_0 -p 311 -st none -pt topic6_3_0 -u 0.008928222830500127 > ./result_6chains/node6_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node6_4_0 -p 360 -st none -pt topic6_4_0 -u 0.024485304185219936 > ./result_6chains/node6_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node6_5_0 -p 426 -st none -pt topic6_5_0 -u 0.0417525805345041 > ./result_6chains/node6_5_0.txt &
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
    "./result_6chains/node6_0_0.txt 90"
    "./result_6chains/node6_0_2.txt 90"
    "./result_6chains/node6_1_0.txt 89"
    "./result_6chains/node6_1_2.txt 89"
    "./result_6chains/node6_2_0.txt 88"
    "./result_6chains/node6_2_2.txt 88"
    "./result_6chains/node6_3_0.txt 87"
    "./result_6chains/node6_3_2.txt 87"
    "./result_6chains/node6_4_0.txt 86"
    "./result_6chains/node6_4_2.txt 86"
    "./result_6chains/node6_5_0.txt 85"
    "./result_6chains/node6_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node458_0_2 -p 74 -st topic458_0_1 -pt None -u 0.06818114796442071 > ./result_6chains/node458_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_1_2 -p 157 -st topic458_1_1 -pt None -u 0.006927744267591018 > ./result_6chains/node458_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_2_2 -p 209 -st topic458_2_1 -pt None -u 0.009278698749898229 > ./result_6chains/node458_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_3_2 -p 391 -st topic458_3_1 -pt None -u 0.05400985879663758 > ./result_6chains/node458_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_4_2 -p 563 -st topic458_4_1 -pt None -u 0.1096095648511826 > ./result_6chains/node458_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_5_2 -p 919 -st topic458_5_1 -pt None -u 0.0058036952207117035 > ./result_6chains/node458_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_0_0 -p 74 -st none -pt topic458_0_0 -u 0.01591964434205123 > ./result_6chains/node458_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_1_0 -p 157 -st none -pt topic458_1_0 -u 0.02524296661444203 > ./result_6chains/node458_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_2_0 -p 209 -st none -pt topic458_2_0 -u 0.03737925493212235 > ./result_6chains/node458_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_3_0 -p 391 -st none -pt topic458_3_0 -u 0.0025798904559661273 > ./result_6chains/node458_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_4_0 -p 563 -st none -pt topic458_4_0 -u 0.010456003399714253 > ./result_6chains/node458_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_5_0 -p 919 -st none -pt topic458_5_0 -u 0.007977543960799421 > ./result_6chains/node458_5_0.txt &
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
    "./result_6chains/node458_0_0.txt 90"
    "./result_6chains/node458_0_2.txt 90"
    "./result_6chains/node458_1_0.txt 89"
    "./result_6chains/node458_1_2.txt 89"
    "./result_6chains/node458_2_0.txt 88"
    "./result_6chains/node458_2_2.txt 88"
    "./result_6chains/node458_3_0.txt 87"
    "./result_6chains/node458_3_2.txt 87"
    "./result_6chains/node458_4_0.txt 86"
    "./result_6chains/node458_4_2.txt 86"
    "./result_6chains/node458_5_0.txt 85"
    "./result_6chains/node458_5_2.txt 85"
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

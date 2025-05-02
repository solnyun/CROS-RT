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
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_2 -p 320 -st topic322_0_1 -pt None -u 0.014368718360250776 > ./result_6chains/node322_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_2 -p 418 -st topic322_1_1 -pt None -u 0.05106654454527948 > ./result_6chains/node322_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_2 -p 468 -st topic322_2_1 -pt None -u 0.06855310259100819 > ./result_6chains/node322_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_2 -p 676 -st topic322_3_1 -pt None -u 0.009191415142390219 > ./result_6chains/node322_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_2 -p 778 -st topic322_4_1 -pt None -u 0.039779006579590534 > ./result_6chains/node322_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_2 -p 967 -st topic322_5_1 -pt None -u 0.02894118581043923 > ./result_6chains/node322_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_0_0 -p 320 -st none -pt topic322_0_0 -u 0.003940217803445445 > ./result_6chains/node322_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_1_0 -p 418 -st none -pt topic322_1_0 -u 0.02942241854472638 > ./result_6chains/node322_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_2_0 -p 468 -st none -pt topic322_2_0 -u 0.047224413972346224 > ./result_6chains/node322_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_3_0 -p 676 -st none -pt topic322_3_0 -u 0.03118913069471954 > ./result_6chains/node322_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node322_4_0 -p 778 -st none -pt topic322_4_0 -u 0.009556350308543737 > ./result_6chains/node322_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node322_5_0 -p 967 -st none -pt topic322_5_0 -u 0.030505808544848335 > ./result_6chains/node322_5_0.txt &
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
    "./result_6chains/node322_0_0.txt 90"
    "./result_6chains/node322_0_2.txt 90"
    "./result_6chains/node322_1_0.txt 89"
    "./result_6chains/node322_1_2.txt 89"
    "./result_6chains/node322_2_0.txt 88"
    "./result_6chains/node322_2_2.txt 88"
    "./result_6chains/node322_3_0.txt 87"
    "./result_6chains/node322_3_2.txt 87"
    "./result_6chains/node322_4_0.txt 86"
    "./result_6chains/node322_4_2.txt 86"
    "./result_6chains/node322_5_0.txt 85"
    "./result_6chains/node322_5_2.txt 85"
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

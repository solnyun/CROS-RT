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
ros2 run evaluation_3_randomdag uunifast_node -n node215_0_2 -p 188 -st topic215_0_1 -pt None -u 0.016055787923716258 > ./result_6chains/node215_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_1_2 -p 505 -st topic215_1_1 -pt None -u 0.012787459031926962 > ./result_6chains/node215_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_2_2 -p 543 -st topic215_2_1 -pt None -u 0.0058824086731461 > ./result_6chains/node215_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_3_2 -p 563 -st topic215_3_1 -pt None -u 0.08433889158555659 > ./result_6chains/node215_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_4_2 -p 771 -st topic215_4_1 -pt None -u 0.006060902139711777 > ./result_6chains/node215_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_5_2 -p 943 -st topic215_5_1 -pt None -u 0.019609512085316385 > ./result_6chains/node215_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_0_0 -p 188 -st none -pt topic215_0_0 -u 0.005380328112760957 > ./result_6chains/node215_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_1_0 -p 505 -st none -pt topic215_1_0 -u 0.03711980929005332 > ./result_6chains/node215_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_2_0 -p 543 -st none -pt topic215_2_0 -u 0.09275353773254724 > ./result_6chains/node215_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_3_0 -p 563 -st none -pt topic215_3_0 -u 0.011035125809669644 > ./result_6chains/node215_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_4_0 -p 771 -st none -pt topic215_4_0 -u 0.06539716396108666 > ./result_6chains/node215_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_5_0 -p 943 -st none -pt topic215_5_0 -u 0.0023936383233897525 > ./result_6chains/node215_5_0.txt &
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
    "./result_6chains/node215_0_0.txt 90"
    "./result_6chains/node215_0_2.txt 90"
    "./result_6chains/node215_1_0.txt 89"
    "./result_6chains/node215_1_2.txt 89"
    "./result_6chains/node215_2_0.txt 88"
    "./result_6chains/node215_2_2.txt 88"
    "./result_6chains/node215_3_0.txt 87"
    "./result_6chains/node215_3_2.txt 87"
    "./result_6chains/node215_4_0.txt 86"
    "./result_6chains/node215_4_2.txt 86"
    "./result_6chains/node215_5_0.txt 85"
    "./result_6chains/node215_5_2.txt 85"
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

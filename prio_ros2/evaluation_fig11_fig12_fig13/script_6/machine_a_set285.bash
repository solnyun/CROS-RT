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
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_2 -p 205 -st topic285_0_1 -pt None -u 0.029084392843742812 > ./result_6chains/node285_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_2 -p 269 -st topic285_1_1 -pt None -u 0.009594058101326186 > ./result_6chains/node285_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_2 -p 585 -st topic285_2_1 -pt None -u 0.06097814562953274 > ./result_6chains/node285_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_2 -p 817 -st topic285_3_1 -pt None -u 0.022615628660247078 > ./result_6chains/node285_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_2 -p 871 -st topic285_4_1 -pt None -u 0.01695077003064001 > ./result_6chains/node285_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_2 -p 961 -st topic285_5_1 -pt None -u 0.020461967651389946 > ./result_6chains/node285_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_0_0 -p 205 -st none -pt topic285_0_0 -u 0.034886353511252244 > ./result_6chains/node285_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_1_0 -p 269 -st none -pt topic285_1_0 -u 0.0003249408007403032 > ./result_6chains/node285_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_2_0 -p 585 -st none -pt topic285_2_0 -u 0.04969799082547505 > ./result_6chains/node285_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_3_0 -p 817 -st none -pt topic285_3_0 -u 0.009759427620301991 > ./result_6chains/node285_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node285_4_0 -p 871 -st none -pt topic285_4_0 -u 0.015161942631526981 > ./result_6chains/node285_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node285_5_0 -p 961 -st none -pt topic285_5_0 -u 0.03463594449886785 > ./result_6chains/node285_5_0.txt &
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
    "./result_6chains/node285_0_0.txt 90"
    "./result_6chains/node285_0_2.txt 90"
    "./result_6chains/node285_1_0.txt 89"
    "./result_6chains/node285_1_2.txt 89"
    "./result_6chains/node285_2_0.txt 88"
    "./result_6chains/node285_2_2.txt 88"
    "./result_6chains/node285_3_0.txt 87"
    "./result_6chains/node285_3_2.txt 87"
    "./result_6chains/node285_4_0.txt 86"
    "./result_6chains/node285_4_2.txt 86"
    "./result_6chains/node285_5_0.txt 85"
    "./result_6chains/node285_5_2.txt 85"
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

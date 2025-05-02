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
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_2 -p 155 -st topic154_0_1 -pt None -u 0.049392578720673486 > ./result_6chains/node154_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_2 -p 340 -st topic154_1_1 -pt None -u 0.041558724490954047 > ./result_6chains/node154_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_2 -p 420 -st topic154_2_1 -pt None -u 0.0023506007273115803 > ./result_6chains/node154_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_2 -p 467 -st topic154_3_1 -pt None -u 0.0034095875230071016 > ./result_6chains/node154_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_2 -p 884 -st topic154_4_1 -pt None -u 0.03171564735410126 > ./result_6chains/node154_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_2 -p 896 -st topic154_5_1 -pt None -u 0.02852726327422068 > ./result_6chains/node154_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_0 -p 155 -st none -pt topic154_0_0 -u 0.03306005726441952 > ./result_6chains/node154_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_0 -p 340 -st none -pt topic154_1_0 -u 0.021879285907345836 > ./result_6chains/node154_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_0 -p 420 -st none -pt topic154_2_0 -u 0.02048401664496924 > ./result_6chains/node154_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_0 -p 467 -st none -pt topic154_3_0 -u 0.030667522346721793 > ./result_6chains/node154_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_0 -p 884 -st none -pt topic154_4_0 -u 0.0771996718551625 > ./result_6chains/node154_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_0 -p 896 -st none -pt topic154_5_0 -u 0.0025546569960129134 > ./result_6chains/node154_5_0.txt &
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
    "./result_6chains/node154_0_0.txt 90"
    "./result_6chains/node154_0_2.txt 90"
    "./result_6chains/node154_1_0.txt 89"
    "./result_6chains/node154_1_2.txt 89"
    "./result_6chains/node154_2_0.txt 88"
    "./result_6chains/node154_2_2.txt 88"
    "./result_6chains/node154_3_0.txt 87"
    "./result_6chains/node154_3_2.txt 87"
    "./result_6chains/node154_4_0.txt 86"
    "./result_6chains/node154_4_2.txt 86"
    "./result_6chains/node154_5_0.txt 85"
    "./result_6chains/node154_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node71_0_2 -p 25 -st topic71_0_1 -pt None -u 0.035557513002075214 > ./result_6chains/node71_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_1_2 -p 134 -st topic71_1_1 -pt None -u 0.003572488663382112 > ./result_6chains/node71_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_2_2 -p 453 -st topic71_2_1 -pt None -u 4.301540388956804e-05 > ./result_6chains/node71_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_3_2 -p 727 -st topic71_3_1 -pt None -u 0.036187073729469554 > ./result_6chains/node71_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_4_2 -p 841 -st topic71_4_1 -pt None -u 0.0002927062105717859 > ./result_6chains/node71_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_5_2 -p 881 -st topic71_5_1 -pt None -u 0.010976859292531324 > ./result_6chains/node71_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_0_0 -p 25 -st none -pt topic71_0_0 -u 0.026841596623779496 > ./result_6chains/node71_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_1_0 -p 134 -st none -pt topic71_1_0 -u 0.003983417434799297 > ./result_6chains/node71_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_2_0 -p 453 -st none -pt topic71_2_0 -u 0.11429660397115743 > ./result_6chains/node71_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_3_0 -p 727 -st none -pt topic71_3_0 -u 0.029158767965899918 > ./result_6chains/node71_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node71_4_0 -p 841 -st none -pt topic71_4_0 -u 0.0037459325651846703 > ./result_6chains/node71_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node71_5_0 -p 881 -st none -pt topic71_5_0 -u 0.029019883970209027 > ./result_6chains/node71_5_0.txt &
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
    "./result_6chains/node71_0_0.txt 90"
    "./result_6chains/node71_0_2.txt 90"
    "./result_6chains/node71_1_0.txt 89"
    "./result_6chains/node71_1_2.txt 89"
    "./result_6chains/node71_2_0.txt 88"
    "./result_6chains/node71_2_2.txt 88"
    "./result_6chains/node71_3_0.txt 87"
    "./result_6chains/node71_3_2.txt 87"
    "./result_6chains/node71_4_0.txt 86"
    "./result_6chains/node71_4_2.txt 86"
    "./result_6chains/node71_5_0.txt 85"
    "./result_6chains/node71_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_2 -p 33 -st topic270_0_1 -pt None -u 0.032046565807402394 > ./result_8chains/node270_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_2 -p 50 -st topic270_1_1 -pt None -u 0.0640716573575753 > ./result_8chains/node270_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_2 -p 119 -st topic270_2_1 -pt None -u 0.00807229689728034 > ./result_8chains/node270_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_2 -p 150 -st topic270_3_1 -pt None -u 0.03792824966479408 > ./result_8chains/node270_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_2 -p 541 -st topic270_4_1 -pt None -u 0.03904976455883577 > ./result_8chains/node270_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_2 -p 629 -st topic270_5_1 -pt None -u 0.006064715450115235 > ./result_8chains/node270_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_6_2 -p 668 -st topic270_6_1 -pt None -u 0.00376355089492305 > ./result_8chains/node270_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_7_2 -p 820 -st topic270_7_1 -pt None -u 0.006721388957344401 > ./result_8chains/node270_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_0 -p 33 -st none -pt topic270_0_0 -u 0.01794019317386042 > ./result_8chains/node270_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_0 -p 50 -st none -pt topic270_1_0 -u 0.030494848003955743 > ./result_8chains/node270_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_0 -p 119 -st none -pt topic270_2_0 -u 0.045179163484702134 > ./result_8chains/node270_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_0 -p 150 -st none -pt topic270_3_0 -u 0.018087153419050928 > ./result_8chains/node270_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_0 -p 541 -st none -pt topic270_4_0 -u 0.024025354829804335 > ./result_8chains/node270_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_0 -p 629 -st none -pt topic270_5_0 -u 0.006825362486522518 > ./result_8chains/node270_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_6_0 -p 668 -st none -pt topic270_6_0 -u 0.018035284193989788 > ./result_8chains/node270_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_7_0 -p 820 -st none -pt topic270_7_0 -u 0.006730577145404975 > ./result_8chains/node270_7_0.txt &
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
    "./result_8chains/node270_0_0.txt 90"
    "./result_8chains/node270_0_2.txt 90"
    "./result_8chains/node270_1_0.txt 89"
    "./result_8chains/node270_1_2.txt 89"
    "./result_8chains/node270_2_0.txt 88"
    "./result_8chains/node270_2_2.txt 88"
    "./result_8chains/node270_3_0.txt 87"
    "./result_8chains/node270_3_2.txt 87"
    "./result_8chains/node270_4_0.txt 86"
    "./result_8chains/node270_4_2.txt 86"
    "./result_8chains/node270_5_0.txt 85"
    "./result_8chains/node270_5_2.txt 85"
    "./result_8chains/node270_6_0.txt 84"
    "./result_8chains/node270_6_2.txt 84"
    "./result_8chains/node270_7_0.txt 83"
    "./result_8chains/node270_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

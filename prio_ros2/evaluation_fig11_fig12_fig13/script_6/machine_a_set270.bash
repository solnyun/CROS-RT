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
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_2 -p 86 -st topic270_0_1 -pt None -u 0.01830939898839634 > ./result_6chains/node270_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_2 -p 117 -st topic270_1_1 -pt None -u 0.01563992390235508 > ./result_6chains/node270_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_2 -p 654 -st topic270_2_1 -pt None -u 0.02706310531891365 > ./result_6chains/node270_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_2 -p 735 -st topic270_3_1 -pt None -u 0.009404308559463975 > ./result_6chains/node270_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_2 -p 754 -st topic270_4_1 -pt None -u 0.05036227812816646 > ./result_6chains/node270_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_2 -p 943 -st topic270_5_1 -pt None -u 0.00409028477726583 > ./result_6chains/node270_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_0_0 -p 86 -st none -pt topic270_0_0 -u 0.04174365308626865 > ./result_6chains/node270_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_1_0 -p 117 -st none -pt topic270_1_0 -u 0.0012722033743949313 > ./result_6chains/node270_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_2_0 -p 654 -st none -pt topic270_2_0 -u 0.014879838319941052 > ./result_6chains/node270_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_3_0 -p 735 -st none -pt topic270_3_0 -u 0.004854116348599724 > ./result_6chains/node270_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node270_4_0 -p 754 -st none -pt topic270_4_0 -u 0.010209967585942836 > ./result_6chains/node270_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node270_5_0 -p 943 -st none -pt topic270_5_0 -u 0.023606646026463327 > ./result_6chains/node270_5_0.txt &
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
    "./result_6chains/node270_0_0.txt 90"
    "./result_6chains/node270_0_2.txt 90"
    "./result_6chains/node270_1_0.txt 89"
    "./result_6chains/node270_1_2.txt 89"
    "./result_6chains/node270_2_0.txt 88"
    "./result_6chains/node270_2_2.txt 88"
    "./result_6chains/node270_3_0.txt 87"
    "./result_6chains/node270_3_2.txt 87"
    "./result_6chains/node270_4_0.txt 86"
    "./result_6chains/node270_4_2.txt 86"
    "./result_6chains/node270_5_0.txt 85"
    "./result_6chains/node270_5_2.txt 85"
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

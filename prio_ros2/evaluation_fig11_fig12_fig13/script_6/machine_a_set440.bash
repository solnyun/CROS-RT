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
ros2 run evaluation_3_randomdag uunifast_node -n node440_0_2 -p 139 -st topic440_0_1 -pt None -u 0.029697552155371676 > ./result_6chains/node440_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_1_2 -p 680 -st topic440_1_1 -pt None -u 0.003907536842168879 > ./result_6chains/node440_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_2_2 -p 752 -st topic440_2_1 -pt None -u 0.11267570698622631 > ./result_6chains/node440_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_3_2 -p 801 -st topic440_3_1 -pt None -u 0.04176288576582893 > ./result_6chains/node440_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_4_2 -p 958 -st topic440_4_1 -pt None -u 0.04537728816616793 > ./result_6chains/node440_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_5_2 -p 989 -st topic440_5_1 -pt None -u 0.09365754081364353 > ./result_6chains/node440_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_0_0 -p 139 -st none -pt topic440_0_0 -u 0.01125473279562439 > ./result_6chains/node440_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_1_0 -p 680 -st none -pt topic440_1_0 -u 0.0018501992198485806 > ./result_6chains/node440_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_2_0 -p 752 -st none -pt topic440_2_0 -u 0.0030056888389228265 > ./result_6chains/node440_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_3_0 -p 801 -st none -pt topic440_3_0 -u 0.011720235332051687 > ./result_6chains/node440_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node440_4_0 -p 958 -st none -pt topic440_4_0 -u 0.02617518169382796 > ./result_6chains/node440_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node440_5_0 -p 989 -st none -pt topic440_5_0 -u 0.0011922108307784451 > ./result_6chains/node440_5_0.txt &
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
    "./result_6chains/node440_0_0.txt 90"
    "./result_6chains/node440_0_2.txt 90"
    "./result_6chains/node440_1_0.txt 89"
    "./result_6chains/node440_1_2.txt 89"
    "./result_6chains/node440_2_0.txt 88"
    "./result_6chains/node440_2_2.txt 88"
    "./result_6chains/node440_3_0.txt 87"
    "./result_6chains/node440_3_2.txt 87"
    "./result_6chains/node440_4_0.txt 86"
    "./result_6chains/node440_4_2.txt 86"
    "./result_6chains/node440_5_0.txt 85"
    "./result_6chains/node440_5_2.txt 85"
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

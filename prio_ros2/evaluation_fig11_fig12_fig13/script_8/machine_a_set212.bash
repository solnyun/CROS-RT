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
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_2 -p 101 -st topic212_0_1 -pt None -u 0.023916401921315222 > ./result_8chains/node212_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_2 -p 233 -st topic212_1_1 -pt None -u 0.003711496729947139 > ./result_8chains/node212_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_2 -p 240 -st topic212_2_1 -pt None -u 0.007354060436015775 > ./result_8chains/node212_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_2 -p 372 -st topic212_3_1 -pt None -u 0.004701969736549294 > ./result_8chains/node212_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_2 -p 419 -st topic212_4_1 -pt None -u 0.0023825141589336185 > ./result_8chains/node212_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_2 -p 420 -st topic212_5_1 -pt None -u 0.07927366055930019 > ./result_8chains/node212_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_6_2 -p 879 -st topic212_6_1 -pt None -u 0.029786205232508564 > ./result_8chains/node212_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_7_2 -p 905 -st topic212_7_1 -pt None -u 0.04760067134062066 > ./result_8chains/node212_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_0_0 -p 101 -st none -pt topic212_0_0 -u 0.02990946110448911 > ./result_8chains/node212_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_1_0 -p 233 -st none -pt topic212_1_0 -u 0.014319117657994818 > ./result_8chains/node212_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_2_0 -p 240 -st none -pt topic212_2_0 -u 0.021152649862776596 > ./result_8chains/node212_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_3_0 -p 372 -st none -pt topic212_3_0 -u 0.04763337795047412 > ./result_8chains/node212_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_4_0 -p 419 -st none -pt topic212_4_0 -u 0.04839543566430421 > ./result_8chains/node212_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_5_0 -p 420 -st none -pt topic212_5_0 -u 0.012072267852710039 > ./result_8chains/node212_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node212_6_0 -p 879 -st none -pt topic212_6_0 -u 0.0023766518403932485 > ./result_8chains/node212_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node212_7_0 -p 905 -st none -pt topic212_7_0 -u 0.024501838751298827 > ./result_8chains/node212_7_0.txt &
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
    "./result_8chains/node212_0_0.txt 90"
    "./result_8chains/node212_0_2.txt 90"
    "./result_8chains/node212_1_0.txt 89"
    "./result_8chains/node212_1_2.txt 89"
    "./result_8chains/node212_2_0.txt 88"
    "./result_8chains/node212_2_2.txt 88"
    "./result_8chains/node212_3_0.txt 87"
    "./result_8chains/node212_3_2.txt 87"
    "./result_8chains/node212_4_0.txt 86"
    "./result_8chains/node212_4_2.txt 86"
    "./result_8chains/node212_5_0.txt 85"
    "./result_8chains/node212_5_2.txt 85"
    "./result_8chains/node212_6_0.txt 84"
    "./result_8chains/node212_6_2.txt 84"
    "./result_8chains/node212_7_0.txt 83"
    "./result_8chains/node212_7_2.txt 83"
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

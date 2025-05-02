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
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_2 -p 120 -st topic151_0_1 -pt None -u 0.05722256519695412 > ./result_6chains/node151_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_2 -p 169 -st topic151_1_1 -pt None -u 0.01179667031870113 > ./result_6chains/node151_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_2 -p 298 -st topic151_2_1 -pt None -u 0.022216269403529942 > ./result_6chains/node151_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_2 -p 434 -st topic151_3_1 -pt None -u 0.029412255550373537 > ./result_6chains/node151_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_2 -p 481 -st topic151_4_1 -pt None -u 0.007980352547015776 > ./result_6chains/node151_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_2 -p 875 -st topic151_5_1 -pt None -u 0.006072269558056576 > ./result_6chains/node151_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_0_0 -p 120 -st none -pt topic151_0_0 -u 0.021705586931109633 > ./result_6chains/node151_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_1_0 -p 169 -st none -pt topic151_1_0 -u 0.0025645542788552134 > ./result_6chains/node151_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_2_0 -p 298 -st none -pt topic151_2_0 -u 0.01158792745324061 > ./result_6chains/node151_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_3_0 -p 434 -st none -pt topic151_3_0 -u 0.10811879231822277 > ./result_6chains/node151_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node151_4_0 -p 481 -st none -pt topic151_4_0 -u 0.0058370306096287745 > ./result_6chains/node151_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node151_5_0 -p 875 -st none -pt topic151_5_0 -u 0.008994820211292274 > ./result_6chains/node151_5_0.txt &
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
    "./result_6chains/node151_0_0.txt 90"
    "./result_6chains/node151_0_2.txt 90"
    "./result_6chains/node151_1_0.txt 89"
    "./result_6chains/node151_1_2.txt 89"
    "./result_6chains/node151_2_0.txt 88"
    "./result_6chains/node151_2_2.txt 88"
    "./result_6chains/node151_3_0.txt 87"
    "./result_6chains/node151_3_2.txt 87"
    "./result_6chains/node151_4_0.txt 86"
    "./result_6chains/node151_4_2.txt 86"
    "./result_6chains/node151_5_0.txt 85"
    "./result_6chains/node151_5_2.txt 85"
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

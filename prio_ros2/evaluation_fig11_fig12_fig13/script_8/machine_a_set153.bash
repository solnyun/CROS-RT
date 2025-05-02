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
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_2 -p 80 -st topic153_0_1 -pt None -u 0.0437383058779206 > ./result_8chains/node153_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_2 -p 83 -st topic153_1_1 -pt None -u 0.0174432910730678 > ./result_8chains/node153_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_2 -p 169 -st topic153_2_1 -pt None -u 0.038253218328883565 > ./result_8chains/node153_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_2 -p 366 -st topic153_3_1 -pt None -u 0.023840587917138528 > ./result_8chains/node153_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_2 -p 770 -st topic153_4_1 -pt None -u 0.017542415982536114 > ./result_8chains/node153_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_2 -p 837 -st topic153_5_1 -pt None -u 0.0011083413129744646 > ./result_8chains/node153_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_6_2 -p 960 -st topic153_6_1 -pt None -u 0.005268773724047174 > ./result_8chains/node153_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_7_2 -p 990 -st topic153_7_1 -pt None -u 0.016612235856631196 > ./result_8chains/node153_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_0 -p 80 -st none -pt topic153_0_0 -u 0.015417864444359441 > ./result_8chains/node153_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_0 -p 83 -st none -pt topic153_1_0 -u 0.016264641207576813 > ./result_8chains/node153_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_0 -p 169 -st none -pt topic153_2_0 -u 0.00782295531306193 > ./result_8chains/node153_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_0 -p 366 -st none -pt topic153_3_0 -u 0.04271828293856994 > ./result_8chains/node153_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_0 -p 770 -st none -pt topic153_4_0 -u 0.01604152085647595 > ./result_8chains/node153_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_0 -p 837 -st none -pt topic153_5_0 -u 0.033536637488555315 > ./result_8chains/node153_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_6_0 -p 960 -st none -pt topic153_6_0 -u 0.005469627785449585 > ./result_8chains/node153_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_7_0 -p 990 -st none -pt topic153_7_0 -u 0.008160814432230969 > ./result_8chains/node153_7_0.txt &
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
    "./result_8chains/node153_0_0.txt 90"
    "./result_8chains/node153_0_2.txt 90"
    "./result_8chains/node153_1_0.txt 89"
    "./result_8chains/node153_1_2.txt 89"
    "./result_8chains/node153_2_0.txt 88"
    "./result_8chains/node153_2_2.txt 88"
    "./result_8chains/node153_3_0.txt 87"
    "./result_8chains/node153_3_2.txt 87"
    "./result_8chains/node153_4_0.txt 86"
    "./result_8chains/node153_4_2.txt 86"
    "./result_8chains/node153_5_0.txt 85"
    "./result_8chains/node153_5_2.txt 85"
    "./result_8chains/node153_6_0.txt 84"
    "./result_8chains/node153_6_2.txt 84"
    "./result_8chains/node153_7_0.txt 83"
    "./result_8chains/node153_7_2.txt 83"
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

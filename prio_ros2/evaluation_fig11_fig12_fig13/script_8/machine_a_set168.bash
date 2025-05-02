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
ros2 run evaluation_3_randomdag uunifast_node -n node168_0_2 -p 24 -st topic168_0_1 -pt None -u 0.010017082808158329 > ./result_8chains/node168_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_1_2 -p 55 -st topic168_1_1 -pt None -u 0.013171804078882798 > ./result_8chains/node168_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_2_2 -p 177 -st topic168_2_1 -pt None -u 0.04225485230202802 > ./result_8chains/node168_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_3_2 -p 181 -st topic168_3_1 -pt None -u 0.022888544399866012 > ./result_8chains/node168_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_4_2 -p 356 -st topic168_4_1 -pt None -u 0.0004081031418070036 > ./result_8chains/node168_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_5_2 -p 626 -st topic168_5_1 -pt None -u 0.0028475309908514435 > ./result_8chains/node168_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_6_2 -p 775 -st topic168_6_1 -pt None -u 0.0469735058926106 > ./result_8chains/node168_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_7_2 -p 989 -st topic168_7_1 -pt None -u 0.012735277591041635 > ./result_8chains/node168_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_0_0 -p 24 -st none -pt topic168_0_0 -u 0.020597768002763917 > ./result_8chains/node168_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_1_0 -p 55 -st none -pt topic168_1_0 -u 0.06796745491303169 > ./result_8chains/node168_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_2_0 -p 177 -st none -pt topic168_2_0 -u 0.042622570032122276 > ./result_8chains/node168_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_3_0 -p 181 -st none -pt topic168_3_0 -u 0.00955861344062392 > ./result_8chains/node168_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_4_0 -p 356 -st none -pt topic168_4_0 -u 0.016502767772017285 > ./result_8chains/node168_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_5_0 -p 626 -st none -pt topic168_5_0 -u 0.023895188139184204 > ./result_8chains/node168_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node168_6_0 -p 775 -st none -pt topic168_6_0 -u 0.044341678746357485 > ./result_8chains/node168_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node168_7_0 -p 989 -st none -pt topic168_7_0 -u 0.018626471858522 > ./result_8chains/node168_7_0.txt &
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
    "./result_8chains/node168_0_0.txt 90"
    "./result_8chains/node168_0_2.txt 90"
    "./result_8chains/node168_1_0.txt 89"
    "./result_8chains/node168_1_2.txt 89"
    "./result_8chains/node168_2_0.txt 88"
    "./result_8chains/node168_2_2.txt 88"
    "./result_8chains/node168_3_0.txt 87"
    "./result_8chains/node168_3_2.txt 87"
    "./result_8chains/node168_4_0.txt 86"
    "./result_8chains/node168_4_2.txt 86"
    "./result_8chains/node168_5_0.txt 85"
    "./result_8chains/node168_5_2.txt 85"
    "./result_8chains/node168_6_0.txt 84"
    "./result_8chains/node168_6_2.txt 84"
    "./result_8chains/node168_7_0.txt 83"
    "./result_8chains/node168_7_2.txt 83"
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

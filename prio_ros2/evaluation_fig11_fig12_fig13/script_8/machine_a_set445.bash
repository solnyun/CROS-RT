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
ros2 run evaluation_3_randomdag uunifast_node -n node445_0_2 -p 26 -st topic445_0_1 -pt None -u 0.006423412483523738 > ./result_8chains/node445_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_1_2 -p 98 -st topic445_1_1 -pt None -u 0.007862808832550638 > ./result_8chains/node445_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_2_2 -p 227 -st topic445_2_1 -pt None -u 0.006055107908580437 > ./result_8chains/node445_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_3_2 -p 262 -st topic445_3_1 -pt None -u 0.015074222123258652 > ./result_8chains/node445_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_4_2 -p 364 -st topic445_4_1 -pt None -u 0.016157290656932305 > ./result_8chains/node445_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_5_2 -p 759 -st topic445_5_1 -pt None -u 0.008521140343931297 > ./result_8chains/node445_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_6_2 -p 867 -st topic445_6_1 -pt None -u 0.04383384188873307 > ./result_8chains/node445_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_7_2 -p 904 -st topic445_7_1 -pt None -u 0.008518831784246148 > ./result_8chains/node445_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_0_0 -p 26 -st none -pt topic445_0_0 -u 0.05480531672805744 > ./result_8chains/node445_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_1_0 -p 98 -st none -pt topic445_1_0 -u 0.0015173799078963546 > ./result_8chains/node445_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_2_0 -p 227 -st none -pt topic445_2_0 -u 0.015682786292360196 > ./result_8chains/node445_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_3_0 -p 262 -st none -pt topic445_3_0 -u 0.015730091135431945 > ./result_8chains/node445_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_4_0 -p 364 -st none -pt topic445_4_0 -u 0.026647381215627736 > ./result_8chains/node445_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_5_0 -p 759 -st none -pt topic445_5_0 -u 0.022822045391747925 > ./result_8chains/node445_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node445_6_0 -p 867 -st none -pt topic445_6_0 -u 0.008362702758139301 > ./result_8chains/node445_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node445_7_0 -p 904 -st none -pt topic445_7_0 -u 0.0315019059271583 > ./result_8chains/node445_7_0.txt &
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
    "./result_8chains/node445_0_0.txt 90"
    "./result_8chains/node445_0_2.txt 90"
    "./result_8chains/node445_1_0.txt 89"
    "./result_8chains/node445_1_2.txt 89"
    "./result_8chains/node445_2_0.txt 88"
    "./result_8chains/node445_2_2.txt 88"
    "./result_8chains/node445_3_0.txt 87"
    "./result_8chains/node445_3_2.txt 87"
    "./result_8chains/node445_4_0.txt 86"
    "./result_8chains/node445_4_2.txt 86"
    "./result_8chains/node445_5_0.txt 85"
    "./result_8chains/node445_5_2.txt 85"
    "./result_8chains/node445_6_0.txt 84"
    "./result_8chains/node445_6_2.txt 84"
    "./result_8chains/node445_7_0.txt 83"
    "./result_8chains/node445_7_2.txt 83"
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

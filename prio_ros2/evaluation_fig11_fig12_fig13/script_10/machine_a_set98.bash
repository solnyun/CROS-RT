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
ros2 run evaluation_3_randomdag uunifast_node -n node98_0_2 -p 141 -st topic98_0_1 -pt None -u 0.013282777311144023 > ./result_10chains/node98_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_1_2 -p 170 -st topic98_1_1 -pt None -u 0.023478074479641675 > ./result_10chains/node98_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_2_2 -p 229 -st topic98_2_1 -pt None -u 0.003777196664069671 > ./result_10chains/node98_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_3_2 -p 273 -st topic98_3_1 -pt None -u 0.002827423606955426 > ./result_10chains/node98_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_4_2 -p 468 -st topic98_4_1 -pt None -u 0.008811737737369041 > ./result_10chains/node98_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_5_2 -p 474 -st topic98_5_1 -pt None -u 0.06764960441521797 > ./result_10chains/node98_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_6_2 -p 539 -st topic98_6_1 -pt None -u 0.02381751082544778 > ./result_10chains/node98_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_7_2 -p 544 -st topic98_7_1 -pt None -u 0.012078262304083029 > ./result_10chains/node98_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_8_2 -p 588 -st topic98_8_1 -pt None -u 0.005701102929873941 > ./result_10chains/node98_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_9_2 -p 895 -st topic98_9_1 -pt None -u 0.011406208801808884 > ./result_10chains/node98_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_0_0 -p 141 -st none -pt topic98_0_0 -u 0.009752825677975918 > ./result_10chains/node98_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_1_0 -p 170 -st none -pt topic98_1_0 -u 0.0017090280893377052 > ./result_10chains/node98_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_2_0 -p 229 -st none -pt topic98_2_0 -u 0.01336503570792219 > ./result_10chains/node98_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_3_0 -p 273 -st none -pt topic98_3_0 -u 0.008498725254448058 > ./result_10chains/node98_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_4_0 -p 468 -st none -pt topic98_4_0 -u 0.0682664999454215 > ./result_10chains/node98_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_5_0 -p 474 -st none -pt topic98_5_0 -u 0.012568460685706162 > ./result_10chains/node98_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_6_0 -p 539 -st none -pt topic98_6_0 -u 0.011055079122870876 > ./result_10chains/node98_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_7_0 -p 544 -st none -pt topic98_7_0 -u 0.0035826106692326276 > ./result_10chains/node98_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_8_0 -p 588 -st none -pt topic98_8_0 -u 0.01390602992493753 > ./result_10chains/node98_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_9_0 -p 895 -st none -pt topic98_9_0 -u 0.04612371545813196 > ./result_10chains/node98_9_0.txt &
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
    "./result_10chains/node98_0_0.txt 90"
    "./result_10chains/node98_0_2.txt 90"
    "./result_10chains/node98_1_0.txt 89"
    "./result_10chains/node98_1_2.txt 89"
    "./result_10chains/node98_2_0.txt 88"
    "./result_10chains/node98_2_2.txt 88"
    "./result_10chains/node98_3_0.txt 87"
    "./result_10chains/node98_3_2.txt 87"
    "./result_10chains/node98_4_0.txt 86"
    "./result_10chains/node98_4_2.txt 86"
    "./result_10chains/node98_5_0.txt 85"
    "./result_10chains/node98_5_2.txt 85"
    "./result_10chains/node98_6_0.txt 84"
    "./result_10chains/node98_6_2.txt 84"
    "./result_10chains/node98_7_0.txt 83"
    "./result_10chains/node98_7_2.txt 83"
    "./result_10chains/node98_8_0.txt 82"
    "./result_10chains/node98_8_2.txt 82"
    "./result_10chains/node98_9_0.txt 81"
    "./result_10chains/node98_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

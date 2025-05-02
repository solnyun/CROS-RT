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
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_2 -p 149 -st topic232_0_1 -pt None -u 0.00030321528015470056 > ./result_8chains/node232_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_2 -p 189 -st topic232_1_1 -pt None -u 0.004442628251260239 > ./result_8chains/node232_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_2 -p 450 -st topic232_2_1 -pt None -u 0.006614240127698678 > ./result_8chains/node232_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_2 -p 501 -st topic232_3_1 -pt None -u 0.022418422320591158 > ./result_8chains/node232_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_2 -p 625 -st topic232_4_1 -pt None -u 0.006664878949685427 > ./result_8chains/node232_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_2 -p 638 -st topic232_5_1 -pt None -u 0.03926071853746799 > ./result_8chains/node232_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_6_2 -p 769 -st topic232_6_1 -pt None -u 0.011004061472134813 > ./result_8chains/node232_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_7_2 -p 843 -st topic232_7_1 -pt None -u 0.044875330742478736 > ./result_8chains/node232_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_0_0 -p 149 -st none -pt topic232_0_0 -u 0.023443996164982273 > ./result_8chains/node232_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_1_0 -p 189 -st none -pt topic232_1_0 -u 0.005396028366536465 > ./result_8chains/node232_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_2_0 -p 450 -st none -pt topic232_2_0 -u 0.013925499525017648 > ./result_8chains/node232_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_3_0 -p 501 -st none -pt topic232_3_0 -u 0.02549211933609885 > ./result_8chains/node232_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_4_0 -p 625 -st none -pt topic232_4_0 -u 0.012077969277987488 > ./result_8chains/node232_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_5_0 -p 638 -st none -pt topic232_5_0 -u 0.00613407208165373 > ./result_8chains/node232_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node232_6_0 -p 769 -st none -pt topic232_6_0 -u 0.014670944914925599 > ./result_8chains/node232_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node232_7_0 -p 843 -st none -pt topic232_7_0 -u 0.06929450024358465 > ./result_8chains/node232_7_0.txt &
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
    "./result_8chains/node232_0_0.txt 90"
    "./result_8chains/node232_0_2.txt 90"
    "./result_8chains/node232_1_0.txt 89"
    "./result_8chains/node232_1_2.txt 89"
    "./result_8chains/node232_2_0.txt 88"
    "./result_8chains/node232_2_2.txt 88"
    "./result_8chains/node232_3_0.txt 87"
    "./result_8chains/node232_3_2.txt 87"
    "./result_8chains/node232_4_0.txt 86"
    "./result_8chains/node232_4_2.txt 86"
    "./result_8chains/node232_5_0.txt 85"
    "./result_8chains/node232_5_2.txt 85"
    "./result_8chains/node232_6_0.txt 84"
    "./result_8chains/node232_6_2.txt 84"
    "./result_8chains/node232_7_0.txt 83"
    "./result_8chains/node232_7_2.txt 83"
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

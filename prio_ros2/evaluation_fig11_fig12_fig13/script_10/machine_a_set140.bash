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
ros2 run evaluation_3_randomdag uunifast_node -n node140_0_2 -p 215 -st topic140_0_1 -pt None -u 0.04432216308012177 > ./result_10chains/node140_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_1_2 -p 222 -st topic140_1_1 -pt None -u 0.02674699328267066 > ./result_10chains/node140_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_2_2 -p 235 -st topic140_2_1 -pt None -u 0.00212964723802761 > ./result_10chains/node140_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_3_2 -p 257 -st topic140_3_1 -pt None -u 0.008493972304215613 > ./result_10chains/node140_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_4_2 -p 328 -st topic140_4_1 -pt None -u 0.008197616001440255 > ./result_10chains/node140_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_5_2 -p 372 -st topic140_5_1 -pt None -u 0.0005533009204055916 > ./result_10chains/node140_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_6_2 -p 398 -st topic140_6_1 -pt None -u 0.00752987627870319 > ./result_10chains/node140_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_7_2 -p 732 -st topic140_7_1 -pt None -u 0.013097363853372151 > ./result_10chains/node140_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_8_2 -p 836 -st topic140_8_1 -pt None -u 0.018830546257926583 > ./result_10chains/node140_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_9_2 -p 906 -st topic140_9_1 -pt None -u 0.009211028382058294 > ./result_10chains/node140_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_0_0 -p 215 -st none -pt topic140_0_0 -u 0.004943720362148574 > ./result_10chains/node140_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_1_0 -p 222 -st none -pt topic140_1_0 -u 0.002673579277731708 > ./result_10chains/node140_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_2_0 -p 235 -st none -pt topic140_2_0 -u 0.0015156644399729191 > ./result_10chains/node140_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_3_0 -p 257 -st none -pt topic140_3_0 -u 0.005491693373676332 > ./result_10chains/node140_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_4_0 -p 328 -st none -pt topic140_4_0 -u 0.051427521276412036 > ./result_10chains/node140_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_5_0 -p 372 -st none -pt topic140_5_0 -u 0.03330503770685411 > ./result_10chains/node140_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_6_0 -p 398 -st none -pt topic140_6_0 -u 0.02626244924292251 > ./result_10chains/node140_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_7_0 -p 732 -st none -pt topic140_7_0 -u 0.029036639437436146 > ./result_10chains/node140_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node140_8_0 -p 836 -st none -pt topic140_8_0 -u 0.02792150339852685 > ./result_10chains/node140_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node140_9_0 -p 906 -st none -pt topic140_9_0 -u 0.017154435794977628 > ./result_10chains/node140_9_0.txt &
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
    "./result_10chains/node140_0_0.txt 90"
    "./result_10chains/node140_0_2.txt 90"
    "./result_10chains/node140_1_0.txt 89"
    "./result_10chains/node140_1_2.txt 89"
    "./result_10chains/node140_2_0.txt 88"
    "./result_10chains/node140_2_2.txt 88"
    "./result_10chains/node140_3_0.txt 87"
    "./result_10chains/node140_3_2.txt 87"
    "./result_10chains/node140_4_0.txt 86"
    "./result_10chains/node140_4_2.txt 86"
    "./result_10chains/node140_5_0.txt 85"
    "./result_10chains/node140_5_2.txt 85"
    "./result_10chains/node140_6_0.txt 84"
    "./result_10chains/node140_6_2.txt 84"
    "./result_10chains/node140_7_0.txt 83"
    "./result_10chains/node140_7_2.txt 83"
    "./result_10chains/node140_8_0.txt 82"
    "./result_10chains/node140_8_2.txt 82"
    "./result_10chains/node140_9_0.txt 81"
    "./result_10chains/node140_9_2.txt 81"
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

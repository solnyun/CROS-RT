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
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_2 -p 214 -st topic82_0_1 -pt None -u 0.006656783057681415 > ./result_10chains/node82_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_2 -p 254 -st topic82_1_1 -pt None -u 0.024050789040827192 > ./result_10chains/node82_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_2 -p 276 -st topic82_2_1 -pt None -u 0.013720704604539335 > ./result_10chains/node82_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_2 -p 305 -st topic82_3_1 -pt None -u 0.0051169977504051944 > ./result_10chains/node82_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_2 -p 350 -st topic82_4_1 -pt None -u 0.006401014512339487 > ./result_10chains/node82_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_2 -p 440 -st topic82_5_1 -pt None -u 0.020598442581220427 > ./result_10chains/node82_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_6_2 -p 469 -st topic82_6_1 -pt None -u 0.0379631138121361 > ./result_10chains/node82_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_7_2 -p 578 -st topic82_7_1 -pt None -u 0.009476646458450755 > ./result_10chains/node82_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_8_2 -p 616 -st topic82_8_1 -pt None -u 0.031815306131464466 > ./result_10chains/node82_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_9_2 -p 969 -st topic82_9_1 -pt None -u 0.04032356518645897 > ./result_10chains/node82_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_0 -p 214 -st none -pt topic82_0_0 -u 0.037104040585753784 > ./result_10chains/node82_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_0 -p 254 -st none -pt topic82_1_0 -u 0.022841683347511132 > ./result_10chains/node82_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_0 -p 276 -st none -pt topic82_2_0 -u 0.010527355607034827 > ./result_10chains/node82_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_0 -p 305 -st none -pt topic82_3_0 -u 0.013836033721791263 > ./result_10chains/node82_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_0 -p 350 -st none -pt topic82_4_0 -u 0.019286939658168745 > ./result_10chains/node82_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_0 -p 440 -st none -pt topic82_5_0 -u 0.03710515243402146 > ./result_10chains/node82_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_6_0 -p 469 -st none -pt topic82_6_0 -u 0.008691036208976988 > ./result_10chains/node82_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_7_0 -p 578 -st none -pt topic82_7_0 -u 0.006828043098285552 > ./result_10chains/node82_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_8_0 -p 616 -st none -pt topic82_8_0 -u 0.02211713502512505 > ./result_10chains/node82_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_9_0 -p 969 -st none -pt topic82_9_0 -u 0.002328405708851816 > ./result_10chains/node82_9_0.txt &
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
    "./result_10chains/node82_0_0.txt 90"
    "./result_10chains/node82_0_2.txt 90"
    "./result_10chains/node82_1_0.txt 89"
    "./result_10chains/node82_1_2.txt 89"
    "./result_10chains/node82_2_0.txt 88"
    "./result_10chains/node82_2_2.txt 88"
    "./result_10chains/node82_3_0.txt 87"
    "./result_10chains/node82_3_2.txt 87"
    "./result_10chains/node82_4_0.txt 86"
    "./result_10chains/node82_4_2.txt 86"
    "./result_10chains/node82_5_0.txt 85"
    "./result_10chains/node82_5_2.txt 85"
    "./result_10chains/node82_6_0.txt 84"
    "./result_10chains/node82_6_2.txt 84"
    "./result_10chains/node82_7_0.txt 83"
    "./result_10chains/node82_7_2.txt 83"
    "./result_10chains/node82_8_0.txt 82"
    "./result_10chains/node82_8_2.txt 82"
    "./result_10chains/node82_9_0.txt 81"
    "./result_10chains/node82_9_2.txt 81"
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

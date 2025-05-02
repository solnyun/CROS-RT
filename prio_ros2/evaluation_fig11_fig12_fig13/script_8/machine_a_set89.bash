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
ros2 run evaluation_3_randomdag uunifast_node -n node89_0_2 -p 116 -st topic89_0_1 -pt None -u 0.026900317994459133 > ./result_8chains/node89_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_1_2 -p 131 -st topic89_1_1 -pt None -u 0.010501074354561657 > ./result_8chains/node89_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_2_2 -p 368 -st topic89_2_1 -pt None -u 0.03943645276698793 > ./result_8chains/node89_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_3_2 -p 379 -st topic89_3_1 -pt None -u 0.024869055673774787 > ./result_8chains/node89_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_4_2 -p 459 -st topic89_4_1 -pt None -u 0.02835864759588752 > ./result_8chains/node89_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_5_2 -p 804 -st topic89_5_1 -pt None -u 0.011521901777545071 > ./result_8chains/node89_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_6_2 -p 816 -st topic89_6_1 -pt None -u 0.0170660454609622 > ./result_8chains/node89_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_7_2 -p 952 -st topic89_7_1 -pt None -u 0.013439454624439047 > ./result_8chains/node89_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_0_0 -p 116 -st none -pt topic89_0_0 -u 0.005216404332680502 > ./result_8chains/node89_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_1_0 -p 131 -st none -pt topic89_1_0 -u 0.02245977715905012 > ./result_8chains/node89_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_2_0 -p 368 -st none -pt topic89_2_0 -u 0.004637137250853518 > ./result_8chains/node89_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_3_0 -p 379 -st none -pt topic89_3_0 -u 0.05870727645626364 > ./result_8chains/node89_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_4_0 -p 459 -st none -pt topic89_4_0 -u 0.004529250178634231 > ./result_8chains/node89_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_5_0 -p 804 -st none -pt topic89_5_0 -u 0.0016212199050524012 > ./result_8chains/node89_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_6_0 -p 816 -st none -pt topic89_6_0 -u 0.005670457735955481 > ./result_8chains/node89_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_7_0 -p 952 -st none -pt topic89_7_0 -u 0.013856227196770512 > ./result_8chains/node89_7_0.txt &
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
    "./result_8chains/node89_0_0.txt 90"
    "./result_8chains/node89_0_2.txt 90"
    "./result_8chains/node89_1_0.txt 89"
    "./result_8chains/node89_1_2.txt 89"
    "./result_8chains/node89_2_0.txt 88"
    "./result_8chains/node89_2_2.txt 88"
    "./result_8chains/node89_3_0.txt 87"
    "./result_8chains/node89_3_2.txt 87"
    "./result_8chains/node89_4_0.txt 86"
    "./result_8chains/node89_4_2.txt 86"
    "./result_8chains/node89_5_0.txt 85"
    "./result_8chains/node89_5_2.txt 85"
    "./result_8chains/node89_6_0.txt 84"
    "./result_8chains/node89_6_2.txt 84"
    "./result_8chains/node89_7_0.txt 83"
    "./result_8chains/node89_7_2.txt 83"
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

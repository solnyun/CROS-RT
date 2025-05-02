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
ros2 run evaluation_3_randomdag uunifast_node -n node302_0_2 -p 66 -st topic302_0_1 -pt None -u 0.01133336614029129 > ./result_10chains/node302_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_1_2 -p 178 -st topic302_1_1 -pt None -u 0.03395556073149142 > ./result_10chains/node302_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_2_2 -p 257 -st topic302_2_1 -pt None -u 0.02380226224616716 > ./result_10chains/node302_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_3_2 -p 409 -st topic302_3_1 -pt None -u 0.010402970513517573 > ./result_10chains/node302_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_4_2 -p 622 -st topic302_4_1 -pt None -u 0.015895858918396233 > ./result_10chains/node302_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_5_2 -p 728 -st topic302_5_1 -pt None -u 0.030928070202122904 > ./result_10chains/node302_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_6_2 -p 732 -st topic302_6_1 -pt None -u 0.0014319252182014575 > ./result_10chains/node302_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_7_2 -p 746 -st topic302_7_1 -pt None -u 0.021943121330743276 > ./result_10chains/node302_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_8_2 -p 838 -st topic302_8_1 -pt None -u 0.008152283515077324 > ./result_10chains/node302_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_9_2 -p 993 -st topic302_9_1 -pt None -u 0.03478575425953692 > ./result_10chains/node302_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_0_0 -p 66 -st none -pt topic302_0_0 -u 0.020522423253973632 > ./result_10chains/node302_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_1_0 -p 178 -st none -pt topic302_1_0 -u 0.011565814279379694 > ./result_10chains/node302_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_2_0 -p 257 -st none -pt topic302_2_0 -u 0.0032252116867055314 > ./result_10chains/node302_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_3_0 -p 409 -st none -pt topic302_3_0 -u 0.005448072641370261 > ./result_10chains/node302_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_4_0 -p 622 -st none -pt topic302_4_0 -u 0.0027408438898894882 > ./result_10chains/node302_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_5_0 -p 728 -st none -pt topic302_5_0 -u 0.029744362815840808 > ./result_10chains/node302_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_6_0 -p 732 -st none -pt topic302_6_0 -u 0.0054706770811251415 > ./result_10chains/node302_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_7_0 -p 746 -st none -pt topic302_7_0 -u 0.03088289557246096 > ./result_10chains/node302_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node302_8_0 -p 838 -st none -pt topic302_8_0 -u 0.02505826198068642 > ./result_10chains/node302_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node302_9_0 -p 993 -st none -pt topic302_9_0 -u 0.014600971087545316 > ./result_10chains/node302_9_0.txt &
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
    "./result_10chains/node302_0_0.txt 90"
    "./result_10chains/node302_0_2.txt 90"
    "./result_10chains/node302_1_0.txt 89"
    "./result_10chains/node302_1_2.txt 89"
    "./result_10chains/node302_2_0.txt 88"
    "./result_10chains/node302_2_2.txt 88"
    "./result_10chains/node302_3_0.txt 87"
    "./result_10chains/node302_3_2.txt 87"
    "./result_10chains/node302_4_0.txt 86"
    "./result_10chains/node302_4_2.txt 86"
    "./result_10chains/node302_5_0.txt 85"
    "./result_10chains/node302_5_2.txt 85"
    "./result_10chains/node302_6_0.txt 84"
    "./result_10chains/node302_6_2.txt 84"
    "./result_10chains/node302_7_0.txt 83"
    "./result_10chains/node302_7_2.txt 83"
    "./result_10chains/node302_8_0.txt 82"
    "./result_10chains/node302_8_2.txt 82"
    "./result_10chains/node302_9_0.txt 81"
    "./result_10chains/node302_9_2.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node14_0_2 -p 82 -st topic14_0_1 -pt None -u 0.0368506160912635 > ./result_10chains/node14_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_1_2 -p 311 -st topic14_1_1 -pt None -u 0.0008967704609761928 > ./result_10chains/node14_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_2_2 -p 329 -st topic14_2_1 -pt None -u 0.00028161005981219844 > ./result_10chains/node14_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_3_2 -p 523 -st topic14_3_1 -pt None -u 0.0058422314080437965 > ./result_10chains/node14_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_4_2 -p 573 -st topic14_4_1 -pt None -u 0.02666158504995375 > ./result_10chains/node14_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_5_2 -p 766 -st topic14_5_1 -pt None -u 0.0030284143330506774 > ./result_10chains/node14_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_6_2 -p 837 -st topic14_6_1 -pt None -u 0.006363310609539152 > ./result_10chains/node14_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_7_2 -p 840 -st topic14_7_1 -pt None -u 0.01770133980373069 > ./result_10chains/node14_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_8_2 -p 930 -st topic14_8_1 -pt None -u 0.024480836815257145 > ./result_10chains/node14_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_9_2 -p 932 -st topic14_9_1 -pt None -u 0.011712530162943355 > ./result_10chains/node14_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_0_0 -p 82 -st none -pt topic14_0_0 -u 0.010248573655034399 > ./result_10chains/node14_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_1_0 -p 311 -st none -pt topic14_1_0 -u 0.06361303994400447 > ./result_10chains/node14_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_2_0 -p 329 -st none -pt topic14_2_0 -u 0.0003078374043261056 > ./result_10chains/node14_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_3_0 -p 523 -st none -pt topic14_3_0 -u 0.002859631567387222 > ./result_10chains/node14_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_4_0 -p 573 -st none -pt topic14_4_0 -u 0.000422905502691584 > ./result_10chains/node14_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_5_0 -p 766 -st none -pt topic14_5_0 -u 0.02902279194102758 > ./result_10chains/node14_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_6_0 -p 837 -st none -pt topic14_6_0 -u 0.02185133881714499 > ./result_10chains/node14_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_7_0 -p 840 -st none -pt topic14_7_0 -u 0.009781210963407727 > ./result_10chains/node14_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node14_8_0 -p 930 -st none -pt topic14_8_0 -u 0.006885531696980071 > ./result_10chains/node14_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node14_9_0 -p 932 -st none -pt topic14_9_0 -u 0.05829279363582568 > ./result_10chains/node14_9_0.txt &
sleep 10
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
    "./result_10chains/node14_0_0.txt 90"
    "./result_10chains/node14_0_2.txt 90"
    "./result_10chains/node14_1_0.txt 89"
    "./result_10chains/node14_1_2.txt 89"
    "./result_10chains/node14_2_0.txt 88"
    "./result_10chains/node14_2_2.txt 88"
    "./result_10chains/node14_3_0.txt 87"
    "./result_10chains/node14_3_2.txt 87"
    "./result_10chains/node14_4_0.txt 86"
    "./result_10chains/node14_4_2.txt 86"
    "./result_10chains/node14_5_0.txt 85"
    "./result_10chains/node14_5_2.txt 85"
    "./result_10chains/node14_6_0.txt 84"
    "./result_10chains/node14_6_2.txt 84"
    "./result_10chains/node14_7_0.txt 83"
    "./result_10chains/node14_7_2.txt 83"
    "./result_10chains/node14_8_0.txt 82"
    "./result_10chains/node14_8_2.txt 82"
    "./result_10chains/node14_9_0.txt 81"
    "./result_10chains/node14_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

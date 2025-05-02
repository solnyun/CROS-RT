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
ros2 run evaluation_3_randomdag uunifast_node -n node1_0_2 -p 116 -st topic1_0_1 -pt None -u 0.002038218668837799 > ./result_10chains/node1_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_1_2 -p 219 -st topic1_1_1 -pt None -u 0.004918358839842707 > ./result_10chains/node1_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_2_2 -p 387 -st topic1_2_1 -pt None -u 0.041700576599009276 > ./result_10chains/node1_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_3_2 -p 398 -st topic1_3_1 -pt None -u 0.022826489245983517 > ./result_10chains/node1_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_4_2 -p 454 -st topic1_4_1 -pt None -u 0.02565843357443537 > ./result_10chains/node1_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_5_2 -p 495 -st topic1_5_1 -pt None -u 0.015193528469918949 > ./result_10chains/node1_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_6_2 -p 738 -st topic1_6_1 -pt None -u 0.0008657544153906072 > ./result_10chains/node1_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_7_2 -p 838 -st topic1_7_1 -pt None -u 0.006074299644437925 > ./result_10chains/node1_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_8_2 -p 855 -st topic1_8_1 -pt None -u 0.014586001391594175 > ./result_10chains/node1_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_9_2 -p 979 -st topic1_9_1 -pt None -u 0.06438357900192129 > ./result_10chains/node1_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_0_0 -p 116 -st none -pt topic1_0_0 -u 0.017210794655981798 > ./result_10chains/node1_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_1_0 -p 219 -st none -pt topic1_1_0 -u 0.0329847827387183 > ./result_10chains/node1_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_2_0 -p 387 -st none -pt topic1_2_0 -u 0.009373653805103854 > ./result_10chains/node1_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_3_0 -p 398 -st none -pt topic1_3_0 -u 0.007578191606412488 > ./result_10chains/node1_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_4_0 -p 454 -st none -pt topic1_4_0 -u 0.0028463742420979377 > ./result_10chains/node1_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_5_0 -p 495 -st none -pt topic1_5_0 -u 0.01719637969852958 > ./result_10chains/node1_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_6_0 -p 738 -st none -pt topic1_6_0 -u 0.0571986511747824 > ./result_10chains/node1_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_7_0 -p 838 -st none -pt topic1_7_0 -u 0.010185890180152452 > ./result_10chains/node1_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_8_0 -p 855 -st none -pt topic1_8_0 -u 0.012986628815715079 > ./result_10chains/node1_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_9_0 -p 979 -st none -pt topic1_9_0 -u 0.0006562454632413894 > ./result_10chains/node1_9_0.txt &
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
    "./result_10chains/node1_0_0.txt 90"
    "./result_10chains/node1_0_2.txt 90"
    "./result_10chains/node1_1_0.txt 89"
    "./result_10chains/node1_1_2.txt 89"
    "./result_10chains/node1_2_0.txt 88"
    "./result_10chains/node1_2_2.txt 88"
    "./result_10chains/node1_3_0.txt 87"
    "./result_10chains/node1_3_2.txt 87"
    "./result_10chains/node1_4_0.txt 86"
    "./result_10chains/node1_4_2.txt 86"
    "./result_10chains/node1_5_0.txt 85"
    "./result_10chains/node1_5_2.txt 85"
    "./result_10chains/node1_6_0.txt 84"
    "./result_10chains/node1_6_2.txt 84"
    "./result_10chains/node1_7_0.txt 83"
    "./result_10chains/node1_7_2.txt 83"
    "./result_10chains/node1_8_0.txt 82"
    "./result_10chains/node1_8_2.txt 82"
    "./result_10chains/node1_9_0.txt 81"
    "./result_10chains/node1_9_2.txt 81"
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

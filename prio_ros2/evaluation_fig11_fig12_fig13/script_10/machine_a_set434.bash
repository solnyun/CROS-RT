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
ros2 run evaluation_3_randomdag uunifast_node -n node434_0_2 -p 53 -st topic434_0_1 -pt None -u 0.018956861364568367 > ./result_10chains/node434_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_1_2 -p 306 -st topic434_1_1 -pt None -u 0.048075331235449104 > ./result_10chains/node434_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_2_2 -p 400 -st topic434_2_1 -pt None -u 0.0007155886808330458 > ./result_10chains/node434_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_3_2 -p 714 -st topic434_3_1 -pt None -u 0.029727222943928433 > ./result_10chains/node434_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_4_2 -p 730 -st topic434_4_1 -pt None -u 0.0011011839239419563 > ./result_10chains/node434_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_5_2 -p 913 -st topic434_5_1 -pt None -u 0.0037001742988732322 > ./result_10chains/node434_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_6_2 -p 930 -st topic434_6_1 -pt None -u 0.018095077597701514 > ./result_10chains/node434_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_7_2 -p 977 -st topic434_7_1 -pt None -u 0.004540693550944316 > ./result_10chains/node434_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_8_2 -p 989 -st topic434_8_1 -pt None -u 0.0005671249184528715 > ./result_10chains/node434_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_9_2 -p 991 -st topic434_9_1 -pt None -u 0.016897921327714786 > ./result_10chains/node434_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_0_0 -p 53 -st none -pt topic434_0_0 -u 0.00413526686236132 > ./result_10chains/node434_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_1_0 -p 306 -st none -pt topic434_1_0 -u 0.027405911048818787 > ./result_10chains/node434_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_2_0 -p 400 -st none -pt topic434_2_0 -u 0.049163873360092814 > ./result_10chains/node434_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_3_0 -p 714 -st none -pt topic434_3_0 -u 0.018590335602425012 > ./result_10chains/node434_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_4_0 -p 730 -st none -pt topic434_4_0 -u 0.007205920692955836 > ./result_10chains/node434_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_5_0 -p 913 -st none -pt topic434_5_0 -u 0.01006395409554961 > ./result_10chains/node434_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_6_0 -p 930 -st none -pt topic434_6_0 -u 0.0009808807531568042 > ./result_10chains/node434_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_7_0 -p 977 -st none -pt topic434_7_0 -u 0.0008957736724153759 > ./result_10chains/node434_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node434_8_0 -p 989 -st none -pt topic434_8_0 -u 0.018708907525311763 > ./result_10chains/node434_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node434_9_0 -p 991 -st none -pt topic434_9_0 -u 0.03187872579313397 > ./result_10chains/node434_9_0.txt &
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
    "./result_10chains/node434_0_0.txt 90"
    "./result_10chains/node434_0_2.txt 90"
    "./result_10chains/node434_1_0.txt 89"
    "./result_10chains/node434_1_2.txt 89"
    "./result_10chains/node434_2_0.txt 88"
    "./result_10chains/node434_2_2.txt 88"
    "./result_10chains/node434_3_0.txt 87"
    "./result_10chains/node434_3_2.txt 87"
    "./result_10chains/node434_4_0.txt 86"
    "./result_10chains/node434_4_2.txt 86"
    "./result_10chains/node434_5_0.txt 85"
    "./result_10chains/node434_5_2.txt 85"
    "./result_10chains/node434_6_0.txt 84"
    "./result_10chains/node434_6_2.txt 84"
    "./result_10chains/node434_7_0.txt 83"
    "./result_10chains/node434_7_2.txt 83"
    "./result_10chains/node434_8_0.txt 82"
    "./result_10chains/node434_8_2.txt 82"
    "./result_10chains/node434_9_0.txt 81"
    "./result_10chains/node434_9_2.txt 81"
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

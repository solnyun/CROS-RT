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
ros2 run evaluation_3_randomdag uunifast_node -n node359_0_2 -p 55 -st topic359_0_1 -pt None -u 0.016729207344536146 > ./result_10chains/node359_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_1_2 -p 103 -st topic359_1_1 -pt None -u 0.0036136686097878457 > ./result_10chains/node359_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_2_2 -p 243 -st topic359_2_1 -pt None -u 0.003107536806881528 > ./result_10chains/node359_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_3_2 -p 281 -st topic359_3_1 -pt None -u 0.005891757002379483 > ./result_10chains/node359_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_4_2 -p 307 -st topic359_4_1 -pt None -u 0.001793165401823782 > ./result_10chains/node359_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_5_2 -p 333 -st topic359_5_1 -pt None -u 0.0071423295476525095 > ./result_10chains/node359_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_6_2 -p 474 -st topic359_6_1 -pt None -u 0.00026559459039862676 > ./result_10chains/node359_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_7_2 -p 738 -st topic359_7_1 -pt None -u 0.007685635481808922 > ./result_10chains/node359_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_8_2 -p 938 -st topic359_8_1 -pt None -u 0.0038647769223224965 > ./result_10chains/node359_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_9_2 -p 982 -st topic359_9_1 -pt None -u 0.0012713043762379588 > ./result_10chains/node359_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_0_0 -p 55 -st none -pt topic359_0_0 -u 0.001348226382158979 > ./result_10chains/node359_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_1_0 -p 103 -st none -pt topic359_1_0 -u 0.0012426495930216164 > ./result_10chains/node359_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_2_0 -p 243 -st none -pt topic359_2_0 -u 0.012892672568065533 > ./result_10chains/node359_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_3_0 -p 281 -st none -pt topic359_3_0 -u 0.024915117540236953 > ./result_10chains/node359_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_4_0 -p 307 -st none -pt topic359_4_0 -u 0.05364869897375196 > ./result_10chains/node359_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_5_0 -p 333 -st none -pt topic359_5_0 -u 0.03271609284995464 > ./result_10chains/node359_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_6_0 -p 474 -st none -pt topic359_6_0 -u 0.043285252339333835 > ./result_10chains/node359_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_7_0 -p 738 -st none -pt topic359_7_0 -u 0.015558931592469405 > ./result_10chains/node359_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node359_8_0 -p 938 -st none -pt topic359_8_0 -u 0.002556064190219795 > ./result_10chains/node359_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node359_9_0 -p 982 -st none -pt topic359_9_0 -u 0.06557317870465781 > ./result_10chains/node359_9_0.txt &
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
    "./result_10chains/node359_0_0.txt 90"
    "./result_10chains/node359_0_2.txt 90"
    "./result_10chains/node359_1_0.txt 89"
    "./result_10chains/node359_1_2.txt 89"
    "./result_10chains/node359_2_0.txt 88"
    "./result_10chains/node359_2_2.txt 88"
    "./result_10chains/node359_3_0.txt 87"
    "./result_10chains/node359_3_2.txt 87"
    "./result_10chains/node359_4_0.txt 86"
    "./result_10chains/node359_4_2.txt 86"
    "./result_10chains/node359_5_0.txt 85"
    "./result_10chains/node359_5_2.txt 85"
    "./result_10chains/node359_6_0.txt 84"
    "./result_10chains/node359_6_2.txt 84"
    "./result_10chains/node359_7_0.txt 83"
    "./result_10chains/node359_7_2.txt 83"
    "./result_10chains/node359_8_0.txt 82"
    "./result_10chains/node359_8_2.txt 82"
    "./result_10chains/node359_9_0.txt 81"
    "./result_10chains/node359_9_2.txt 81"
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

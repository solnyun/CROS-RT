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
ros2 run evaluation_3_randomdag uunifast_node -n node261_0_2 -p 72 -st topic261_0_1 -pt None -u 0.0020771081037846417 > ./result_10chains/node261_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_1_2 -p 103 -st topic261_1_1 -pt None -u 0.005751510347634159 > ./result_10chains/node261_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_2_2 -p 133 -st topic261_2_1 -pt None -u 0.009873321436257576 > ./result_10chains/node261_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_3_2 -p 142 -st topic261_3_1 -pt None -u 0.005710823439304125 > ./result_10chains/node261_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_4_2 -p 211 -st topic261_4_1 -pt None -u 0.012437216348950508 > ./result_10chains/node261_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_5_2 -p 299 -st topic261_5_1 -pt None -u 0.05046184844559559 > ./result_10chains/node261_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_6_2 -p 393 -st topic261_6_1 -pt None -u 0.011346445710884334 > ./result_10chains/node261_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_7_2 -p 534 -st topic261_7_1 -pt None -u 0.023848794365042503 > ./result_10chains/node261_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_8_2 -p 678 -st topic261_8_1 -pt None -u 0.020377083666656914 > ./result_10chains/node261_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_9_2 -p 691 -st topic261_9_1 -pt None -u 0.006664521872238139 > ./result_10chains/node261_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_0_0 -p 72 -st none -pt topic261_0_0 -u 0.008733754662416437 > ./result_10chains/node261_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_1_0 -p 103 -st none -pt topic261_1_0 -u 0.037935184454752136 > ./result_10chains/node261_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_2_0 -p 133 -st none -pt topic261_2_0 -u 0.016251397129590006 > ./result_10chains/node261_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_3_0 -p 142 -st none -pt topic261_3_0 -u 0.020104472613291846 > ./result_10chains/node261_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_4_0 -p 211 -st none -pt topic261_4_0 -u 0.0016037426636758556 > ./result_10chains/node261_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_5_0 -p 299 -st none -pt topic261_5_0 -u 0.007765609012813923 > ./result_10chains/node261_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_6_0 -p 393 -st none -pt topic261_6_0 -u 0.021016570111411836 > ./result_10chains/node261_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_7_0 -p 534 -st none -pt topic261_7_0 -u 0.0579228236385821 > ./result_10chains/node261_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node261_8_0 -p 678 -st none -pt topic261_8_0 -u 0.005905860231054605 > ./result_10chains/node261_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node261_9_0 -p 691 -st none -pt topic261_9_0 -u 0.010884417303223804 > ./result_10chains/node261_9_0.txt &
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
    "./result_10chains/node261_0_0.txt 90"
    "./result_10chains/node261_0_2.txt 90"
    "./result_10chains/node261_1_0.txt 89"
    "./result_10chains/node261_1_2.txt 89"
    "./result_10chains/node261_2_0.txt 88"
    "./result_10chains/node261_2_2.txt 88"
    "./result_10chains/node261_3_0.txt 87"
    "./result_10chains/node261_3_2.txt 87"
    "./result_10chains/node261_4_0.txt 86"
    "./result_10chains/node261_4_2.txt 86"
    "./result_10chains/node261_5_0.txt 85"
    "./result_10chains/node261_5_2.txt 85"
    "./result_10chains/node261_6_0.txt 84"
    "./result_10chains/node261_6_2.txt 84"
    "./result_10chains/node261_7_0.txt 83"
    "./result_10chains/node261_7_2.txt 83"
    "./result_10chains/node261_8_0.txt 82"
    "./result_10chains/node261_8_2.txt 82"
    "./result_10chains/node261_9_0.txt 81"
    "./result_10chains/node261_9_2.txt 81"
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

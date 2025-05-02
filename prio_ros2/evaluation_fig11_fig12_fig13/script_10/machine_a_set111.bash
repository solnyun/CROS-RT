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
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_2 -p 47 -st topic111_0_1 -pt None -u 0.0069953581369175954 > ./result_10chains/node111_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_2 -p 83 -st topic111_1_1 -pt None -u 0.02982128694142666 > ./result_10chains/node111_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_2 -p 103 -st topic111_2_1 -pt None -u 0.0003662888392444441 > ./result_10chains/node111_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_2 -p 108 -st topic111_3_1 -pt None -u 0.014297324174537662 > ./result_10chains/node111_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_2 -p 181 -st topic111_4_1 -pt None -u 0.01616734061750974 > ./result_10chains/node111_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_2 -p 214 -st topic111_5_1 -pt None -u 0.014467955786705788 > ./result_10chains/node111_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_6_2 -p 231 -st topic111_6_1 -pt None -u 0.04225316420585781 > ./result_10chains/node111_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_7_2 -p 456 -st topic111_7_1 -pt None -u 0.038158508894295146 > ./result_10chains/node111_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_8_2 -p 528 -st topic111_8_1 -pt None -u 0.006371156872573402 > ./result_10chains/node111_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_9_2 -p 721 -st topic111_9_1 -pt None -u 0.002331079671369607 > ./result_10chains/node111_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_0 -p 47 -st none -pt topic111_0_0 -u 0.0004133318690658916 > ./result_10chains/node111_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_0 -p 83 -st none -pt topic111_1_0 -u 0.01717062444515688 > ./result_10chains/node111_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_0 -p 103 -st none -pt topic111_2_0 -u 0.01376848877539899 > ./result_10chains/node111_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_0 -p 108 -st none -pt topic111_3_0 -u 0.028188042646565936 > ./result_10chains/node111_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_0 -p 181 -st none -pt topic111_4_0 -u 0.01493788103616911 > ./result_10chains/node111_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_0 -p 214 -st none -pt topic111_5_0 -u 0.007782136116480098 > ./result_10chains/node111_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_6_0 -p 231 -st none -pt topic111_6_0 -u 0.018154313474794348 > ./result_10chains/node111_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_7_0 -p 456 -st none -pt topic111_7_0 -u 0.03306266954276876 > ./result_10chains/node111_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_8_0 -p 528 -st none -pt topic111_8_0 -u 0.02008639552976719 > ./result_10chains/node111_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_9_0 -p 721 -st none -pt topic111_9_0 -u 0.0027750580851164663 > ./result_10chains/node111_9_0.txt &
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
    "./result_10chains/node111_0_0.txt 90"
    "./result_10chains/node111_0_2.txt 90"
    "./result_10chains/node111_1_0.txt 89"
    "./result_10chains/node111_1_2.txt 89"
    "./result_10chains/node111_2_0.txt 88"
    "./result_10chains/node111_2_2.txt 88"
    "./result_10chains/node111_3_0.txt 87"
    "./result_10chains/node111_3_2.txt 87"
    "./result_10chains/node111_4_0.txt 86"
    "./result_10chains/node111_4_2.txt 86"
    "./result_10chains/node111_5_0.txt 85"
    "./result_10chains/node111_5_2.txt 85"
    "./result_10chains/node111_6_0.txt 84"
    "./result_10chains/node111_6_2.txt 84"
    "./result_10chains/node111_7_0.txt 83"
    "./result_10chains/node111_7_2.txt 83"
    "./result_10chains/node111_8_0.txt 82"
    "./result_10chains/node111_8_2.txt 82"
    "./result_10chains/node111_9_0.txt 81"
    "./result_10chains/node111_9_2.txt 81"
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

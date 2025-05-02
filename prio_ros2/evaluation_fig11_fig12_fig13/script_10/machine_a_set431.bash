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
ros2 run evaluation_3_randomdag uunifast_node -n node431_0_2 -p 83 -st topic431_0_1 -pt None -u 0.030599106116973196 > ./result_10chains/node431_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_1_2 -p 311 -st topic431_1_1 -pt None -u 0.046925934367896716 > ./result_10chains/node431_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_2_2 -p 368 -st topic431_2_1 -pt None -u 0.008942970436765896 > ./result_10chains/node431_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_3_2 -p 512 -st topic431_3_1 -pt None -u 0.00559720927397106 > ./result_10chains/node431_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_4_2 -p 517 -st topic431_4_1 -pt None -u 0.019242957438586117 > ./result_10chains/node431_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_5_2 -p 569 -st topic431_5_1 -pt None -u 0.021852656470321058 > ./result_10chains/node431_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_6_2 -p 601 -st topic431_6_1 -pt None -u 0.0008446812414731608 > ./result_10chains/node431_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_7_2 -p 612 -st topic431_7_1 -pt None -u 0.005878456873788879 > ./result_10chains/node431_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_8_2 -p 674 -st topic431_8_1 -pt None -u 0.015103816517571561 > ./result_10chains/node431_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_9_2 -p 891 -st topic431_9_1 -pt None -u 0.024236597165430293 > ./result_10chains/node431_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_0_0 -p 83 -st none -pt topic431_0_0 -u 0.029969620652142648 > ./result_10chains/node431_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_1_0 -p 311 -st none -pt topic431_1_0 -u 0.004417717976755664 > ./result_10chains/node431_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_2_0 -p 368 -st none -pt topic431_2_0 -u 0.009655375150089851 > ./result_10chains/node431_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_3_0 -p 512 -st none -pt topic431_3_0 -u 0.003755801273256032 > ./result_10chains/node431_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_4_0 -p 517 -st none -pt topic431_4_0 -u 0.008160109369797275 > ./result_10chains/node431_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_5_0 -p 569 -st none -pt topic431_5_0 -u 0.00014481298255714092 > ./result_10chains/node431_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_6_0 -p 601 -st none -pt topic431_6_0 -u 0.025067325767202553 > ./result_10chains/node431_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_7_0 -p 612 -st none -pt topic431_7_0 -u 0.004321819382357164 > ./result_10chains/node431_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node431_8_0 -p 674 -st none -pt topic431_8_0 -u 0.010553360722451999 > ./result_10chains/node431_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node431_9_0 -p 891 -st none -pt topic431_9_0 -u 0.008939566590409134 > ./result_10chains/node431_9_0.txt &
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
    "./result_10chains/node431_0_0.txt 90"
    "./result_10chains/node431_0_2.txt 90"
    "./result_10chains/node431_1_0.txt 89"
    "./result_10chains/node431_1_2.txt 89"
    "./result_10chains/node431_2_0.txt 88"
    "./result_10chains/node431_2_2.txt 88"
    "./result_10chains/node431_3_0.txt 87"
    "./result_10chains/node431_3_2.txt 87"
    "./result_10chains/node431_4_0.txt 86"
    "./result_10chains/node431_4_2.txt 86"
    "./result_10chains/node431_5_0.txt 85"
    "./result_10chains/node431_5_2.txt 85"
    "./result_10chains/node431_6_0.txt 84"
    "./result_10chains/node431_6_2.txt 84"
    "./result_10chains/node431_7_0.txt 83"
    "./result_10chains/node431_7_2.txt 83"
    "./result_10chains/node431_8_0.txt 82"
    "./result_10chains/node431_8_2.txt 82"
    "./result_10chains/node431_9_0.txt 81"
    "./result_10chains/node431_9_2.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node408_0_2 -p 35 -st topic408_0_1 -pt None -u 0.02368560872001818 > ./result_10chains/node408_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_1_2 -p 72 -st topic408_1_1 -pt None -u 0.05906932774914164 > ./result_10chains/node408_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_2_2 -p 76 -st topic408_2_1 -pt None -u 0.0037770048912315612 > ./result_10chains/node408_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_3_2 -p 122 -st topic408_3_1 -pt None -u 0.024524107079238244 > ./result_10chains/node408_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_4_2 -p 197 -st topic408_4_1 -pt None -u 0.02652876271720761 > ./result_10chains/node408_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_5_2 -p 199 -st topic408_5_1 -pt None -u 0.02403305719955448 > ./result_10chains/node408_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_6_2 -p 449 -st topic408_6_1 -pt None -u 0.041243865321783646 > ./result_10chains/node408_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_7_2 -p 474 -st topic408_7_1 -pt None -u 0.021199514155240323 > ./result_10chains/node408_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_8_2 -p 867 -st topic408_8_1 -pt None -u 0.01005142553233511 > ./result_10chains/node408_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_9_2 -p 964 -st topic408_9_1 -pt None -u 0.0008351403662167882 > ./result_10chains/node408_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_0_0 -p 35 -st none -pt topic408_0_0 -u 0.019656759848080685 > ./result_10chains/node408_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_1_0 -p 72 -st none -pt topic408_1_0 -u 0.027879304725105025 > ./result_10chains/node408_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_2_0 -p 76 -st none -pt topic408_2_0 -u 0.008738334448637641 > ./result_10chains/node408_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_3_0 -p 122 -st none -pt topic408_3_0 -u 0.0009324207291006581 > ./result_10chains/node408_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_4_0 -p 197 -st none -pt topic408_4_0 -u 0.005714008789682479 > ./result_10chains/node408_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_5_0 -p 199 -st none -pt topic408_5_0 -u 0.001136101057897465 > ./result_10chains/node408_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_6_0 -p 449 -st none -pt topic408_6_0 -u 0.0373706406047086 > ./result_10chains/node408_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_7_0 -p 474 -st none -pt topic408_7_0 -u 0.0002791011300081192 > ./result_10chains/node408_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node408_8_0 -p 867 -st none -pt topic408_8_0 -u 0.018322347054933838 > ./result_10chains/node408_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node408_9_0 -p 964 -st none -pt topic408_9_0 -u 0.01892760046911025 > ./result_10chains/node408_9_0.txt &
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
    "./result_10chains/node408_0_0.txt 90"
    "./result_10chains/node408_0_2.txt 90"
    "./result_10chains/node408_1_0.txt 89"
    "./result_10chains/node408_1_2.txt 89"
    "./result_10chains/node408_2_0.txt 88"
    "./result_10chains/node408_2_2.txt 88"
    "./result_10chains/node408_3_0.txt 87"
    "./result_10chains/node408_3_2.txt 87"
    "./result_10chains/node408_4_0.txt 86"
    "./result_10chains/node408_4_2.txt 86"
    "./result_10chains/node408_5_0.txt 85"
    "./result_10chains/node408_5_2.txt 85"
    "./result_10chains/node408_6_0.txt 84"
    "./result_10chains/node408_6_2.txt 84"
    "./result_10chains/node408_7_0.txt 83"
    "./result_10chains/node408_7_2.txt 83"
    "./result_10chains/node408_8_0.txt 82"
    "./result_10chains/node408_8_2.txt 82"
    "./result_10chains/node408_9_0.txt 81"
    "./result_10chains/node408_9_2.txt 81"
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

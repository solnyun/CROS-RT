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
ros2 run evaluation_3_randomdag uunifast_node -n node115_0_2 -p 135 -st topic115_0_1 -pt None -u 0.0025826750963653944 > ./result_10chains/node115_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_1_2 -p 143 -st topic115_1_1 -pt None -u 0.037032808439464326 > ./result_10chains/node115_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_2_2 -p 173 -st topic115_2_1 -pt None -u 0.013147275204835163 > ./result_10chains/node115_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_3_2 -p 381 -st topic115_3_1 -pt None -u 0.004132015682654588 > ./result_10chains/node115_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_4_2 -p 391 -st topic115_4_1 -pt None -u 0.0008765464929184619 > ./result_10chains/node115_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_5_2 -p 450 -st topic115_5_1 -pt None -u 0.027992046612132948 > ./result_10chains/node115_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_6_2 -p 504 -st topic115_6_1 -pt None -u 0.003914178905530696 > ./result_10chains/node115_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_7_2 -p 705 -st topic115_7_1 -pt None -u 0.037019638924447984 > ./result_10chains/node115_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_8_2 -p 786 -st topic115_8_1 -pt None -u 0.015282198388657096 > ./result_10chains/node115_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_9_2 -p 955 -st topic115_9_1 -pt None -u 0.012152446039217208 > ./result_10chains/node115_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_0_0 -p 135 -st none -pt topic115_0_0 -u 0.015068511217199876 > ./result_10chains/node115_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_1_0 -p 143 -st none -pt topic115_1_0 -u 0.00683141495744044 > ./result_10chains/node115_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_2_0 -p 173 -st none -pt topic115_2_0 -u 0.03260850877979937 > ./result_10chains/node115_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_3_0 -p 381 -st none -pt topic115_3_0 -u 0.0010018579555608476 > ./result_10chains/node115_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_4_0 -p 391 -st none -pt topic115_4_0 -u 0.013151636419903356 > ./result_10chains/node115_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_5_0 -p 450 -st none -pt topic115_5_0 -u 0.017236323980531543 > ./result_10chains/node115_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_6_0 -p 504 -st none -pt topic115_6_0 -u 0.006104004297341259 > ./result_10chains/node115_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_7_0 -p 705 -st none -pt topic115_7_0 -u 0.020636435858512103 > ./result_10chains/node115_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node115_8_0 -p 786 -st none -pt topic115_8_0 -u 0.02586852175419116 > ./result_10chains/node115_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node115_9_0 -p 955 -st none -pt topic115_9_0 -u 0.0017046245201933138 > ./result_10chains/node115_9_0.txt &
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
    "./result_10chains/node115_0_0.txt 90"
    "./result_10chains/node115_0_2.txt 90"
    "./result_10chains/node115_1_0.txt 89"
    "./result_10chains/node115_1_2.txt 89"
    "./result_10chains/node115_2_0.txt 88"
    "./result_10chains/node115_2_2.txt 88"
    "./result_10chains/node115_3_0.txt 87"
    "./result_10chains/node115_3_2.txt 87"
    "./result_10chains/node115_4_0.txt 86"
    "./result_10chains/node115_4_2.txt 86"
    "./result_10chains/node115_5_0.txt 85"
    "./result_10chains/node115_5_2.txt 85"
    "./result_10chains/node115_6_0.txt 84"
    "./result_10chains/node115_6_2.txt 84"
    "./result_10chains/node115_7_0.txt 83"
    "./result_10chains/node115_7_2.txt 83"
    "./result_10chains/node115_8_0.txt 82"
    "./result_10chains/node115_8_2.txt 82"
    "./result_10chains/node115_9_0.txt 81"
    "./result_10chains/node115_9_2.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_2 -p 296 -st topic290_0_1 -pt None -u 0.011952852837953054 > ./result_8chains/node290_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_2 -p 378 -st topic290_1_1 -pt None -u 0.04814228317841174 > ./result_8chains/node290_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_2 -p 454 -st topic290_2_1 -pt None -u 0.0011599766182103788 > ./result_8chains/node290_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_2 -p 664 -st topic290_3_1 -pt None -u 0.01361921500512514 > ./result_8chains/node290_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_2 -p 754 -st topic290_4_1 -pt None -u 0.008305850568097434 > ./result_8chains/node290_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_2 -p 913 -st topic290_5_1 -pt None -u 0.00436492989890247 > ./result_8chains/node290_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_6_2 -p 977 -st topic290_6_1 -pt None -u 0.03010205853686257 > ./result_8chains/node290_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_7_2 -p 980 -st topic290_7_1 -pt None -u 0.014336874550807894 > ./result_8chains/node290_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_0_0 -p 296 -st none -pt topic290_0_0 -u 0.008646082427251345 > ./result_8chains/node290_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_1_0 -p 378 -st none -pt topic290_1_0 -u 0.016078207683538348 > ./result_8chains/node290_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_2_0 -p 454 -st none -pt topic290_2_0 -u 0.0019316955269648162 > ./result_8chains/node290_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_3_0 -p 664 -st none -pt topic290_3_0 -u 0.017289733947298602 > ./result_8chains/node290_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_4_0 -p 754 -st none -pt topic290_4_0 -u 0.026206062154849358 > ./result_8chains/node290_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_5_0 -p 913 -st none -pt topic290_5_0 -u 0.01009887537099749 > ./result_8chains/node290_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node290_6_0 -p 977 -st none -pt topic290_6_0 -u 0.04119574532429912 > ./result_8chains/node290_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node290_7_0 -p 980 -st none -pt topic290_7_0 -u 0.0034964687508981865 > ./result_8chains/node290_7_0.txt &
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
    "./result_8chains/node290_0_0.txt 90"
    "./result_8chains/node290_0_2.txt 90"
    "./result_8chains/node290_1_0.txt 89"
    "./result_8chains/node290_1_2.txt 89"
    "./result_8chains/node290_2_0.txt 88"
    "./result_8chains/node290_2_2.txt 88"
    "./result_8chains/node290_3_0.txt 87"
    "./result_8chains/node290_3_2.txt 87"
    "./result_8chains/node290_4_0.txt 86"
    "./result_8chains/node290_4_2.txt 86"
    "./result_8chains/node290_5_0.txt 85"
    "./result_8chains/node290_5_2.txt 85"
    "./result_8chains/node290_6_0.txt 84"
    "./result_8chains/node290_6_2.txt 84"
    "./result_8chains/node290_7_0.txt 83"
    "./result_8chains/node290_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

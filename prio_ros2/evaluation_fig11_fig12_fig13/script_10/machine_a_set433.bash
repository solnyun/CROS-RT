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
ros2 run evaluation_3_randomdag uunifast_node -n node433_0_2 -p 147 -st topic433_0_1 -pt None -u 0.03373355411676782 > ./result_10chains/node433_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_1_2 -p 227 -st topic433_1_1 -pt None -u 0.008862865557159483 > ./result_10chains/node433_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_2_2 -p 419 -st topic433_2_1 -pt None -u 0.04563007608902747 > ./result_10chains/node433_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_3_2 -p 631 -st topic433_3_1 -pt None -u 0.01102266680197575 > ./result_10chains/node433_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_4_2 -p 640 -st topic433_4_1 -pt None -u 0.01738374211458482 > ./result_10chains/node433_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_5_2 -p 735 -st topic433_5_1 -pt None -u 0.012959779059782378 > ./result_10chains/node433_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_6_2 -p 766 -st topic433_6_1 -pt None -u 0.015151871492747063 > ./result_10chains/node433_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_7_2 -p 780 -st topic433_7_1 -pt None -u 0.03282494164164415 > ./result_10chains/node433_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_8_2 -p 782 -st topic433_8_1 -pt None -u 0.01275810987803648 > ./result_10chains/node433_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_9_2 -p 799 -st topic433_9_1 -pt None -u 0.0003816359139070318 > ./result_10chains/node433_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_0_0 -p 147 -st none -pt topic433_0_0 -u 0.10142791420134051 > ./result_10chains/node433_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_1_0 -p 227 -st none -pt topic433_1_0 -u 0.006341611385654478 > ./result_10chains/node433_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_2_0 -p 419 -st none -pt topic433_2_0 -u 0.024460934396555112 > ./result_10chains/node433_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_3_0 -p 631 -st none -pt topic433_3_0 -u 0.006595136732504281 > ./result_10chains/node433_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_4_0 -p 640 -st none -pt topic433_4_0 -u 0.0005875023014584313 > ./result_10chains/node433_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_5_0 -p 735 -st none -pt topic433_5_0 -u 0.0024988225537151687 > ./result_10chains/node433_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_6_0 -p 766 -st none -pt topic433_6_0 -u 0.0029104389106891226 > ./result_10chains/node433_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_7_0 -p 780 -st none -pt topic433_7_0 -u 0.009225315678980384 > ./result_10chains/node433_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node433_8_0 -p 782 -st none -pt topic433_8_0 -u 0.0012532832439966432 > ./result_10chains/node433_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node433_9_0 -p 799 -st none -pt topic433_9_0 -u 0.014969440400078032 > ./result_10chains/node433_9_0.txt &
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
    "./result_10chains/node433_0_0.txt 90"
    "./result_10chains/node433_0_2.txt 90"
    "./result_10chains/node433_1_0.txt 89"
    "./result_10chains/node433_1_2.txt 89"
    "./result_10chains/node433_2_0.txt 88"
    "./result_10chains/node433_2_2.txt 88"
    "./result_10chains/node433_3_0.txt 87"
    "./result_10chains/node433_3_2.txt 87"
    "./result_10chains/node433_4_0.txt 86"
    "./result_10chains/node433_4_2.txt 86"
    "./result_10chains/node433_5_0.txt 85"
    "./result_10chains/node433_5_2.txt 85"
    "./result_10chains/node433_6_0.txt 84"
    "./result_10chains/node433_6_2.txt 84"
    "./result_10chains/node433_7_0.txt 83"
    "./result_10chains/node433_7_2.txt 83"
    "./result_10chains/node433_8_0.txt 82"
    "./result_10chains/node433_8_2.txt 82"
    "./result_10chains/node433_9_0.txt 81"
    "./result_10chains/node433_9_2.txt 81"
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

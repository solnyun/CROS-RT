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
ros2 run evaluation_3_randomdag uunifast_node -n node217_0_2 -p 203 -st topic217_0_1 -pt None -u 0.008418971796294805 > ./result_10chains/node217_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_1_2 -p 210 -st topic217_1_1 -pt None -u 0.0030278163994538754 > ./result_10chains/node217_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_2_2 -p 304 -st topic217_2_1 -pt None -u 0.002589313174669261 > ./result_10chains/node217_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_3_2 -p 333 -st topic217_3_1 -pt None -u 0.0007978263993970169 > ./result_10chains/node217_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_4_2 -p 403 -st topic217_4_1 -pt None -u 0.030609858318752015 > ./result_10chains/node217_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_5_2 -p 532 -st topic217_5_1 -pt None -u 0.0004039624228101557 > ./result_10chains/node217_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_6_2 -p 583 -st topic217_6_1 -pt None -u 0.007156378542765324 > ./result_10chains/node217_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_7_2 -p 762 -st topic217_7_1 -pt None -u 0.030057899793763054 > ./result_10chains/node217_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_8_2 -p 783 -st topic217_8_1 -pt None -u 0.010279035633875888 > ./result_10chains/node217_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_9_2 -p 907 -st topic217_9_1 -pt None -u 0.021299406062235723 > ./result_10chains/node217_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_0_0 -p 203 -st none -pt topic217_0_0 -u 0.05387091202883232 > ./result_10chains/node217_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_1_0 -p 210 -st none -pt topic217_1_0 -u 0.011065875794740387 > ./result_10chains/node217_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_2_0 -p 304 -st none -pt topic217_2_0 -u 0.010147662609250319 > ./result_10chains/node217_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_3_0 -p 333 -st none -pt topic217_3_0 -u 0.003108587065995483 > ./result_10chains/node217_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_4_0 -p 403 -st none -pt topic217_4_0 -u 0.005607861118550217 > ./result_10chains/node217_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_5_0 -p 532 -st none -pt topic217_5_0 -u 0.021875040121599076 > ./result_10chains/node217_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_6_0 -p 583 -st none -pt topic217_6_0 -u 0.0393377742878781 > ./result_10chains/node217_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_7_0 -p 762 -st none -pt topic217_7_0 -u 0.008201246695465514 > ./result_10chains/node217_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node217_8_0 -p 783 -st none -pt topic217_8_0 -u 0.0006318360350796581 > ./result_10chains/node217_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node217_9_0 -p 907 -st none -pt topic217_9_0 -u 0.017730212162887393 > ./result_10chains/node217_9_0.txt &
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
    "./result_10chains/node217_0_0.txt 90"
    "./result_10chains/node217_0_2.txt 90"
    "./result_10chains/node217_1_0.txt 89"
    "./result_10chains/node217_1_2.txt 89"
    "./result_10chains/node217_2_0.txt 88"
    "./result_10chains/node217_2_2.txt 88"
    "./result_10chains/node217_3_0.txt 87"
    "./result_10chains/node217_3_2.txt 87"
    "./result_10chains/node217_4_0.txt 86"
    "./result_10chains/node217_4_2.txt 86"
    "./result_10chains/node217_5_0.txt 85"
    "./result_10chains/node217_5_2.txt 85"
    "./result_10chains/node217_6_0.txt 84"
    "./result_10chains/node217_6_2.txt 84"
    "./result_10chains/node217_7_0.txt 83"
    "./result_10chains/node217_7_2.txt 83"
    "./result_10chains/node217_8_0.txt 82"
    "./result_10chains/node217_8_2.txt 82"
    "./result_10chains/node217_9_0.txt 81"
    "./result_10chains/node217_9_2.txt 81"
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

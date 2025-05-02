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
ros2 run evaluation_3_randomdag uunifast_node -n node305_0_2 -p 382 -st topic305_0_1 -pt None -u 0.08018481632320329 > ./result_6chains/node305_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_1_2 -p 433 -st topic305_1_1 -pt None -u 0.04599492436955152 > ./result_6chains/node305_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_2_2 -p 573 -st topic305_2_1 -pt None -u 0.026869493953852852 > ./result_6chains/node305_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_3_2 -p 745 -st topic305_3_1 -pt None -u 0.03631750747047624 > ./result_6chains/node305_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_4_2 -p 758 -st topic305_4_1 -pt None -u 0.00990291284783891 > ./result_6chains/node305_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_5_2 -p 804 -st topic305_5_1 -pt None -u 0.02312498771020856 > ./result_6chains/node305_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_0_0 -p 382 -st none -pt topic305_0_0 -u 0.02318028640594072 > ./result_6chains/node305_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_1_0 -p 433 -st none -pt topic305_1_0 -u 0.02767327013873455 > ./result_6chains/node305_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_2_0 -p 573 -st none -pt topic305_2_0 -u 0.011531991539946995 > ./result_6chains/node305_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_3_0 -p 745 -st none -pt topic305_3_0 -u 0.010264537819248576 > ./result_6chains/node305_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node305_4_0 -p 758 -st none -pt topic305_4_0 -u 0.0052919594483059745 > ./result_6chains/node305_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node305_5_0 -p 804 -st none -pt topic305_5_0 -u 0.009840025107427472 > ./result_6chains/node305_5_0.txt &
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
    "./result_6chains/node305_0_0.txt 90"
    "./result_6chains/node305_0_2.txt 90"
    "./result_6chains/node305_1_0.txt 89"
    "./result_6chains/node305_1_2.txt 89"
    "./result_6chains/node305_2_0.txt 88"
    "./result_6chains/node305_2_2.txt 88"
    "./result_6chains/node305_3_0.txt 87"
    "./result_6chains/node305_3_2.txt 87"
    "./result_6chains/node305_4_0.txt 86"
    "./result_6chains/node305_4_2.txt 86"
    "./result_6chains/node305_5_0.txt 85"
    "./result_6chains/node305_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

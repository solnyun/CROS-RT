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
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_2 -p 66 -st topic284_0_1 -pt None -u 0.029593080182502007 > ./result_6chains/node284_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_2 -p 188 -st topic284_1_1 -pt None -u 0.011584174635726086 > ./result_6chains/node284_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_2 -p 330 -st topic284_2_1 -pt None -u 0.006767254383026389 > ./result_6chains/node284_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_2 -p 525 -st topic284_3_1 -pt None -u 0.03054467297034638 > ./result_6chains/node284_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_2 -p 674 -st topic284_4_1 -pt None -u 0.056245744624282 > ./result_6chains/node284_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_2 -p 872 -st topic284_5_1 -pt None -u 0.031691614406540516 > ./result_6chains/node284_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_0_0 -p 66 -st none -pt topic284_0_0 -u 0.025441137635207556 > ./result_6chains/node284_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_1_0 -p 188 -st none -pt topic284_1_0 -u 0.004388501790332511 > ./result_6chains/node284_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_2_0 -p 330 -st none -pt topic284_2_0 -u 0.025920117468591963 > ./result_6chains/node284_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_3_0 -p 525 -st none -pt topic284_3_0 -u 0.008032794208140792 > ./result_6chains/node284_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node284_4_0 -p 674 -st none -pt topic284_4_0 -u 0.0012103942266342427 > ./result_6chains/node284_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node284_5_0 -p 872 -st none -pt topic284_5_0 -u 0.04944733281059349 > ./result_6chains/node284_5_0.txt &
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
    "./result_6chains/node284_0_0.txt 90"
    "./result_6chains/node284_0_2.txt 90"
    "./result_6chains/node284_1_0.txt 89"
    "./result_6chains/node284_1_2.txt 89"
    "./result_6chains/node284_2_0.txt 88"
    "./result_6chains/node284_2_2.txt 88"
    "./result_6chains/node284_3_0.txt 87"
    "./result_6chains/node284_3_2.txt 87"
    "./result_6chains/node284_4_0.txt 86"
    "./result_6chains/node284_4_2.txt 86"
    "./result_6chains/node284_5_0.txt 85"
    "./result_6chains/node284_5_2.txt 85"
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

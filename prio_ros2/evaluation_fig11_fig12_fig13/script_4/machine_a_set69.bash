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
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_2 -p 159 -st topic69_0_1 -pt None -u 0.015863593238077733 > ./result_4chains/node69_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_2 -p 471 -st topic69_1_1 -pt None -u 0.005419548265596319 > ./result_4chains/node69_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_2 -p 560 -st topic69_2_1 -pt None -u 0.12313495190566963 > ./result_4chains/node69_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_2 -p 637 -st topic69_3_1 -pt None -u 0.05102832519563509 > ./result_4chains/node69_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_0 -p 159 -st none -pt topic69_0_0 -u 0.10104995528855137 > ./result_4chains/node69_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_0 -p 471 -st none -pt topic69_1_0 -u 0.010996072085237951 > ./result_4chains/node69_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_0 -p 560 -st none -pt topic69_2_0 -u 0.06916578825186309 > ./result_4chains/node69_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_0 -p 637 -st none -pt topic69_3_0 -u 0.0278170180077986 > ./result_4chains/node69_3_0.txt &
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
    "./result_4chains/node69_0_0.txt 90"
    "./result_4chains/node69_0_2.txt 90"
    "./result_4chains/node69_1_0.txt 89"
    "./result_4chains/node69_1_2.txt 89"
    "./result_4chains/node69_2_0.txt 88"
    "./result_4chains/node69_2_2.txt 88"
    "./result_4chains/node69_3_0.txt 87"
    "./result_4chains/node69_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

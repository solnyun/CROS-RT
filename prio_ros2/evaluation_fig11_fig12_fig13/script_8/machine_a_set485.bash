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
ros2 run evaluation_3_randomdag uunifast_node -n node485_0_2 -p 74 -st topic485_0_1 -pt None -u 0.0016669832006810936 > ./result_8chains/node485_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_1_2 -p 117 -st topic485_1_1 -pt None -u 0.004917762157855665 > ./result_8chains/node485_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_2_2 -p 248 -st topic485_2_1 -pt None -u 0.05452851478829951 > ./result_8chains/node485_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_3_2 -p 403 -st topic485_3_1 -pt None -u 0.0027382725463218627 > ./result_8chains/node485_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_4_2 -p 424 -st topic485_4_1 -pt None -u 0.015914690457307534 > ./result_8chains/node485_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_5_2 -p 540 -st topic485_5_1 -pt None -u 0.02399547793764556 > ./result_8chains/node485_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_6_2 -p 543 -st topic485_6_1 -pt None -u 0.005330734106975404 > ./result_8chains/node485_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_7_2 -p 577 -st topic485_7_1 -pt None -u 0.05496947158553515 > ./result_8chains/node485_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_0_0 -p 74 -st none -pt topic485_0_0 -u 0.023206530078959453 > ./result_8chains/node485_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_1_0 -p 117 -st none -pt topic485_1_0 -u 0.01327678158436879 > ./result_8chains/node485_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_2_0 -p 248 -st none -pt topic485_2_0 -u 0.04753465504731813 > ./result_8chains/node485_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_3_0 -p 403 -st none -pt topic485_3_0 -u 0.039914385090650484 > ./result_8chains/node485_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_4_0 -p 424 -st none -pt topic485_4_0 -u 0.012889082457405582 > ./result_8chains/node485_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_5_0 -p 540 -st none -pt topic485_5_0 -u 0.024528157024230723 > ./result_8chains/node485_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_6_0 -p 543 -st none -pt topic485_6_0 -u 0.006579918802342988 > ./result_8chains/node485_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_7_0 -p 577 -st none -pt topic485_7_0 -u 0.06460390149640449 > ./result_8chains/node485_7_0.txt &
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
    "./result_8chains/node485_0_0.txt 90"
    "./result_8chains/node485_0_2.txt 90"
    "./result_8chains/node485_1_0.txt 89"
    "./result_8chains/node485_1_2.txt 89"
    "./result_8chains/node485_2_0.txt 88"
    "./result_8chains/node485_2_2.txt 88"
    "./result_8chains/node485_3_0.txt 87"
    "./result_8chains/node485_3_2.txt 87"
    "./result_8chains/node485_4_0.txt 86"
    "./result_8chains/node485_4_2.txt 86"
    "./result_8chains/node485_5_0.txt 85"
    "./result_8chains/node485_5_2.txt 85"
    "./result_8chains/node485_6_0.txt 84"
    "./result_8chains/node485_6_2.txt 84"
    "./result_8chains/node485_7_0.txt 83"
    "./result_8chains/node485_7_2.txt 83"
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

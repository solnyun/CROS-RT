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
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_2 -p 46 -st topic30_0_1 -pt None -u 0.01748194314123841 > ./result_8chains/node30_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_2 -p 87 -st topic30_1_1 -pt None -u 0.02335949073531901 > ./result_8chains/node30_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_2 -p 486 -st topic30_2_1 -pt None -u 0.05364215521436977 > ./result_8chains/node30_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_2 -p 519 -st topic30_3_1 -pt None -u 0.013778494452332368 > ./result_8chains/node30_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_2 -p 539 -st topic30_4_1 -pt None -u 0.05089220229723197 > ./result_8chains/node30_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_2 -p 656 -st topic30_5_1 -pt None -u 0.003181247081608385 > ./result_8chains/node30_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_6_2 -p 694 -st topic30_6_1 -pt None -u 0.047202836062514526 > ./result_8chains/node30_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_7_2 -p 922 -st topic30_7_1 -pt None -u 0.022489635762525467 > ./result_8chains/node30_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_0_0 -p 46 -st none -pt topic30_0_0 -u 0.01606426883826373 > ./result_8chains/node30_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_1_0 -p 87 -st none -pt topic30_1_0 -u 0.0158685681827353 > ./result_8chains/node30_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_2_0 -p 486 -st none -pt topic30_2_0 -u 0.028443140954051982 > ./result_8chains/node30_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_3_0 -p 519 -st none -pt topic30_3_0 -u 0.0031432729700963113 > ./result_8chains/node30_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_4_0 -p 539 -st none -pt topic30_4_0 -u 0.08768611382172642 > ./result_8chains/node30_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_5_0 -p 656 -st none -pt topic30_5_0 -u 0.005365732346546984 > ./result_8chains/node30_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node30_6_0 -p 694 -st none -pt topic30_6_0 -u 0.00121784245713355 > ./result_8chains/node30_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node30_7_0 -p 922 -st none -pt topic30_7_0 -u 0.019049360429875407 > ./result_8chains/node30_7_0.txt &
sleep 10
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
    "./result_8chains/node30_0_0.txt 90"
    "./result_8chains/node30_0_2.txt 90"
    "./result_8chains/node30_1_0.txt 89"
    "./result_8chains/node30_1_2.txt 89"
    "./result_8chains/node30_2_0.txt 88"
    "./result_8chains/node30_2_2.txt 88"
    "./result_8chains/node30_3_0.txt 87"
    "./result_8chains/node30_3_2.txt 87"
    "./result_8chains/node30_4_0.txt 86"
    "./result_8chains/node30_4_2.txt 86"
    "./result_8chains/node30_5_0.txt 85"
    "./result_8chains/node30_5_2.txt 85"
    "./result_8chains/node30_6_0.txt 84"
    "./result_8chains/node30_6_2.txt 84"
    "./result_8chains/node30_7_0.txt 83"
    "./result_8chains/node30_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

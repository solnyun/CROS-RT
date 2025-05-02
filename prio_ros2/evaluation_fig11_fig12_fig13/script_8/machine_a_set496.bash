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
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_2 -p 127 -st topic496_0_1 -pt None -u 0.017332870730379424 > ./result_8chains/node496_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_2 -p 362 -st topic496_1_1 -pt None -u 0.04261959768176282 > ./result_8chains/node496_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_2 -p 434 -st topic496_2_1 -pt None -u 0.0001651478682158647 > ./result_8chains/node496_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_2 -p 486 -st topic496_3_1 -pt None -u 0.0402217937733092 > ./result_8chains/node496_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_2 -p 528 -st topic496_4_1 -pt None -u 0.01039780313991756 > ./result_8chains/node496_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_2 -p 558 -st topic496_5_1 -pt None -u 0.08050377782668158 > ./result_8chains/node496_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_6_2 -p 640 -st topic496_6_1 -pt None -u 0.021396668384961688 > ./result_8chains/node496_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_7_2 -p 667 -st topic496_7_1 -pt None -u 0.015170573494617312 > ./result_8chains/node496_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_0_0 -p 127 -st none -pt topic496_0_0 -u 0.010085661772254895 > ./result_8chains/node496_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_1_0 -p 362 -st none -pt topic496_1_0 -u 0.003817081016420698 > ./result_8chains/node496_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_2_0 -p 434 -st none -pt topic496_2_0 -u 0.00043145317205267597 > ./result_8chains/node496_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_3_0 -p 486 -st none -pt topic496_3_0 -u 0.028569778281193003 > ./result_8chains/node496_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_4_0 -p 528 -st none -pt topic496_4_0 -u 0.053371721437848046 > ./result_8chains/node496_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_5_0 -p 558 -st none -pt topic496_5_0 -u 0.00851048852650399 > ./result_8chains/node496_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node496_6_0 -p 640 -st none -pt topic496_6_0 -u 0.0049879977251229835 > ./result_8chains/node496_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node496_7_0 -p 667 -st none -pt topic496_7_0 -u 0.01155483768449761 > ./result_8chains/node496_7_0.txt &
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
    "./result_8chains/node496_0_0.txt 90"
    "./result_8chains/node496_0_2.txt 90"
    "./result_8chains/node496_1_0.txt 89"
    "./result_8chains/node496_1_2.txt 89"
    "./result_8chains/node496_2_0.txt 88"
    "./result_8chains/node496_2_2.txt 88"
    "./result_8chains/node496_3_0.txt 87"
    "./result_8chains/node496_3_2.txt 87"
    "./result_8chains/node496_4_0.txt 86"
    "./result_8chains/node496_4_2.txt 86"
    "./result_8chains/node496_5_0.txt 85"
    "./result_8chains/node496_5_2.txt 85"
    "./result_8chains/node496_6_0.txt 84"
    "./result_8chains/node496_6_2.txt 84"
    "./result_8chains/node496_7_0.txt 83"
    "./result_8chains/node496_7_2.txt 83"
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

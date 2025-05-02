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
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_2 -p 239 -st topic311_0_1 -pt None -u 0.022422067951657465 > ./result_8chains/node311_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_2 -p 406 -st topic311_1_1 -pt None -u 0.03480647479231719 > ./result_8chains/node311_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_2 -p 435 -st topic311_2_1 -pt None -u 0.04077766471871308 > ./result_8chains/node311_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_2 -p 442 -st topic311_3_1 -pt None -u 0.03152197011241131 > ./result_8chains/node311_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_4_2 -p 577 -st topic311_4_1 -pt None -u 0.026466946325312768 > ./result_8chains/node311_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_5_2 -p 660 -st topic311_5_1 -pt None -u 0.0008110698206610367 > ./result_8chains/node311_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_6_2 -p 770 -st topic311_6_1 -pt None -u 0.0020684472233597345 > ./result_8chains/node311_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_7_2 -p 954 -st topic311_7_1 -pt None -u 0.00883411709100112 > ./result_8chains/node311_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_0_0 -p 239 -st none -pt topic311_0_0 -u 0.010011745600612187 > ./result_8chains/node311_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_1_0 -p 406 -st none -pt topic311_1_0 -u 0.01167325689319293 > ./result_8chains/node311_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_2_0 -p 435 -st none -pt topic311_2_0 -u 0.009838888085529962 > ./result_8chains/node311_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_3_0 -p 442 -st none -pt topic311_3_0 -u 0.0003672234232599547 > ./result_8chains/node311_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_4_0 -p 577 -st none -pt topic311_4_0 -u 0.006302252970928401 > ./result_8chains/node311_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_5_0 -p 660 -st none -pt topic311_5_0 -u 0.07909200349406367 > ./result_8chains/node311_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node311_6_0 -p 770 -st none -pt topic311_6_0 -u 0.0031669128767058408 > ./result_8chains/node311_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node311_7_0 -p 954 -st none -pt topic311_7_0 -u 0.005525173161940594 > ./result_8chains/node311_7_0.txt &
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
    "./result_8chains/node311_0_0.txt 90"
    "./result_8chains/node311_0_2.txt 90"
    "./result_8chains/node311_1_0.txt 89"
    "./result_8chains/node311_1_2.txt 89"
    "./result_8chains/node311_2_0.txt 88"
    "./result_8chains/node311_2_2.txt 88"
    "./result_8chains/node311_3_0.txt 87"
    "./result_8chains/node311_3_2.txt 87"
    "./result_8chains/node311_4_0.txt 86"
    "./result_8chains/node311_4_2.txt 86"
    "./result_8chains/node311_5_0.txt 85"
    "./result_8chains/node311_5_2.txt 85"
    "./result_8chains/node311_6_0.txt 84"
    "./result_8chains/node311_6_2.txt 84"
    "./result_8chains/node311_7_0.txt 83"
    "./result_8chains/node311_7_2.txt 83"
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

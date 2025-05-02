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
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_2 -p 205 -st topic492_0_1 -pt None -u 0.005146368500780096 > ./result_8chains/node492_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_2 -p 341 -st topic492_1_1 -pt None -u 0.03410329117642247 > ./result_8chains/node492_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_2 -p 495 -st topic492_2_1 -pt None -u 0.06568396475270594 > ./result_8chains/node492_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_2 -p 647 -st topic492_3_1 -pt None -u 0.03729127919457734 > ./result_8chains/node492_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_2 -p 699 -st topic492_4_1 -pt None -u 0.015339747690283623 > ./result_8chains/node492_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_2 -p 705 -st topic492_5_1 -pt None -u 0.002098109944858373 > ./result_8chains/node492_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_6_2 -p 710 -st topic492_6_1 -pt None -u 0.04159494840238229 > ./result_8chains/node492_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_7_2 -p 743 -st topic492_7_1 -pt None -u 0.02895850449133542 > ./result_8chains/node492_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_0 -p 205 -st none -pt topic492_0_0 -u 0.009626319366145608 > ./result_8chains/node492_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_0 -p 341 -st none -pt topic492_1_0 -u 0.019979916581504942 > ./result_8chains/node492_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_0 -p 495 -st none -pt topic492_2_0 -u 0.005947813692521231 > ./result_8chains/node492_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_0 -p 647 -st none -pt topic492_3_0 -u 0.016180785435926548 > ./result_8chains/node492_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_4_0 -p 699 -st none -pt topic492_4_0 -u 0.005146945780969747 > ./result_8chains/node492_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_5_0 -p 705 -st none -pt topic492_5_0 -u 0.0012201030487536402 > ./result_8chains/node492_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_6_0 -p 710 -st none -pt topic492_6_0 -u 0.045875262360690616 > ./result_8chains/node492_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_7_0 -p 743 -st none -pt topic492_7_0 -u 0.01143696753181922 > ./result_8chains/node492_7_0.txt &
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
    "./result_8chains/node492_0_0.txt 90"
    "./result_8chains/node492_0_2.txt 90"
    "./result_8chains/node492_1_0.txt 89"
    "./result_8chains/node492_1_2.txt 89"
    "./result_8chains/node492_2_0.txt 88"
    "./result_8chains/node492_2_2.txt 88"
    "./result_8chains/node492_3_0.txt 87"
    "./result_8chains/node492_3_2.txt 87"
    "./result_8chains/node492_4_0.txt 86"
    "./result_8chains/node492_4_2.txt 86"
    "./result_8chains/node492_5_0.txt 85"
    "./result_8chains/node492_5_2.txt 85"
    "./result_8chains/node492_6_0.txt 84"
    "./result_8chains/node492_6_2.txt 84"
    "./result_8chains/node492_7_0.txt 83"
    "./result_8chains/node492_7_2.txt 83"
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

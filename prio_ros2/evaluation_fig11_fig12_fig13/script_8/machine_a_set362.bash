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
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_2 -p 175 -st topic362_0_1 -pt None -u 0.008761025754815799 > ./result_8chains/node362_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_2 -p 217 -st topic362_1_1 -pt None -u 0.005893596669558687 > ./result_8chains/node362_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_2 -p 224 -st topic362_2_1 -pt None -u 0.033898439667157554 > ./result_8chains/node362_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_2 -p 355 -st topic362_3_1 -pt None -u 0.013169493553467387 > ./result_8chains/node362_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_2 -p 359 -st topic362_4_1 -pt None -u 0.008247603226257005 > ./result_8chains/node362_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_2 -p 362 -st topic362_5_1 -pt None -u 0.005131094485296195 > ./result_8chains/node362_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_6_2 -p 511 -st topic362_6_1 -pt None -u 0.009332292186806368 > ./result_8chains/node362_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_7_2 -p 844 -st topic362_7_1 -pt None -u 0.012588353182165958 > ./result_8chains/node362_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_0 -p 175 -st none -pt topic362_0_0 -u 0.030614857510883497 > ./result_8chains/node362_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_0 -p 217 -st none -pt topic362_1_0 -u 0.015328815317797229 > ./result_8chains/node362_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_0 -p 224 -st none -pt topic362_2_0 -u 0.028152876950822747 > ./result_8chains/node362_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_0 -p 355 -st none -pt topic362_3_0 -u 0.0890768706588349 > ./result_8chains/node362_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_0 -p 359 -st none -pt topic362_4_0 -u 0.047333821289142874 > ./result_8chains/node362_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_0 -p 362 -st none -pt topic362_5_0 -u 0.015914924291812932 > ./result_8chains/node362_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_6_0 -p 511 -st none -pt topic362_6_0 -u 0.03039881304356694 > ./result_8chains/node362_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_7_0 -p 844 -st none -pt topic362_7_0 -u 0.014239428352409031 > ./result_8chains/node362_7_0.txt &
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
    "./result_8chains/node362_0_0.txt 90"
    "./result_8chains/node362_0_2.txt 90"
    "./result_8chains/node362_1_0.txt 89"
    "./result_8chains/node362_1_2.txt 89"
    "./result_8chains/node362_2_0.txt 88"
    "./result_8chains/node362_2_2.txt 88"
    "./result_8chains/node362_3_0.txt 87"
    "./result_8chains/node362_3_2.txt 87"
    "./result_8chains/node362_4_0.txt 86"
    "./result_8chains/node362_4_2.txt 86"
    "./result_8chains/node362_5_0.txt 85"
    "./result_8chains/node362_5_2.txt 85"
    "./result_8chains/node362_6_0.txt 84"
    "./result_8chains/node362_6_2.txt 84"
    "./result_8chains/node362_7_0.txt 83"
    "./result_8chains/node362_7_2.txt 83"
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

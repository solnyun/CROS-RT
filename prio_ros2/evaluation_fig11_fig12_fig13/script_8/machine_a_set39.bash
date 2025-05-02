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
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_2 -p 214 -st topic39_0_1 -pt None -u 0.009991067332404235 > ./result_8chains/node39_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_2 -p 385 -st topic39_1_1 -pt None -u 0.03360670578191571 > ./result_8chains/node39_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_2 -p 501 -st topic39_2_1 -pt None -u 0.0019400219416669806 > ./result_8chains/node39_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_2 -p 546 -st topic39_3_1 -pt None -u 0.005980510065561995 > ./result_8chains/node39_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_2 -p 598 -st topic39_4_1 -pt None -u 0.011287674868845687 > ./result_8chains/node39_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_2 -p 726 -st topic39_5_1 -pt None -u 0.03507278763112387 > ./result_8chains/node39_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_6_2 -p 871 -st topic39_6_1 -pt None -u 0.011486107019159766 > ./result_8chains/node39_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_7_2 -p 901 -st topic39_7_1 -pt None -u 0.04270471983791501 > ./result_8chains/node39_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_0_0 -p 214 -st none -pt topic39_0_0 -u 0.05474353942999455 > ./result_8chains/node39_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_1_0 -p 385 -st none -pt topic39_1_0 -u 0.009051877084887971 > ./result_8chains/node39_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_2_0 -p 501 -st none -pt topic39_2_0 -u 0.004106882672391232 > ./result_8chains/node39_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_3_0 -p 546 -st none -pt topic39_3_0 -u 0.05105515475630518 > ./result_8chains/node39_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_4_0 -p 598 -st none -pt topic39_4_0 -u 0.014430818781135613 > ./result_8chains/node39_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_5_0 -p 726 -st none -pt topic39_5_0 -u 0.030165843621762 > ./result_8chains/node39_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node39_6_0 -p 871 -st none -pt topic39_6_0 -u 0.027492877068330188 > ./result_8chains/node39_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node39_7_0 -p 901 -st none -pt topic39_7_0 -u 0.041624230442840415 > ./result_8chains/node39_7_0.txt &
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
    "./result_8chains/node39_0_0.txt 90"
    "./result_8chains/node39_0_2.txt 90"
    "./result_8chains/node39_1_0.txt 89"
    "./result_8chains/node39_1_2.txt 89"
    "./result_8chains/node39_2_0.txt 88"
    "./result_8chains/node39_2_2.txt 88"
    "./result_8chains/node39_3_0.txt 87"
    "./result_8chains/node39_3_2.txt 87"
    "./result_8chains/node39_4_0.txt 86"
    "./result_8chains/node39_4_2.txt 86"
    "./result_8chains/node39_5_0.txt 85"
    "./result_8chains/node39_5_2.txt 85"
    "./result_8chains/node39_6_0.txt 84"
    "./result_8chains/node39_6_2.txt 84"
    "./result_8chains/node39_7_0.txt 83"
    "./result_8chains/node39_7_2.txt 83"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_2 -p 275 -st topic234_0_1 -pt None -u 0.017993289895478326 > ./result_8chains/node234_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_2 -p 277 -st topic234_1_1 -pt None -u 0.004579093570748871 > ./result_8chains/node234_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_2 -p 329 -st topic234_2_1 -pt None -u 0.02172563102584485 > ./result_8chains/node234_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_2 -p 578 -st topic234_3_1 -pt None -u 0.007271991555502844 > ./result_8chains/node234_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_2 -p 707 -st topic234_4_1 -pt None -u 0.035740881657192414 > ./result_8chains/node234_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_2 -p 749 -st topic234_5_1 -pt None -u 0.014520845123274784 > ./result_8chains/node234_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_6_2 -p 945 -st topic234_6_1 -pt None -u 0.06662597125054398 > ./result_8chains/node234_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_7_2 -p 971 -st topic234_7_1 -pt None -u 0.009207215827804476 > ./result_8chains/node234_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_0 -p 275 -st none -pt topic234_0_0 -u 0.021260772206306178 > ./result_8chains/node234_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_0 -p 277 -st none -pt topic234_1_0 -u 0.05989981472462158 > ./result_8chains/node234_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_0 -p 329 -st none -pt topic234_2_0 -u 0.009041084997994497 > ./result_8chains/node234_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_0 -p 578 -st none -pt topic234_3_0 -u 0.00018084484811187185 > ./result_8chains/node234_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_0 -p 707 -st none -pt topic234_4_0 -u 0.0034605514726434583 > ./result_8chains/node234_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_0 -p 749 -st none -pt topic234_5_0 -u 0.036696118347116724 > ./result_8chains/node234_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_6_0 -p 945 -st none -pt topic234_6_0 -u 0.006935260459427661 > ./result_8chains/node234_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_7_0 -p 971 -st none -pt topic234_7_0 -u 0.006252166446280322 > ./result_8chains/node234_7_0.txt &
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
    "./result_8chains/node234_0_0.txt 90"
    "./result_8chains/node234_0_2.txt 90"
    "./result_8chains/node234_1_0.txt 89"
    "./result_8chains/node234_1_2.txt 89"
    "./result_8chains/node234_2_0.txt 88"
    "./result_8chains/node234_2_2.txt 88"
    "./result_8chains/node234_3_0.txt 87"
    "./result_8chains/node234_3_2.txt 87"
    "./result_8chains/node234_4_0.txt 86"
    "./result_8chains/node234_4_2.txt 86"
    "./result_8chains/node234_5_0.txt 85"
    "./result_8chains/node234_5_2.txt 85"
    "./result_8chains/node234_6_0.txt 84"
    "./result_8chains/node234_6_2.txt 84"
    "./result_8chains/node234_7_0.txt 83"
    "./result_8chains/node234_7_2.txt 83"
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

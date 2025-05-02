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
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_2 -p 175 -st topic32_0_1 -pt None -u 0.004738614344483527 > ./result_8chains/node32_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_2 -p 265 -st topic32_1_1 -pt None -u 0.001244386614695836 > ./result_8chains/node32_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_2 -p 389 -st topic32_2_1 -pt None -u 0.00954922135859948 > ./result_8chains/node32_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_2 -p 574 -st topic32_3_1 -pt None -u 0.01666476967264824 > ./result_8chains/node32_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_2 -p 631 -st topic32_4_1 -pt None -u 0.0301098221508056 > ./result_8chains/node32_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_2 -p 683 -st topic32_5_1 -pt None -u 0.0005624955202397641 > ./result_8chains/node32_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_6_2 -p 705 -st topic32_6_1 -pt None -u 0.0015610870156426981 > ./result_8chains/node32_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_7_2 -p 979 -st topic32_7_1 -pt None -u 0.03234797050159354 > ./result_8chains/node32_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_0 -p 175 -st none -pt topic32_0_0 -u 0.0015535452937223138 > ./result_8chains/node32_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_0 -p 265 -st none -pt topic32_1_0 -u 0.007264543124334499 > ./result_8chains/node32_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_0 -p 389 -st none -pt topic32_2_0 -u 0.022363880254471336 > ./result_8chains/node32_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_0 -p 574 -st none -pt topic32_3_0 -u 0.037535309413687934 > ./result_8chains/node32_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_0 -p 631 -st none -pt topic32_4_0 -u 0.043339873382073235 > ./result_8chains/node32_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_0 -p 683 -st none -pt topic32_5_0 -u 0.05345674605215314 > ./result_8chains/node32_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_6_0 -p 705 -st none -pt topic32_6_0 -u 0.027035417383640126 > ./result_8chains/node32_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_7_0 -p 979 -st none -pt topic32_7_0 -u 0.032206096860658985 > ./result_8chains/node32_7_0.txt &
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
    "./result_8chains/node32_0_0.txt 90"
    "./result_8chains/node32_0_2.txt 90"
    "./result_8chains/node32_1_0.txt 89"
    "./result_8chains/node32_1_2.txt 89"
    "./result_8chains/node32_2_0.txt 88"
    "./result_8chains/node32_2_2.txt 88"
    "./result_8chains/node32_3_0.txt 87"
    "./result_8chains/node32_3_2.txt 87"
    "./result_8chains/node32_4_0.txt 86"
    "./result_8chains/node32_4_2.txt 86"
    "./result_8chains/node32_5_0.txt 85"
    "./result_8chains/node32_5_2.txt 85"
    "./result_8chains/node32_6_0.txt 84"
    "./result_8chains/node32_6_2.txt 84"
    "./result_8chains/node32_7_0.txt 83"
    "./result_8chains/node32_7_2.txt 83"
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

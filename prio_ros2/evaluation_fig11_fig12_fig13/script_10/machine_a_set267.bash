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
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_2 -p 331 -st topic267_0_1 -pt None -u 0.0009429629648339266 > ./result_10chains/node267_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_2 -p 383 -st topic267_1_1 -pt None -u 0.04650190268800991 > ./result_10chains/node267_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_2 -p 525 -st topic267_2_1 -pt None -u 0.05350708453613928 > ./result_10chains/node267_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_2 -p 534 -st topic267_3_1 -pt None -u 0.01876677600513499 > ./result_10chains/node267_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_2 -p 535 -st topic267_4_1 -pt None -u 0.024837810704775837 > ./result_10chains/node267_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_2 -p 580 -st topic267_5_1 -pt None -u 0.004309258890226847 > ./result_10chains/node267_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_6_2 -p 591 -st topic267_6_1 -pt None -u 0.0113361640928141 > ./result_10chains/node267_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_7_2 -p 823 -st topic267_7_1 -pt None -u 0.035745233910694785 > ./result_10chains/node267_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_8_2 -p 922 -st topic267_8_1 -pt None -u 0.020875942139664077 > ./result_10chains/node267_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_9_2 -p 981 -st topic267_9_1 -pt None -u 0.008975423661711428 > ./result_10chains/node267_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_0_0 -p 331 -st none -pt topic267_0_0 -u 0.001770787443622024 > ./result_10chains/node267_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_1_0 -p 383 -st none -pt topic267_1_0 -u 0.005068775616969723 > ./result_10chains/node267_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_2_0 -p 525 -st none -pt topic267_2_0 -u 0.0009759697043909554 > ./result_10chains/node267_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_3_0 -p 534 -st none -pt topic267_3_0 -u 0.004997035412173223 > ./result_10chains/node267_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_4_0 -p 535 -st none -pt topic267_4_0 -u 0.011579364108198487 > ./result_10chains/node267_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_5_0 -p 580 -st none -pt topic267_5_0 -u 0.0142392450971697 > ./result_10chains/node267_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_6_0 -p 591 -st none -pt topic267_6_0 -u 0.004822348316391556 > ./result_10chains/node267_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_7_0 -p 823 -st none -pt topic267_7_0 -u 0.007917588808898465 > ./result_10chains/node267_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node267_8_0 -p 922 -st none -pt topic267_8_0 -u 0.022149144306476555 > ./result_10chains/node267_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node267_9_0 -p 981 -st none -pt topic267_9_0 -u 0.005883253060294684 > ./result_10chains/node267_9_0.txt &
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
    "./result_10chains/node267_0_0.txt 90"
    "./result_10chains/node267_0_2.txt 90"
    "./result_10chains/node267_1_0.txt 89"
    "./result_10chains/node267_1_2.txt 89"
    "./result_10chains/node267_2_0.txt 88"
    "./result_10chains/node267_2_2.txt 88"
    "./result_10chains/node267_3_0.txt 87"
    "./result_10chains/node267_3_2.txt 87"
    "./result_10chains/node267_4_0.txt 86"
    "./result_10chains/node267_4_2.txt 86"
    "./result_10chains/node267_5_0.txt 85"
    "./result_10chains/node267_5_2.txt 85"
    "./result_10chains/node267_6_0.txt 84"
    "./result_10chains/node267_6_2.txt 84"
    "./result_10chains/node267_7_0.txt 83"
    "./result_10chains/node267_7_2.txt 83"
    "./result_10chains/node267_8_0.txt 82"
    "./result_10chains/node267_8_2.txt 82"
    "./result_10chains/node267_9_0.txt 81"
    "./result_10chains/node267_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

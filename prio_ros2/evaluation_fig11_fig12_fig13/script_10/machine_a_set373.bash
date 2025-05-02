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
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_2 -p 29 -st topic373_0_1 -pt None -u 0.00505326810961193 > ./result_10chains/node373_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_2 -p 83 -st topic373_1_1 -pt None -u 0.03502356880777663 > ./result_10chains/node373_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_2 -p 198 -st topic373_2_1 -pt None -u 0.007535148227260979 > ./result_10chains/node373_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_2 -p 241 -st topic373_3_1 -pt None -u 0.03597732959416017 > ./result_10chains/node373_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_2 -p 491 -st topic373_4_1 -pt None -u 0.022412631349804008 > ./result_10chains/node373_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_2 -p 565 -st topic373_5_1 -pt None -u 0.014401964432354586 > ./result_10chains/node373_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_6_2 -p 602 -st topic373_6_1 -pt None -u 0.014852949214809036 > ./result_10chains/node373_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_7_2 -p 662 -st topic373_7_1 -pt None -u 0.0006581052798603215 > ./result_10chains/node373_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_8_2 -p 862 -st topic373_8_1 -pt None -u 0.005933238329416543 > ./result_10chains/node373_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_9_2 -p 888 -st topic373_9_1 -pt None -u 0.022651560612299167 > ./result_10chains/node373_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_0 -p 29 -st none -pt topic373_0_0 -u 0.032897629164983844 > ./result_10chains/node373_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_0 -p 83 -st none -pt topic373_1_0 -u 0.0014025896809220506 > ./result_10chains/node373_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_0 -p 198 -st none -pt topic373_2_0 -u 0.00891780501483641 > ./result_10chains/node373_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_0 -p 241 -st none -pt topic373_3_0 -u 0.01403594848470835 > ./result_10chains/node373_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_0 -p 491 -st none -pt topic373_4_0 -u 0.004674919941513589 > ./result_10chains/node373_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_0 -p 565 -st none -pt topic373_5_0 -u 0.002285502864633554 > ./result_10chains/node373_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_6_0 -p 602 -st none -pt topic373_6_0 -u 0.015341465069594995 > ./result_10chains/node373_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_7_0 -p 662 -st none -pt topic373_7_0 -u 0.019008147834181754 > ./result_10chains/node373_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_8_0 -p 862 -st none -pt topic373_8_0 -u 0.022565403390085392 > ./result_10chains/node373_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_9_0 -p 888 -st none -pt topic373_9_0 -u 0.0432448279039809 > ./result_10chains/node373_9_0.txt &
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
    "./result_10chains/node373_0_0.txt 90"
    "./result_10chains/node373_0_2.txt 90"
    "./result_10chains/node373_1_0.txt 89"
    "./result_10chains/node373_1_2.txt 89"
    "./result_10chains/node373_2_0.txt 88"
    "./result_10chains/node373_2_2.txt 88"
    "./result_10chains/node373_3_0.txt 87"
    "./result_10chains/node373_3_2.txt 87"
    "./result_10chains/node373_4_0.txt 86"
    "./result_10chains/node373_4_2.txt 86"
    "./result_10chains/node373_5_0.txt 85"
    "./result_10chains/node373_5_2.txt 85"
    "./result_10chains/node373_6_0.txt 84"
    "./result_10chains/node373_6_2.txt 84"
    "./result_10chains/node373_7_0.txt 83"
    "./result_10chains/node373_7_2.txt 83"
    "./result_10chains/node373_8_0.txt 82"
    "./result_10chains/node373_8_2.txt 82"
    "./result_10chains/node373_9_0.txt 81"
    "./result_10chains/node373_9_2.txt 81"
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

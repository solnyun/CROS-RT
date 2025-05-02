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
ros2 run evaluation_3_randomdag uunifast_node -n node166_0_2 -p 10 -st topic166_0_1 -pt None -u 0.0249246407333939 > ./result_10chains/node166_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_1_2 -p 68 -st topic166_1_1 -pt None -u 0.02695191960914567 > ./result_10chains/node166_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_2_2 -p 223 -st topic166_2_1 -pt None -u 0.023387582322634437 > ./result_10chains/node166_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_3_2 -p 245 -st topic166_3_1 -pt None -u 0.0021429177191408244 > ./result_10chains/node166_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_4_2 -p 308 -st topic166_4_1 -pt None -u 0.030228971803298588 > ./result_10chains/node166_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_5_2 -p 469 -st topic166_5_1 -pt None -u 0.022311204861271722 > ./result_10chains/node166_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_6_2 -p 624 -st topic166_6_1 -pt None -u 0.04469467388856431 > ./result_10chains/node166_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_7_2 -p 691 -st topic166_7_1 -pt None -u 0.005935843318696801 > ./result_10chains/node166_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_8_2 -p 694 -st topic166_8_1 -pt None -u 0.02945933675098914 > ./result_10chains/node166_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_9_2 -p 868 -st topic166_9_1 -pt None -u 0.026266266582439957 > ./result_10chains/node166_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_0_0 -p 10 -st none -pt topic166_0_0 -u 0.005396900276260219 > ./result_10chains/node166_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_1_0 -p 68 -st none -pt topic166_1_0 -u 0.024810383831684713 > ./result_10chains/node166_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_2_0 -p 223 -st none -pt topic166_2_0 -u 0.007982411470294326 > ./result_10chains/node166_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_3_0 -p 245 -st none -pt topic166_3_0 -u 0.0056535270854425335 > ./result_10chains/node166_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_4_0 -p 308 -st none -pt topic166_4_0 -u 0.005850332732253938 > ./result_10chains/node166_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_5_0 -p 469 -st none -pt topic166_5_0 -u 0.0008318932957138148 > ./result_10chains/node166_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_6_0 -p 624 -st none -pt topic166_6_0 -u 0.030435636084326978 > ./result_10chains/node166_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_7_0 -p 691 -st none -pt topic166_7_0 -u 0.01363484420163115 > ./result_10chains/node166_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_8_0 -p 694 -st none -pt topic166_8_0 -u 0.0010711957143597906 > ./result_10chains/node166_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_9_0 -p 868 -st none -pt topic166_9_0 -u 0.0011689207421306316 > ./result_10chains/node166_9_0.txt &
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
    "./result_10chains/node166_0_0.txt 90"
    "./result_10chains/node166_0_2.txt 90"
    "./result_10chains/node166_1_0.txt 89"
    "./result_10chains/node166_1_2.txt 89"
    "./result_10chains/node166_2_0.txt 88"
    "./result_10chains/node166_2_2.txt 88"
    "./result_10chains/node166_3_0.txt 87"
    "./result_10chains/node166_3_2.txt 87"
    "./result_10chains/node166_4_0.txt 86"
    "./result_10chains/node166_4_2.txt 86"
    "./result_10chains/node166_5_0.txt 85"
    "./result_10chains/node166_5_2.txt 85"
    "./result_10chains/node166_6_0.txt 84"
    "./result_10chains/node166_6_2.txt 84"
    "./result_10chains/node166_7_0.txt 83"
    "./result_10chains/node166_7_2.txt 83"
    "./result_10chains/node166_8_0.txt 82"
    "./result_10chains/node166_8_2.txt 82"
    "./result_10chains/node166_9_0.txt 81"
    "./result_10chains/node166_9_2.txt 81"
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

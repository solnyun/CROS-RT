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
ros2 run evaluation_3_randomdag uunifast_node -n node242_0_2 -p 119 -st topic242_0_1 -pt None -u 0.009570190277224833 > ./result_10chains/node242_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_1_2 -p 222 -st topic242_1_1 -pt None -u 0.043100980497548125 > ./result_10chains/node242_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_2_2 -p 270 -st topic242_2_1 -pt None -u 0.002221167348039843 > ./result_10chains/node242_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_3_2 -p 356 -st topic242_3_1 -pt None -u 0.0028436847770709206 > ./result_10chains/node242_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_4_2 -p 393 -st topic242_4_1 -pt None -u 0.0023013066166265306 > ./result_10chains/node242_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_5_2 -p 503 -st topic242_5_1 -pt None -u 0.010306257817775638 > ./result_10chains/node242_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_6_2 -p 764 -st topic242_6_1 -pt None -u 0.002341907563522483 > ./result_10chains/node242_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_7_2 -p 828 -st topic242_7_1 -pt None -u 0.03352866414500161 > ./result_10chains/node242_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_8_2 -p 892 -st topic242_8_1 -pt None -u 0.02250569968515809 > ./result_10chains/node242_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_9_2 -p 910 -st topic242_9_1 -pt None -u 0.003495921694196337 > ./result_10chains/node242_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_0_0 -p 119 -st none -pt topic242_0_0 -u 0.014236526628071788 > ./result_10chains/node242_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_1_0 -p 222 -st none -pt topic242_1_0 -u 0.02223436497711878 > ./result_10chains/node242_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_2_0 -p 270 -st none -pt topic242_2_0 -u 0.009545429400431682 > ./result_10chains/node242_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_3_0 -p 356 -st none -pt topic242_3_0 -u 0.004787378486156291 > ./result_10chains/node242_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_4_0 -p 393 -st none -pt topic242_4_0 -u 0.02023922083389934 > ./result_10chains/node242_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_5_0 -p 503 -st none -pt topic242_5_0 -u 0.000500735629878124 > ./result_10chains/node242_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_6_0 -p 764 -st none -pt topic242_6_0 -u 0.06328136073202126 > ./result_10chains/node242_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_7_0 -p 828 -st none -pt topic242_7_0 -u 0.02185552704616836 > ./result_10chains/node242_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node242_8_0 -p 892 -st none -pt topic242_8_0 -u 0.006536362133683762 > ./result_10chains/node242_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node242_9_0 -p 910 -st none -pt topic242_9_0 -u 0.0050347086401617384 > ./result_10chains/node242_9_0.txt &
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
    "./result_10chains/node242_0_0.txt 90"
    "./result_10chains/node242_0_2.txt 90"
    "./result_10chains/node242_1_0.txt 89"
    "./result_10chains/node242_1_2.txt 89"
    "./result_10chains/node242_2_0.txt 88"
    "./result_10chains/node242_2_2.txt 88"
    "./result_10chains/node242_3_0.txt 87"
    "./result_10chains/node242_3_2.txt 87"
    "./result_10chains/node242_4_0.txt 86"
    "./result_10chains/node242_4_2.txt 86"
    "./result_10chains/node242_5_0.txt 85"
    "./result_10chains/node242_5_2.txt 85"
    "./result_10chains/node242_6_0.txt 84"
    "./result_10chains/node242_6_2.txt 84"
    "./result_10chains/node242_7_0.txt 83"
    "./result_10chains/node242_7_2.txt 83"
    "./result_10chains/node242_8_0.txt 82"
    "./result_10chains/node242_8_2.txt 82"
    "./result_10chains/node242_9_0.txt 81"
    "./result_10chains/node242_9_2.txt 81"
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

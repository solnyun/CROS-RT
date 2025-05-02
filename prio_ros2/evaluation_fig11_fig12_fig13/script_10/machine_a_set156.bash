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
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_2 -p 123 -st topic156_0_1 -pt None -u 0.04354542429948227 > ./result_10chains/node156_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_2 -p 203 -st topic156_1_1 -pt None -u 0.008312215514796273 > ./result_10chains/node156_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_2 -p 352 -st topic156_2_1 -pt None -u 0.000516576499377086 > ./result_10chains/node156_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_2 -p 366 -st topic156_3_1 -pt None -u 0.02605216884065359 > ./result_10chains/node156_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_2 -p 424 -st topic156_4_1 -pt None -u 0.002335088503286342 > ./result_10chains/node156_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_2 -p 523 -st topic156_5_1 -pt None -u 0.0007953157049136739 > ./result_10chains/node156_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_6_2 -p 616 -st topic156_6_1 -pt None -u 0.022028778198300625 > ./result_10chains/node156_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_7_2 -p 617 -st topic156_7_1 -pt None -u 0.005826769941079529 > ./result_10chains/node156_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_8_2 -p 901 -st topic156_8_1 -pt None -u 0.02329320507069639 > ./result_10chains/node156_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_9_2 -p 999 -st topic156_9_1 -pt None -u 0.03760105096224927 > ./result_10chains/node156_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_0_0 -p 123 -st none -pt topic156_0_0 -u 0.0024905087939116055 > ./result_10chains/node156_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_1_0 -p 203 -st none -pt topic156_1_0 -u 0.020837428048742335 > ./result_10chains/node156_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_2_0 -p 352 -st none -pt topic156_2_0 -u 0.0497932527606178 > ./result_10chains/node156_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_3_0 -p 366 -st none -pt topic156_3_0 -u 0.007200935425113408 > ./result_10chains/node156_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_4_0 -p 424 -st none -pt topic156_4_0 -u 0.007371917786277188 > ./result_10chains/node156_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_5_0 -p 523 -st none -pt topic156_5_0 -u 0.006969181231863075 > ./result_10chains/node156_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_6_0 -p 616 -st none -pt topic156_6_0 -u 0.00222524130363555 > ./result_10chains/node156_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_7_0 -p 617 -st none -pt topic156_7_0 -u 0.03459975265282422 > ./result_10chains/node156_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node156_8_0 -p 901 -st none -pt topic156_8_0 -u 0.021356990847361132 > ./result_10chains/node156_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node156_9_0 -p 999 -st none -pt topic156_9_0 -u 0.028379184591152316 > ./result_10chains/node156_9_0.txt &
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
    "./result_10chains/node156_0_0.txt 90"
    "./result_10chains/node156_0_2.txt 90"
    "./result_10chains/node156_1_0.txt 89"
    "./result_10chains/node156_1_2.txt 89"
    "./result_10chains/node156_2_0.txt 88"
    "./result_10chains/node156_2_2.txt 88"
    "./result_10chains/node156_3_0.txt 87"
    "./result_10chains/node156_3_2.txt 87"
    "./result_10chains/node156_4_0.txt 86"
    "./result_10chains/node156_4_2.txt 86"
    "./result_10chains/node156_5_0.txt 85"
    "./result_10chains/node156_5_2.txt 85"
    "./result_10chains/node156_6_0.txt 84"
    "./result_10chains/node156_6_2.txt 84"
    "./result_10chains/node156_7_0.txt 83"
    "./result_10chains/node156_7_2.txt 83"
    "./result_10chains/node156_8_0.txt 82"
    "./result_10chains/node156_8_2.txt 82"
    "./result_10chains/node156_9_0.txt 81"
    "./result_10chains/node156_9_2.txt 81"
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

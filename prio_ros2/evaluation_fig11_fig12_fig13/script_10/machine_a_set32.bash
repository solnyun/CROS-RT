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
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_2 -p 36 -st topic32_0_1 -pt None -u 0.0224707276159426 > ./result_10chains/node32_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_2 -p 149 -st topic32_1_1 -pt None -u 0.011782574093735898 > ./result_10chains/node32_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_2 -p 330 -st topic32_2_1 -pt None -u 0.01791750291227051 > ./result_10chains/node32_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_2 -p 483 -st topic32_3_1 -pt None -u 0.015546028193198558 > ./result_10chains/node32_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_2 -p 510 -st topic32_4_1 -pt None -u 0.005096008307916511 > ./result_10chains/node32_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_2 -p 574 -st topic32_5_1 -pt None -u 0.006744074131160821 > ./result_10chains/node32_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_6_2 -p 643 -st topic32_6_1 -pt None -u 0.022205907821158277 > ./result_10chains/node32_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_7_2 -p 681 -st topic32_7_1 -pt None -u 0.000981647179565906 > ./result_10chains/node32_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_8_2 -p 808 -st topic32_8_1 -pt None -u 0.01253279699322633 > ./result_10chains/node32_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_9_2 -p 991 -st topic32_9_1 -pt None -u 0.020768992697255892 > ./result_10chains/node32_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_0_0 -p 36 -st none -pt topic32_0_0 -u 0.0117535147767579 > ./result_10chains/node32_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_1_0 -p 149 -st none -pt topic32_1_0 -u 0.06531656987154194 > ./result_10chains/node32_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_2_0 -p 330 -st none -pt topic32_2_0 -u 0.0094599045398025 > ./result_10chains/node32_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_3_0 -p 483 -st none -pt topic32_3_0 -u 0.015168963053715179 > ./result_10chains/node32_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_4_0 -p 510 -st none -pt topic32_4_0 -u 0.018847827744824464 > ./result_10chains/node32_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_5_0 -p 574 -st none -pt topic32_5_0 -u 0.035480195673222525 > ./result_10chains/node32_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_6_0 -p 643 -st none -pt topic32_6_0 -u 0.00772922332762746 > ./result_10chains/node32_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_7_0 -p 681 -st none -pt topic32_7_0 -u 0.02987769305437428 > ./result_10chains/node32_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node32_8_0 -p 808 -st none -pt topic32_8_0 -u 0.05319718438323604 > ./result_10chains/node32_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node32_9_0 -p 991 -st none -pt topic32_9_0 -u 0.004698107316253055 > ./result_10chains/node32_9_0.txt &
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
    "./result_10chains/node32_0_0.txt 90"
    "./result_10chains/node32_0_2.txt 90"
    "./result_10chains/node32_1_0.txt 89"
    "./result_10chains/node32_1_2.txt 89"
    "./result_10chains/node32_2_0.txt 88"
    "./result_10chains/node32_2_2.txt 88"
    "./result_10chains/node32_3_0.txt 87"
    "./result_10chains/node32_3_2.txt 87"
    "./result_10chains/node32_4_0.txt 86"
    "./result_10chains/node32_4_2.txt 86"
    "./result_10chains/node32_5_0.txt 85"
    "./result_10chains/node32_5_2.txt 85"
    "./result_10chains/node32_6_0.txt 84"
    "./result_10chains/node32_6_2.txt 84"
    "./result_10chains/node32_7_0.txt 83"
    "./result_10chains/node32_7_2.txt 83"
    "./result_10chains/node32_8_0.txt 82"
    "./result_10chains/node32_8_2.txt 82"
    "./result_10chains/node32_9_0.txt 81"
    "./result_10chains/node32_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

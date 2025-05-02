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
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_2 -p 12 -st topic54_0_1 -pt None -u 0.00250049523172291 > ./result_10chains/node54_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_2 -p 16 -st topic54_1_1 -pt None -u 0.0007614063005613181 > ./result_10chains/node54_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_2 -p 319 -st topic54_2_1 -pt None -u 0.029308880572140927 > ./result_10chains/node54_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_2 -p 374 -st topic54_3_1 -pt None -u 0.0002506137568458189 > ./result_10chains/node54_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_2 -p 399 -st topic54_4_1 -pt None -u 0.02479582381459855 > ./result_10chains/node54_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_2 -p 555 -st topic54_5_1 -pt None -u 0.02779291046869009 > ./result_10chains/node54_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_6_2 -p 623 -st topic54_6_1 -pt None -u 0.004879306640447945 > ./result_10chains/node54_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_7_2 -p 709 -st topic54_7_1 -pt None -u 0.00541613313269948 > ./result_10chains/node54_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_8_2 -p 848 -st topic54_8_1 -pt None -u 0.014176132482003959 > ./result_10chains/node54_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_9_2 -p 974 -st topic54_9_1 -pt None -u 0.041394282537655175 > ./result_10chains/node54_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_0_0 -p 12 -st none -pt topic54_0_0 -u 0.005023406720562118 > ./result_10chains/node54_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_1_0 -p 16 -st none -pt topic54_1_0 -u 0.01928182381152399 > ./result_10chains/node54_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_2_0 -p 319 -st none -pt topic54_2_0 -u 0.015963491378318484 > ./result_10chains/node54_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_3_0 -p 374 -st none -pt topic54_3_0 -u 0.0031186616940905854 > ./result_10chains/node54_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_4_0 -p 399 -st none -pt topic54_4_0 -u 0.005865149567052863 > ./result_10chains/node54_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_5_0 -p 555 -st none -pt topic54_5_0 -u 0.010023382154041305 > ./result_10chains/node54_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_6_0 -p 623 -st none -pt topic54_6_0 -u 0.006089407392404322 > ./result_10chains/node54_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_7_0 -p 709 -st none -pt topic54_7_0 -u 0.004662208548615987 > ./result_10chains/node54_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node54_8_0 -p 848 -st none -pt topic54_8_0 -u 0.07090870175399715 > ./result_10chains/node54_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node54_9_0 -p 974 -st none -pt topic54_9_0 -u 0.030561729908308563 > ./result_10chains/node54_9_0.txt &
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
    "./result_10chains/node54_0_0.txt 90"
    "./result_10chains/node54_0_2.txt 90"
    "./result_10chains/node54_1_0.txt 89"
    "./result_10chains/node54_1_2.txt 89"
    "./result_10chains/node54_2_0.txt 88"
    "./result_10chains/node54_2_2.txt 88"
    "./result_10chains/node54_3_0.txt 87"
    "./result_10chains/node54_3_2.txt 87"
    "./result_10chains/node54_4_0.txt 86"
    "./result_10chains/node54_4_2.txt 86"
    "./result_10chains/node54_5_0.txt 85"
    "./result_10chains/node54_5_2.txt 85"
    "./result_10chains/node54_6_0.txt 84"
    "./result_10chains/node54_6_2.txt 84"
    "./result_10chains/node54_7_0.txt 83"
    "./result_10chains/node54_7_2.txt 83"
    "./result_10chains/node54_8_0.txt 82"
    "./result_10chains/node54_8_2.txt 82"
    "./result_10chains/node54_9_0.txt 81"
    "./result_10chains/node54_9_2.txt 81"
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

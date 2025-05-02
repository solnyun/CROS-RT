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
ros2 run evaluation_3_randomdag uunifast_node -n node62_0_2 -p 167 -st topic62_0_1 -pt None -u 0.0005686622405496333 > ./result_10chains/node62_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_1_2 -p 213 -st topic62_1_1 -pt None -u 0.003198692862381558 > ./result_10chains/node62_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_2_2 -p 345 -st topic62_2_1 -pt None -u 0.07587410496476638 > ./result_10chains/node62_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_3_2 -p 357 -st topic62_3_1 -pt None -u 0.0022431986466731335 > ./result_10chains/node62_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_4_2 -p 428 -st topic62_4_1 -pt None -u 0.033294153733135906 > ./result_10chains/node62_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_5_2 -p 501 -st topic62_5_1 -pt None -u 0.017323707507879205 > ./result_10chains/node62_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_6_2 -p 614 -st topic62_6_1 -pt None -u 0.0235597147186139 > ./result_10chains/node62_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_7_2 -p 843 -st topic62_7_1 -pt None -u 0.0022983927986249125 > ./result_10chains/node62_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_8_2 -p 902 -st topic62_8_1 -pt None -u 0.00464889705439632 > ./result_10chains/node62_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_9_2 -p 920 -st topic62_9_1 -pt None -u 0.029923358984111942 > ./result_10chains/node62_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_0_0 -p 167 -st none -pt topic62_0_0 -u 0.004620851106031554 > ./result_10chains/node62_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_1_0 -p 213 -st none -pt topic62_1_0 -u 0.001850598794171432 > ./result_10chains/node62_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_2_0 -p 345 -st none -pt topic62_2_0 -u 0.014767580665432933 > ./result_10chains/node62_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_3_0 -p 357 -st none -pt topic62_3_0 -u 0.01924946017648277 > ./result_10chains/node62_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_4_0 -p 428 -st none -pt topic62_4_0 -u 0.007254123695012771 > ./result_10chains/node62_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_5_0 -p 501 -st none -pt topic62_5_0 -u 0.00988760404412059 > ./result_10chains/node62_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_6_0 -p 614 -st none -pt topic62_6_0 -u 0.009693087088053817 > ./result_10chains/node62_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_7_0 -p 843 -st none -pt topic62_7_0 -u 0.020526063692542548 > ./result_10chains/node62_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node62_8_0 -p 902 -st none -pt topic62_8_0 -u 0.013845742338275492 > ./result_10chains/node62_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node62_9_0 -p 920 -st none -pt topic62_9_0 -u 0.0012079178200464294 > ./result_10chains/node62_9_0.txt &
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
    "./result_10chains/node62_0_0.txt 90"
    "./result_10chains/node62_0_2.txt 90"
    "./result_10chains/node62_1_0.txt 89"
    "./result_10chains/node62_1_2.txt 89"
    "./result_10chains/node62_2_0.txt 88"
    "./result_10chains/node62_2_2.txt 88"
    "./result_10chains/node62_3_0.txt 87"
    "./result_10chains/node62_3_2.txt 87"
    "./result_10chains/node62_4_0.txt 86"
    "./result_10chains/node62_4_2.txt 86"
    "./result_10chains/node62_5_0.txt 85"
    "./result_10chains/node62_5_2.txt 85"
    "./result_10chains/node62_6_0.txt 84"
    "./result_10chains/node62_6_2.txt 84"
    "./result_10chains/node62_7_0.txt 83"
    "./result_10chains/node62_7_2.txt 83"
    "./result_10chains/node62_8_0.txt 82"
    "./result_10chains/node62_8_2.txt 82"
    "./result_10chains/node62_9_0.txt 81"
    "./result_10chains/node62_9_2.txt 81"
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

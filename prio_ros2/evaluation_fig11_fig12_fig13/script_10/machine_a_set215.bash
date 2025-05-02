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
ros2 run evaluation_3_randomdag uunifast_node -n node215_0_2 -p 265 -st topic215_0_1 -pt None -u 0.006852620431869905 > ./result_10chains/node215_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_1_2 -p 414 -st topic215_1_1 -pt None -u 0.0006848301561964143 > ./result_10chains/node215_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_2_2 -p 419 -st topic215_2_1 -pt None -u 0.012649327486634998 > ./result_10chains/node215_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_3_2 -p 571 -st topic215_3_1 -pt None -u 0.03581165533432906 > ./result_10chains/node215_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_4_2 -p 687 -st topic215_4_1 -pt None -u 0.00019547493276189654 > ./result_10chains/node215_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_5_2 -p 762 -st topic215_5_1 -pt None -u 0.0027300236076787665 > ./result_10chains/node215_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_6_2 -p 776 -st topic215_6_1 -pt None -u 0.03162536607716382 > ./result_10chains/node215_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_7_2 -p 783 -st topic215_7_1 -pt None -u 0.01772358876527673 > ./result_10chains/node215_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_8_2 -p 807 -st topic215_8_1 -pt None -u 0.02010767940625323 > ./result_10chains/node215_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_9_2 -p 841 -st topic215_9_1 -pt None -u 0.009703018571866714 > ./result_10chains/node215_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_0_0 -p 265 -st none -pt topic215_0_0 -u 0.013043727624940216 > ./result_10chains/node215_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_1_0 -p 414 -st none -pt topic215_1_0 -u 0.02763051568431557 > ./result_10chains/node215_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_2_0 -p 419 -st none -pt topic215_2_0 -u 0.027356520813468066 > ./result_10chains/node215_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_3_0 -p 571 -st none -pt topic215_3_0 -u 0.0007870551839055939 > ./result_10chains/node215_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_4_0 -p 687 -st none -pt topic215_4_0 -u 0.048538877658053314 > ./result_10chains/node215_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_5_0 -p 762 -st none -pt topic215_5_0 -u 0.013246318526094869 > ./result_10chains/node215_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_6_0 -p 776 -st none -pt topic215_6_0 -u 0.020341175829959257 > ./result_10chains/node215_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_7_0 -p 783 -st none -pt topic215_7_0 -u 0.05990234363372729 > ./result_10chains/node215_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node215_8_0 -p 807 -st none -pt topic215_8_0 -u 0.01620218905916325 > ./result_10chains/node215_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node215_9_0 -p 841 -st none -pt topic215_9_0 -u 0.04243782558236036 > ./result_10chains/node215_9_0.txt &
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
    "./result_10chains/node215_0_0.txt 90"
    "./result_10chains/node215_0_2.txt 90"
    "./result_10chains/node215_1_0.txt 89"
    "./result_10chains/node215_1_2.txt 89"
    "./result_10chains/node215_2_0.txt 88"
    "./result_10chains/node215_2_2.txt 88"
    "./result_10chains/node215_3_0.txt 87"
    "./result_10chains/node215_3_2.txt 87"
    "./result_10chains/node215_4_0.txt 86"
    "./result_10chains/node215_4_2.txt 86"
    "./result_10chains/node215_5_0.txt 85"
    "./result_10chains/node215_5_2.txt 85"
    "./result_10chains/node215_6_0.txt 84"
    "./result_10chains/node215_6_2.txt 84"
    "./result_10chains/node215_7_0.txt 83"
    "./result_10chains/node215_7_2.txt 83"
    "./result_10chains/node215_8_0.txt 82"
    "./result_10chains/node215_8_2.txt 82"
    "./result_10chains/node215_9_0.txt 81"
    "./result_10chains/node215_9_2.txt 81"
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

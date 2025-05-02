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
ros2 run evaluation_3_randomdag uunifast_node -n node493_0_2 -p 188 -st topic493_0_1 -pt None -u 0.000186989854666475 > ./result_10chains/node493_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_1_2 -p 248 -st topic493_1_1 -pt None -u 0.0011640642987641447 > ./result_10chains/node493_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_2_2 -p 360 -st topic493_2_1 -pt None -u 0.022040416971440324 > ./result_10chains/node493_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_3_2 -p 422 -st topic493_3_1 -pt None -u 0.009668773387101981 > ./result_10chains/node493_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_4_2 -p 527 -st topic493_4_1 -pt None -u 0.023330594073289135 > ./result_10chains/node493_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_5_2 -p 712 -st topic493_5_1 -pt None -u 0.018268354658079966 > ./result_10chains/node493_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_6_2 -p 820 -st topic493_6_1 -pt None -u 0.016058250687089937 > ./result_10chains/node493_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_7_2 -p 837 -st topic493_7_1 -pt None -u 0.04347947920520638 > ./result_10chains/node493_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_8_2 -p 848 -st topic493_8_1 -pt None -u 0.020056934526601365 > ./result_10chains/node493_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_9_2 -p 887 -st topic493_9_1 -pt None -u 0.023236008042684463 > ./result_10chains/node493_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_0_0 -p 188 -st none -pt topic493_0_0 -u 0.015612557335885346 > ./result_10chains/node493_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_1_0 -p 248 -st none -pt topic493_1_0 -u 0.016543360953119368 > ./result_10chains/node493_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_2_0 -p 360 -st none -pt topic493_2_0 -u 0.00918715384334895 > ./result_10chains/node493_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_3_0 -p 422 -st none -pt topic493_3_0 -u 0.02533533171572805 > ./result_10chains/node493_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_4_0 -p 527 -st none -pt topic493_4_0 -u 0.007796202112276773 > ./result_10chains/node493_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_5_0 -p 712 -st none -pt topic493_5_0 -u 0.004023733283088526 > ./result_10chains/node493_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_6_0 -p 820 -st none -pt topic493_6_0 -u 0.03983558940513593 > ./result_10chains/node493_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_7_0 -p 837 -st none -pt topic493_7_0 -u 0.037902934036309816 > ./result_10chains/node493_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node493_8_0 -p 848 -st none -pt topic493_8_0 -u 0.01039165209392122 > ./result_10chains/node493_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node493_9_0 -p 887 -st none -pt topic493_9_0 -u 0.003909915865414056 > ./result_10chains/node493_9_0.txt &
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
    "./result_10chains/node493_0_0.txt 90"
    "./result_10chains/node493_0_2.txt 90"
    "./result_10chains/node493_1_0.txt 89"
    "./result_10chains/node493_1_2.txt 89"
    "./result_10chains/node493_2_0.txt 88"
    "./result_10chains/node493_2_2.txt 88"
    "./result_10chains/node493_3_0.txt 87"
    "./result_10chains/node493_3_2.txt 87"
    "./result_10chains/node493_4_0.txt 86"
    "./result_10chains/node493_4_2.txt 86"
    "./result_10chains/node493_5_0.txt 85"
    "./result_10chains/node493_5_2.txt 85"
    "./result_10chains/node493_6_0.txt 84"
    "./result_10chains/node493_6_2.txt 84"
    "./result_10chains/node493_7_0.txt 83"
    "./result_10chains/node493_7_2.txt 83"
    "./result_10chains/node493_8_0.txt 82"
    "./result_10chains/node493_8_2.txt 82"
    "./result_10chains/node493_9_0.txt 81"
    "./result_10chains/node493_9_2.txt 81"
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

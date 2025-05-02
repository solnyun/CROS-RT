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
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_2 -p 258 -st topic169_0_1 -pt None -u 0.03681849044554669 > ./result_8chains/node169_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_2 -p 546 -st topic169_1_1 -pt None -u 0.026057385492977092 > ./result_8chains/node169_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_2 -p 590 -st topic169_2_1 -pt None -u 0.02926497924217164 > ./result_8chains/node169_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_2 -p 639 -st topic169_3_1 -pt None -u 0.04003332107449281 > ./result_8chains/node169_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_4_2 -p 782 -st topic169_4_1 -pt None -u 0.012679375240474744 > ./result_8chains/node169_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_5_2 -p 783 -st topic169_5_1 -pt None -u 0.004885389748952543 > ./result_8chains/node169_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_6_2 -p 849 -st topic169_6_1 -pt None -u 0.006408950576389856 > ./result_8chains/node169_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_7_2 -p 950 -st topic169_7_1 -pt None -u 0.013921164228940072 > ./result_8chains/node169_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_0_0 -p 258 -st none -pt topic169_0_0 -u 0.031110847018140042 > ./result_8chains/node169_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_1_0 -p 546 -st none -pt topic169_1_0 -u 5.419290475261462e-07 > ./result_8chains/node169_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_2_0 -p 590 -st none -pt topic169_2_0 -u 0.018049464296434448 > ./result_8chains/node169_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_3_0 -p 639 -st none -pt topic169_3_0 -u 0.0056275236610789925 > ./result_8chains/node169_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_4_0 -p 782 -st none -pt topic169_4_0 -u 0.034138172173789866 > ./result_8chains/node169_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_5_0 -p 783 -st none -pt topic169_5_0 -u 0.015457248622261943 > ./result_8chains/node169_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node169_6_0 -p 849 -st none -pt topic169_6_0 -u 0.032772130434239544 > ./result_8chains/node169_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node169_7_0 -p 950 -st none -pt topic169_7_0 -u 0.024941473403981618 > ./result_8chains/node169_7_0.txt &
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
    "./result_8chains/node169_0_0.txt 90"
    "./result_8chains/node169_0_2.txt 90"
    "./result_8chains/node169_1_0.txt 89"
    "./result_8chains/node169_1_2.txt 89"
    "./result_8chains/node169_2_0.txt 88"
    "./result_8chains/node169_2_2.txt 88"
    "./result_8chains/node169_3_0.txt 87"
    "./result_8chains/node169_3_2.txt 87"
    "./result_8chains/node169_4_0.txt 86"
    "./result_8chains/node169_4_2.txt 86"
    "./result_8chains/node169_5_0.txt 85"
    "./result_8chains/node169_5_2.txt 85"
    "./result_8chains/node169_6_0.txt 84"
    "./result_8chains/node169_6_2.txt 84"
    "./result_8chains/node169_7_0.txt 83"
    "./result_8chains/node169_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

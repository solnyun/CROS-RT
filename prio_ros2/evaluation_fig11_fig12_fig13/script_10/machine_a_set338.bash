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
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_2 -p 16 -st topic338_0_1 -pt None -u 0.0010243678388821564 > ./result_10chains/node338_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_2 -p 243 -st topic338_1_1 -pt None -u 0.004793462851122143 > ./result_10chains/node338_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_2 -p 246 -st topic338_2_1 -pt None -u 0.008250276139011525 > ./result_10chains/node338_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_2 -p 414 -st topic338_3_1 -pt None -u 0.015805794439856524 > ./result_10chains/node338_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_2 -p 699 -st topic338_4_1 -pt None -u 0.03586322323380986 > ./result_10chains/node338_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_2 -p 729 -st topic338_5_1 -pt None -u 0.06953505345355013 > ./result_10chains/node338_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_6_2 -p 753 -st topic338_6_1 -pt None -u 0.000985258050889365 > ./result_10chains/node338_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_7_2 -p 803 -st topic338_7_1 -pt None -u 0.018146712196455028 > ./result_10chains/node338_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_8_2 -p 849 -st topic338_8_1 -pt None -u 0.02689513561467824 > ./result_10chains/node338_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_9_2 -p 866 -st topic338_9_1 -pt None -u 0.02323612013253757 > ./result_10chains/node338_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_0_0 -p 16 -st none -pt topic338_0_0 -u 0.004593545497338758 > ./result_10chains/node338_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_1_0 -p 243 -st none -pt topic338_1_0 -u 0.004883529358190752 > ./result_10chains/node338_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_2_0 -p 246 -st none -pt topic338_2_0 -u 0.01410995369337753 > ./result_10chains/node338_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_3_0 -p 414 -st none -pt topic338_3_0 -u 0.019276456349662963 > ./result_10chains/node338_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_4_0 -p 699 -st none -pt topic338_4_0 -u 0.012270529273885444 > ./result_10chains/node338_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_5_0 -p 729 -st none -pt topic338_5_0 -u 0.015393663459122853 > ./result_10chains/node338_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_6_0 -p 753 -st none -pt topic338_6_0 -u 0.017488611200392606 > ./result_10chains/node338_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_7_0 -p 803 -st none -pt topic338_7_0 -u 0.006915549330747922 > ./result_10chains/node338_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node338_8_0 -p 849 -st none -pt topic338_8_0 -u 0.01276900467368268 > ./result_10chains/node338_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node338_9_0 -p 866 -st none -pt topic338_9_0 -u 0.011151122298595946 > ./result_10chains/node338_9_0.txt &
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
    "./result_10chains/node338_0_0.txt 90"
    "./result_10chains/node338_0_2.txt 90"
    "./result_10chains/node338_1_0.txt 89"
    "./result_10chains/node338_1_2.txt 89"
    "./result_10chains/node338_2_0.txt 88"
    "./result_10chains/node338_2_2.txt 88"
    "./result_10chains/node338_3_0.txt 87"
    "./result_10chains/node338_3_2.txt 87"
    "./result_10chains/node338_4_0.txt 86"
    "./result_10chains/node338_4_2.txt 86"
    "./result_10chains/node338_5_0.txt 85"
    "./result_10chains/node338_5_2.txt 85"
    "./result_10chains/node338_6_0.txt 84"
    "./result_10chains/node338_6_2.txt 84"
    "./result_10chains/node338_7_0.txt 83"
    "./result_10chains/node338_7_2.txt 83"
    "./result_10chains/node338_8_0.txt 82"
    "./result_10chains/node338_8_2.txt 82"
    "./result_10chains/node338_9_0.txt 81"
    "./result_10chains/node338_9_2.txt 81"
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

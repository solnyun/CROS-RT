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
ros2 run evaluation_3_randomdag uunifast_node -n node369_0_2 -p 111 -st topic369_0_1 -pt None -u 0.0036913128064954837 > ./result_10chains/node369_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_1_2 -p 118 -st topic369_1_1 -pt None -u 0.034419899668882814 > ./result_10chains/node369_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_2_2 -p 202 -st topic369_2_1 -pt None -u 0.0031379742837548408 > ./result_10chains/node369_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_3_2 -p 380 -st topic369_3_1 -pt None -u 0.008625928714676934 > ./result_10chains/node369_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_4_2 -p 402 -st topic369_4_1 -pt None -u 0.01556251497298991 > ./result_10chains/node369_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_5_2 -p 446 -st topic369_5_1 -pt None -u 0.02387322070860487 > ./result_10chains/node369_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_6_2 -p 527 -st topic369_6_1 -pt None -u 0.009574103574275891 > ./result_10chains/node369_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_7_2 -p 556 -st topic369_7_1 -pt None -u 0.012521546559148 > ./result_10chains/node369_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_8_2 -p 861 -st topic369_8_1 -pt None -u 0.009139685335412637 > ./result_10chains/node369_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_9_2 -p 889 -st topic369_9_1 -pt None -u 0.0029022078181010127 > ./result_10chains/node369_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_0_0 -p 111 -st none -pt topic369_0_0 -u 0.010555091087313173 > ./result_10chains/node369_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_1_0 -p 118 -st none -pt topic369_1_0 -u 0.015181559133735478 > ./result_10chains/node369_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_2_0 -p 202 -st none -pt topic369_2_0 -u 0.007798911365521466 > ./result_10chains/node369_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_3_0 -p 380 -st none -pt topic369_3_0 -u 0.00923417045053121 > ./result_10chains/node369_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_4_0 -p 402 -st none -pt topic369_4_0 -u 0.006978394110028152 > ./result_10chains/node369_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_5_0 -p 446 -st none -pt topic369_5_0 -u 0.010475373986215591 > ./result_10chains/node369_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_6_0 -p 527 -st none -pt topic369_6_0 -u 0.01793279729184541 > ./result_10chains/node369_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_7_0 -p 556 -st none -pt topic369_7_0 -u 0.024065448141844012 > ./result_10chains/node369_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node369_8_0 -p 861 -st none -pt topic369_8_0 -u 0.049697256519242596 > ./result_10chains/node369_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node369_9_0 -p 889 -st none -pt topic369_9_0 -u 0.013960843913309925 > ./result_10chains/node369_9_0.txt &
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
    "./result_10chains/node369_0_0.txt 90"
    "./result_10chains/node369_0_2.txt 90"
    "./result_10chains/node369_1_0.txt 89"
    "./result_10chains/node369_1_2.txt 89"
    "./result_10chains/node369_2_0.txt 88"
    "./result_10chains/node369_2_2.txt 88"
    "./result_10chains/node369_3_0.txt 87"
    "./result_10chains/node369_3_2.txt 87"
    "./result_10chains/node369_4_0.txt 86"
    "./result_10chains/node369_4_2.txt 86"
    "./result_10chains/node369_5_0.txt 85"
    "./result_10chains/node369_5_2.txt 85"
    "./result_10chains/node369_6_0.txt 84"
    "./result_10chains/node369_6_2.txt 84"
    "./result_10chains/node369_7_0.txt 83"
    "./result_10chains/node369_7_2.txt 83"
    "./result_10chains/node369_8_0.txt 82"
    "./result_10chains/node369_8_2.txt 82"
    "./result_10chains/node369_9_0.txt 81"
    "./result_10chains/node369_9_2.txt 81"
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

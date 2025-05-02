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
ros2 run evaluation_3_randomdag uunifast_node -n node92_0_2 -p 20 -st topic92_0_1 -pt None -u 0.08954638647450092 > ./result_8chains/node92_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_1_2 -p 101 -st topic92_1_1 -pt None -u 0.020243452281388963 > ./result_8chains/node92_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_2_2 -p 221 -st topic92_2_1 -pt None -u 0.0060707465766002555 > ./result_8chains/node92_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_3_2 -p 459 -st topic92_3_1 -pt None -u 0.007696540357601672 > ./result_8chains/node92_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_4_2 -p 541 -st topic92_4_1 -pt None -u 0.010745036059705532 > ./result_8chains/node92_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_5_2 -p 632 -st topic92_5_1 -pt None -u 0.004584866885705793 > ./result_8chains/node92_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_6_2 -p 820 -st topic92_6_1 -pt None -u 0.002471920554599931 > ./result_8chains/node92_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_7_2 -p 930 -st topic92_7_1 -pt None -u 0.026553236026890314 > ./result_8chains/node92_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_0_0 -p 20 -st none -pt topic92_0_0 -u 0.012226674570829155 > ./result_8chains/node92_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_1_0 -p 101 -st none -pt topic92_1_0 -u 0.021343762299240454 > ./result_8chains/node92_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_2_0 -p 221 -st none -pt topic92_2_0 -u 0.004635302078661807 > ./result_8chains/node92_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_3_0 -p 459 -st none -pt topic92_3_0 -u 0.006679803952932217 > ./result_8chains/node92_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_4_0 -p 541 -st none -pt topic92_4_0 -u 0.00966761560060822 > ./result_8chains/node92_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_5_0 -p 632 -st none -pt topic92_5_0 -u 0.054154297073360835 > ./result_8chains/node92_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_6_0 -p 820 -st none -pt topic92_6_0 -u 0.014226354702844939 > ./result_8chains/node92_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_7_0 -p 930 -st none -pt topic92_7_0 -u 0.024442030121085652 > ./result_8chains/node92_7_0.txt &
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
    "./result_8chains/node92_0_0.txt 90"
    "./result_8chains/node92_0_2.txt 90"
    "./result_8chains/node92_1_0.txt 89"
    "./result_8chains/node92_1_2.txt 89"
    "./result_8chains/node92_2_0.txt 88"
    "./result_8chains/node92_2_2.txt 88"
    "./result_8chains/node92_3_0.txt 87"
    "./result_8chains/node92_3_2.txt 87"
    "./result_8chains/node92_4_0.txt 86"
    "./result_8chains/node92_4_2.txt 86"
    "./result_8chains/node92_5_0.txt 85"
    "./result_8chains/node92_5_2.txt 85"
    "./result_8chains/node92_6_0.txt 84"
    "./result_8chains/node92_6_2.txt 84"
    "./result_8chains/node92_7_0.txt 83"
    "./result_8chains/node92_7_2.txt 83"
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

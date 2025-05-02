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
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_2 -p 39 -st topic419_0_1 -pt None -u 0.003268361833047184 > ./result_8chains/node419_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_2 -p 193 -st topic419_1_1 -pt None -u 0.027208455533073717 > ./result_8chains/node419_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_2 -p 205 -st topic419_2_1 -pt None -u 0.028001158027996298 > ./result_8chains/node419_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_2 -p 574 -st topic419_3_1 -pt None -u 0.0008519619121796218 > ./result_8chains/node419_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_2 -p 649 -st topic419_4_1 -pt None -u 0.04702684294445561 > ./result_8chains/node419_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_2 -p 748 -st topic419_5_1 -pt None -u 0.0064451632190723335 > ./result_8chains/node419_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_6_2 -p 798 -st topic419_6_1 -pt None -u 0.004734668380453111 > ./result_8chains/node419_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_7_2 -p 916 -st topic419_7_1 -pt None -u 0.028773888179512774 > ./result_8chains/node419_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_0_0 -p 39 -st none -pt topic419_0_0 -u 0.006942257376587324 > ./result_8chains/node419_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_1_0 -p 193 -st none -pt topic419_1_0 -u 0.025552552489025382 > ./result_8chains/node419_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_2_0 -p 205 -st none -pt topic419_2_0 -u 0.09612657532525137 > ./result_8chains/node419_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_3_0 -p 574 -st none -pt topic419_3_0 -u 0.010641594718147906 > ./result_8chains/node419_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_4_0 -p 649 -st none -pt topic419_4_0 -u 0.0177696157518428 > ./result_8chains/node419_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_5_0 -p 748 -st none -pt topic419_5_0 -u 0.0032431479873258617 > ./result_8chains/node419_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node419_6_0 -p 798 -st none -pt topic419_6_0 -u 0.003844376730064464 > ./result_8chains/node419_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node419_7_0 -p 916 -st none -pt topic419_7_0 -u 0.02557781944715465 > ./result_8chains/node419_7_0.txt &
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
    "./result_8chains/node419_0_0.txt 90"
    "./result_8chains/node419_0_2.txt 90"
    "./result_8chains/node419_1_0.txt 89"
    "./result_8chains/node419_1_2.txt 89"
    "./result_8chains/node419_2_0.txt 88"
    "./result_8chains/node419_2_2.txt 88"
    "./result_8chains/node419_3_0.txt 87"
    "./result_8chains/node419_3_2.txt 87"
    "./result_8chains/node419_4_0.txt 86"
    "./result_8chains/node419_4_2.txt 86"
    "./result_8chains/node419_5_0.txt 85"
    "./result_8chains/node419_5_2.txt 85"
    "./result_8chains/node419_6_0.txt 84"
    "./result_8chains/node419_6_2.txt 84"
    "./result_8chains/node419_7_0.txt 83"
    "./result_8chains/node419_7_2.txt 83"
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

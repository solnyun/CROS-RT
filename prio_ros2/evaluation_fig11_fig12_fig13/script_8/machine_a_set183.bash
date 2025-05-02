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
ros2 run evaluation_3_randomdag uunifast_node -n node183_0_2 -p 78 -st topic183_0_1 -pt None -u 0.009884383197230617 > ./result_8chains/node183_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_1_2 -p 398 -st topic183_1_1 -pt None -u 0.005201422095396646 > ./result_8chains/node183_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_2_2 -p 581 -st topic183_2_1 -pt None -u 0.02195270042495462 > ./result_8chains/node183_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_3_2 -p 607 -st topic183_3_1 -pt None -u 0.09485742029658811 > ./result_8chains/node183_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_4_2 -p 795 -st topic183_4_1 -pt None -u 0.04783445342930712 > ./result_8chains/node183_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_5_2 -p 836 -st topic183_5_1 -pt None -u 0.02505475770834102 > ./result_8chains/node183_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_6_2 -p 880 -st topic183_6_1 -pt None -u 0.011749726645847829 > ./result_8chains/node183_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_7_2 -p 929 -st topic183_7_1 -pt None -u 0.005293867783628615 > ./result_8chains/node183_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_0_0 -p 78 -st none -pt topic183_0_0 -u 0.02886023837213947 > ./result_8chains/node183_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_1_0 -p 398 -st none -pt topic183_1_0 -u 0.031697928675737286 > ./result_8chains/node183_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_2_0 -p 581 -st none -pt topic183_2_0 -u 0.027635819751964552 > ./result_8chains/node183_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_3_0 -p 607 -st none -pt topic183_3_0 -u 0.00036712961371415664 > ./result_8chains/node183_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_4_0 -p 795 -st none -pt topic183_4_0 -u 0.006473945409105536 > ./result_8chains/node183_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_5_0 -p 836 -st none -pt topic183_5_0 -u 0.0052018085425741545 > ./result_8chains/node183_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node183_6_0 -p 880 -st none -pt topic183_6_0 -u 0.01733380302905975 > ./result_8chains/node183_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node183_7_0 -p 929 -st none -pt topic183_7_0 -u 0.024239444415599862 > ./result_8chains/node183_7_0.txt &
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
    "./result_8chains/node183_0_0.txt 90"
    "./result_8chains/node183_0_2.txt 90"
    "./result_8chains/node183_1_0.txt 89"
    "./result_8chains/node183_1_2.txt 89"
    "./result_8chains/node183_2_0.txt 88"
    "./result_8chains/node183_2_2.txt 88"
    "./result_8chains/node183_3_0.txt 87"
    "./result_8chains/node183_3_2.txt 87"
    "./result_8chains/node183_4_0.txt 86"
    "./result_8chains/node183_4_2.txt 86"
    "./result_8chains/node183_5_0.txt 85"
    "./result_8chains/node183_5_2.txt 85"
    "./result_8chains/node183_6_0.txt 84"
    "./result_8chains/node183_6_2.txt 84"
    "./result_8chains/node183_7_0.txt 83"
    "./result_8chains/node183_7_2.txt 83"
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

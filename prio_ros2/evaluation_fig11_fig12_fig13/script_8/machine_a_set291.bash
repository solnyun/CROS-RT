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
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_2 -p 358 -st topic291_0_1 -pt None -u 0.006257110923001519 > ./result_8chains/node291_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_2 -p 383 -st topic291_1_1 -pt None -u 0.016388000633242306 > ./result_8chains/node291_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_2 -p 408 -st topic291_2_1 -pt None -u 0.023781698903504123 > ./result_8chains/node291_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_2 -p 432 -st topic291_3_1 -pt None -u 0.02594118015383079 > ./result_8chains/node291_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_2 -p 645 -st topic291_4_1 -pt None -u 0.05748688390872872 > ./result_8chains/node291_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_2 -p 788 -st topic291_5_1 -pt None -u 0.01971738787937194 > ./result_8chains/node291_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_6_2 -p 845 -st topic291_6_1 -pt None -u 0.04589119930997197 > ./result_8chains/node291_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_7_2 -p 927 -st topic291_7_1 -pt None -u 0.03574807823834314 > ./result_8chains/node291_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_0_0 -p 358 -st none -pt topic291_0_0 -u 0.04702592250410775 > ./result_8chains/node291_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_1_0 -p 383 -st none -pt topic291_1_0 -u 0.0008004035923468433 > ./result_8chains/node291_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_2_0 -p 408 -st none -pt topic291_2_0 -u 0.004898894458855774 > ./result_8chains/node291_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_3_0 -p 432 -st none -pt topic291_3_0 -u 0.01678191023936848 > ./result_8chains/node291_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_4_0 -p 645 -st none -pt topic291_4_0 -u 0.0191826244786939 > ./result_8chains/node291_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_5_0 -p 788 -st none -pt topic291_5_0 -u 0.004062250513523463 > ./result_8chains/node291_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node291_6_0 -p 845 -st none -pt topic291_6_0 -u 0.024373877420722473 > ./result_8chains/node291_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node291_7_0 -p 927 -st none -pt topic291_7_0 -u 0.04923233735518158 > ./result_8chains/node291_7_0.txt &
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
    "./result_8chains/node291_0_0.txt 90"
    "./result_8chains/node291_0_2.txt 90"
    "./result_8chains/node291_1_0.txt 89"
    "./result_8chains/node291_1_2.txt 89"
    "./result_8chains/node291_2_0.txt 88"
    "./result_8chains/node291_2_2.txt 88"
    "./result_8chains/node291_3_0.txt 87"
    "./result_8chains/node291_3_2.txt 87"
    "./result_8chains/node291_4_0.txt 86"
    "./result_8chains/node291_4_2.txt 86"
    "./result_8chains/node291_5_0.txt 85"
    "./result_8chains/node291_5_2.txt 85"
    "./result_8chains/node291_6_0.txt 84"
    "./result_8chains/node291_6_2.txt 84"
    "./result_8chains/node291_7_0.txt 83"
    "./result_8chains/node291_7_2.txt 83"
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

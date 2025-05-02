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
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_2 -p 97 -st topic409_0_1 -pt None -u 0.015989260785072734 > ./result_8chains/node409_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_2 -p 355 -st topic409_1_1 -pt None -u 0.03999851199594845 > ./result_8chains/node409_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_2 -p 467 -st topic409_2_1 -pt None -u 0.02659984325364889 > ./result_8chains/node409_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_2 -p 521 -st topic409_3_1 -pt None -u 0.023917625960191397 > ./result_8chains/node409_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_2 -p 615 -st topic409_4_1 -pt None -u 0.021923513289568097 > ./result_8chains/node409_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_2 -p 630 -st topic409_5_1 -pt None -u 0.002123518996574425 > ./result_8chains/node409_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_6_2 -p 777 -st topic409_6_1 -pt None -u 0.009191508565760328 > ./result_8chains/node409_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_7_2 -p 813 -st topic409_7_1 -pt None -u 0.02742731029463 > ./result_8chains/node409_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_0 -p 97 -st none -pt topic409_0_0 -u 0.05290549077820855 > ./result_8chains/node409_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_0 -p 355 -st none -pt topic409_1_0 -u 0.013240778692248267 > ./result_8chains/node409_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_0 -p 467 -st none -pt topic409_2_0 -u 0.027879439476829526 > ./result_8chains/node409_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_0 -p 521 -st none -pt topic409_3_0 -u 0.04122689822258671 > ./result_8chains/node409_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_0 -p 615 -st none -pt topic409_4_0 -u 0.01798329754057676 > ./result_8chains/node409_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_0 -p 630 -st none -pt topic409_5_0 -u 0.001694972283468127 > ./result_8chains/node409_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_6_0 -p 777 -st none -pt topic409_6_0 -u 0.04092547349572344 > ./result_8chains/node409_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_7_0 -p 813 -st none -pt topic409_7_0 -u 0.029511862884052567 > ./result_8chains/node409_7_0.txt &
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
    "./result_8chains/node409_0_0.txt 90"
    "./result_8chains/node409_0_2.txt 90"
    "./result_8chains/node409_1_0.txt 89"
    "./result_8chains/node409_1_2.txt 89"
    "./result_8chains/node409_2_0.txt 88"
    "./result_8chains/node409_2_2.txt 88"
    "./result_8chains/node409_3_0.txt 87"
    "./result_8chains/node409_3_2.txt 87"
    "./result_8chains/node409_4_0.txt 86"
    "./result_8chains/node409_4_2.txt 86"
    "./result_8chains/node409_5_0.txt 85"
    "./result_8chains/node409_5_2.txt 85"
    "./result_8chains/node409_6_0.txt 84"
    "./result_8chains/node409_6_2.txt 84"
    "./result_8chains/node409_7_0.txt 83"
    "./result_8chains/node409_7_2.txt 83"
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

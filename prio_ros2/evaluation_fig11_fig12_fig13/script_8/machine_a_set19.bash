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
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_2 -p 45 -st topic19_0_1 -pt None -u 0.026119414939486774 > ./result_8chains/node19_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_2 -p 90 -st topic19_1_1 -pt None -u 0.020369297861415447 > ./result_8chains/node19_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_2 -p 322 -st topic19_2_1 -pt None -u 0.017660940152666837 > ./result_8chains/node19_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_2 -p 406 -st topic19_3_1 -pt None -u 0.00885223626915127 > ./result_8chains/node19_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_2 -p 862 -st topic19_4_1 -pt None -u 0.006419296917103606 > ./result_8chains/node19_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_2 -p 953 -st topic19_5_1 -pt None -u 0.07867262106360184 > ./result_8chains/node19_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_6_2 -p 959 -st topic19_6_1 -pt None -u 0.03270897714814705 > ./result_8chains/node19_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_7_2 -p 989 -st topic19_7_1 -pt None -u 3.2888997316210005e-05 > ./result_8chains/node19_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_0_0 -p 45 -st none -pt topic19_0_0 -u 0.0002555108333368028 > ./result_8chains/node19_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_1_0 -p 90 -st none -pt topic19_1_0 -u 0.011505592222081695 > ./result_8chains/node19_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_2_0 -p 322 -st none -pt topic19_2_0 -u 0.010279511814081599 > ./result_8chains/node19_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_3_0 -p 406 -st none -pt topic19_3_0 -u 0.025380103006375665 > ./result_8chains/node19_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_4_0 -p 862 -st none -pt topic19_4_0 -u 0.015488056102491654 > ./result_8chains/node19_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_5_0 -p 953 -st none -pt topic19_5_0 -u 0.02613091738384593 > ./result_8chains/node19_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node19_6_0 -p 959 -st none -pt topic19_6_0 -u 0.01432192995547557 > ./result_8chains/node19_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node19_7_0 -p 989 -st none -pt topic19_7_0 -u 0.0015168756749499822 > ./result_8chains/node19_7_0.txt &
sleep 10
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
    "./result_8chains/node19_0_0.txt 90"
    "./result_8chains/node19_0_2.txt 90"
    "./result_8chains/node19_1_0.txt 89"
    "./result_8chains/node19_1_2.txt 89"
    "./result_8chains/node19_2_0.txt 88"
    "./result_8chains/node19_2_2.txt 88"
    "./result_8chains/node19_3_0.txt 87"
    "./result_8chains/node19_3_2.txt 87"
    "./result_8chains/node19_4_0.txt 86"
    "./result_8chains/node19_4_2.txt 86"
    "./result_8chains/node19_5_0.txt 85"
    "./result_8chains/node19_5_2.txt 85"
    "./result_8chains/node19_6_0.txt 84"
    "./result_8chains/node19_6_2.txt 84"
    "./result_8chains/node19_7_0.txt 83"
    "./result_8chains/node19_7_2.txt 83"
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
sleep 50s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

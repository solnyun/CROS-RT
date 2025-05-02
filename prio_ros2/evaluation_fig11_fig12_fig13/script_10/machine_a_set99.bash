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
ros2 run evaluation_3_randomdag uunifast_node -n node99_0_2 -p 83 -st topic99_0_1 -pt None -u 0.03320065455654614 > ./result_10chains/node99_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_1_2 -p 353 -st topic99_1_1 -pt None -u 0.0005719244815013402 > ./result_10chains/node99_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_2_2 -p 499 -st topic99_2_1 -pt None -u 0.008308390198212612 > ./result_10chains/node99_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_3_2 -p 551 -st topic99_3_1 -pt None -u 0.00628841810561509 > ./result_10chains/node99_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_4_2 -p 570 -st topic99_4_1 -pt None -u 0.004442709663700917 > ./result_10chains/node99_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_5_2 -p 751 -st topic99_5_1 -pt None -u 0.05897664424075946 > ./result_10chains/node99_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_6_2 -p 779 -st topic99_6_1 -pt None -u 0.02102611705407864 > ./result_10chains/node99_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_7_2 -p 851 -st topic99_7_1 -pt None -u 0.02825190911124177 > ./result_10chains/node99_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_8_2 -p 953 -st topic99_8_1 -pt None -u 0.005782026615011579 > ./result_10chains/node99_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_9_2 -p 979 -st topic99_9_1 -pt None -u 0.018270156926302017 > ./result_10chains/node99_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_0_0 -p 83 -st none -pt topic99_0_0 -u 0.0008813849666988727 > ./result_10chains/node99_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_1_0 -p 353 -st none -pt topic99_1_0 -u 0.08556973287691344 > ./result_10chains/node99_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_2_0 -p 499 -st none -pt topic99_2_0 -u 0.01232163867041286 > ./result_10chains/node99_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_3_0 -p 551 -st none -pt topic99_3_0 -u 0.01195491825359446 > ./result_10chains/node99_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_4_0 -p 570 -st none -pt topic99_4_0 -u 0.011475287798886236 > ./result_10chains/node99_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_5_0 -p 751 -st none -pt topic99_5_0 -u 0.015072241876204706 > ./result_10chains/node99_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_6_0 -p 779 -st none -pt topic99_6_0 -u 0.02100504056297889 > ./result_10chains/node99_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_7_0 -p 851 -st none -pt topic99_7_0 -u 0.007392890807714797 > ./result_10chains/node99_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node99_8_0 -p 953 -st none -pt topic99_8_0 -u 0.005600625608992368 > ./result_10chains/node99_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node99_9_0 -p 979 -st none -pt topic99_9_0 -u 0.037346920268912544 > ./result_10chains/node99_9_0.txt &
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
    "./result_10chains/node99_0_0.txt 90"
    "./result_10chains/node99_0_2.txt 90"
    "./result_10chains/node99_1_0.txt 89"
    "./result_10chains/node99_1_2.txt 89"
    "./result_10chains/node99_2_0.txt 88"
    "./result_10chains/node99_2_2.txt 88"
    "./result_10chains/node99_3_0.txt 87"
    "./result_10chains/node99_3_2.txt 87"
    "./result_10chains/node99_4_0.txt 86"
    "./result_10chains/node99_4_2.txt 86"
    "./result_10chains/node99_5_0.txt 85"
    "./result_10chains/node99_5_2.txt 85"
    "./result_10chains/node99_6_0.txt 84"
    "./result_10chains/node99_6_2.txt 84"
    "./result_10chains/node99_7_0.txt 83"
    "./result_10chains/node99_7_2.txt 83"
    "./result_10chains/node99_8_0.txt 82"
    "./result_10chains/node99_8_2.txt 82"
    "./result_10chains/node99_9_0.txt 81"
    "./result_10chains/node99_9_2.txt 81"
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

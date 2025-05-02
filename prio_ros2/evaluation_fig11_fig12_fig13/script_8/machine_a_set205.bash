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
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_2 -p 125 -st topic205_0_1 -pt None -u 0.010396224063654147 > ./result_8chains/node205_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_2 -p 237 -st topic205_1_1 -pt None -u 0.0063008187381481395 > ./result_8chains/node205_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_2 -p 255 -st topic205_2_1 -pt None -u 0.03947572429303936 > ./result_8chains/node205_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_2 -p 375 -st topic205_3_1 -pt None -u 0.0007415689422578531 > ./result_8chains/node205_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_2 -p 539 -st topic205_4_1 -pt None -u 0.02237263784960003 > ./result_8chains/node205_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_2 -p 860 -st topic205_5_1 -pt None -u 0.0310027756973221 > ./result_8chains/node205_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_6_2 -p 882 -st topic205_6_1 -pt None -u 0.02477044689159321 > ./result_8chains/node205_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_7_2 -p 984 -st topic205_7_1 -pt None -u 0.0006136460622612707 > ./result_8chains/node205_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_0_0 -p 125 -st none -pt topic205_0_0 -u 0.06462334725051189 > ./result_8chains/node205_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_1_0 -p 237 -st none -pt topic205_1_0 -u 0.0041522362020192105 > ./result_8chains/node205_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_2_0 -p 255 -st none -pt topic205_2_0 -u 0.01634174698622287 > ./result_8chains/node205_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_3_0 -p 375 -st none -pt topic205_3_0 -u 0.012859249780812376 > ./result_8chains/node205_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_4_0 -p 539 -st none -pt topic205_4_0 -u 0.04509899763431777 > ./result_8chains/node205_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_5_0 -p 860 -st none -pt topic205_5_0 -u 0.0067054150869992335 > ./result_8chains/node205_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node205_6_0 -p 882 -st none -pt topic205_6_0 -u 0.03368360650474207 > ./result_8chains/node205_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node205_7_0 -p 984 -st none -pt topic205_7_0 -u 0.029557783210902387 > ./result_8chains/node205_7_0.txt &
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
    "./result_8chains/node205_0_0.txt 90"
    "./result_8chains/node205_0_2.txt 90"
    "./result_8chains/node205_1_0.txt 89"
    "./result_8chains/node205_1_2.txt 89"
    "./result_8chains/node205_2_0.txt 88"
    "./result_8chains/node205_2_2.txt 88"
    "./result_8chains/node205_3_0.txt 87"
    "./result_8chains/node205_3_2.txt 87"
    "./result_8chains/node205_4_0.txt 86"
    "./result_8chains/node205_4_2.txt 86"
    "./result_8chains/node205_5_0.txt 85"
    "./result_8chains/node205_5_2.txt 85"
    "./result_8chains/node205_6_0.txt 84"
    "./result_8chains/node205_6_2.txt 84"
    "./result_8chains/node205_7_0.txt 83"
    "./result_8chains/node205_7_2.txt 83"
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

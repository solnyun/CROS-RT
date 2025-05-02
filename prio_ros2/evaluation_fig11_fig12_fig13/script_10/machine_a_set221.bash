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
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_2 -p 154 -st topic221_0_1 -pt None -u 0.009957107952721589 > ./result_10chains/node221_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_2 -p 163 -st topic221_1_1 -pt None -u 0.05287462807701365 > ./result_10chains/node221_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_2 -p 222 -st topic221_2_1 -pt None -u 0.005330182080907964 > ./result_10chains/node221_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_2 -p 272 -st topic221_3_1 -pt None -u 0.004286570091960318 > ./result_10chains/node221_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_2 -p 298 -st topic221_4_1 -pt None -u 0.003847306226404862 > ./result_10chains/node221_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_2 -p 375 -st topic221_5_1 -pt None -u 0.024996638628185686 > ./result_10chains/node221_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_6_2 -p 384 -st topic221_6_1 -pt None -u 0.001893375905595962 > ./result_10chains/node221_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_7_2 -p 601 -st topic221_7_1 -pt None -u 0.014834398687426545 > ./result_10chains/node221_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_8_2 -p 749 -st topic221_8_1 -pt None -u 0.01580278631445052 > ./result_10chains/node221_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_9_2 -p 907 -st topic221_9_1 -pt None -u 0.04312595131545862 > ./result_10chains/node221_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_0_0 -p 154 -st none -pt topic221_0_0 -u 0.023936956195684644 > ./result_10chains/node221_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_1_0 -p 163 -st none -pt topic221_1_0 -u 0.01782305930077449 > ./result_10chains/node221_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_2_0 -p 222 -st none -pt topic221_2_0 -u 0.01818274023707528 > ./result_10chains/node221_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_3_0 -p 272 -st none -pt topic221_3_0 -u 0.006734234763024427 > ./result_10chains/node221_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_4_0 -p 298 -st none -pt topic221_4_0 -u 0.031079509047892473 > ./result_10chains/node221_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_5_0 -p 375 -st none -pt topic221_5_0 -u 0.006135155789592173 > ./result_10chains/node221_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_6_0 -p 384 -st none -pt topic221_6_0 -u 0.018911775962823174 > ./result_10chains/node221_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_7_0 -p 601 -st none -pt topic221_7_0 -u 0.015620810709975619 > ./result_10chains/node221_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node221_8_0 -p 749 -st none -pt topic221_8_0 -u 0.015912920287576057 > ./result_10chains/node221_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node221_9_0 -p 907 -st none -pt topic221_9_0 -u 0.008340730574732412 > ./result_10chains/node221_9_0.txt &
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
    "./result_10chains/node221_0_0.txt 90"
    "./result_10chains/node221_0_2.txt 90"
    "./result_10chains/node221_1_0.txt 89"
    "./result_10chains/node221_1_2.txt 89"
    "./result_10chains/node221_2_0.txt 88"
    "./result_10chains/node221_2_2.txt 88"
    "./result_10chains/node221_3_0.txt 87"
    "./result_10chains/node221_3_2.txt 87"
    "./result_10chains/node221_4_0.txt 86"
    "./result_10chains/node221_4_2.txt 86"
    "./result_10chains/node221_5_0.txt 85"
    "./result_10chains/node221_5_2.txt 85"
    "./result_10chains/node221_6_0.txt 84"
    "./result_10chains/node221_6_2.txt 84"
    "./result_10chains/node221_7_0.txt 83"
    "./result_10chains/node221_7_2.txt 83"
    "./result_10chains/node221_8_0.txt 82"
    "./result_10chains/node221_8_2.txt 82"
    "./result_10chains/node221_9_0.txt 81"
    "./result_10chains/node221_9_2.txt 81"
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

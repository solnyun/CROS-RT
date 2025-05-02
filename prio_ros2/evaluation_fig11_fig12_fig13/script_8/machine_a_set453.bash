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
ros2 run evaluation_3_randomdag uunifast_node -n node453_0_2 -p 151 -st topic453_0_1 -pt None -u 0.0018000169800568289 > ./result_8chains/node453_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_1_2 -p 259 -st topic453_1_1 -pt None -u 0.0366326916882278 > ./result_8chains/node453_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_2_2 -p 439 -st topic453_2_1 -pt None -u 0.023340526507216797 > ./result_8chains/node453_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_3_2 -p 702 -st topic453_3_1 -pt None -u 0.040672496519650825 > ./result_8chains/node453_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_4_2 -p 819 -st topic453_4_1 -pt None -u 0.04706303805108897 > ./result_8chains/node453_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_5_2 -p 836 -st topic453_5_1 -pt None -u 0.00549223030053099 > ./result_8chains/node453_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_6_2 -p 950 -st topic453_6_1 -pt None -u 0.0004947224712988155 > ./result_8chains/node453_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_7_2 -p 990 -st topic453_7_1 -pt None -u 0.010354567152322367 > ./result_8chains/node453_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_0_0 -p 151 -st none -pt topic453_0_0 -u 0.022973498113760038 > ./result_8chains/node453_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_1_0 -p 259 -st none -pt topic453_1_0 -u 0.008362823426269705 > ./result_8chains/node453_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_2_0 -p 439 -st none -pt topic453_2_0 -u 0.007854491343078751 > ./result_8chains/node453_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_3_0 -p 702 -st none -pt topic453_3_0 -u 0.010760946002050631 > ./result_8chains/node453_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_4_0 -p 819 -st none -pt topic453_4_0 -u 0.07543190031056557 > ./result_8chains/node453_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_5_0 -p 836 -st none -pt topic453_5_0 -u 0.056983737172925236 > ./result_8chains/node453_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_6_0 -p 950 -st none -pt topic453_6_0 -u 0.0054075902758290995 > ./result_8chains/node453_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_7_0 -p 990 -st none -pt topic453_7_0 -u 0.0223982521135225 > ./result_8chains/node453_7_0.txt &
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
    "./result_8chains/node453_0_0.txt 90"
    "./result_8chains/node453_0_2.txt 90"
    "./result_8chains/node453_1_0.txt 89"
    "./result_8chains/node453_1_2.txt 89"
    "./result_8chains/node453_2_0.txt 88"
    "./result_8chains/node453_2_2.txt 88"
    "./result_8chains/node453_3_0.txt 87"
    "./result_8chains/node453_3_2.txt 87"
    "./result_8chains/node453_4_0.txt 86"
    "./result_8chains/node453_4_2.txt 86"
    "./result_8chains/node453_5_0.txt 85"
    "./result_8chains/node453_5_2.txt 85"
    "./result_8chains/node453_6_0.txt 84"
    "./result_8chains/node453_6_2.txt 84"
    "./result_8chains/node453_7_0.txt 83"
    "./result_8chains/node453_7_2.txt 83"
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

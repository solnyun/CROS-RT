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
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_2 -p 167 -st topic236_0_1 -pt None -u 0.02376063328697542 > ./result_10chains/node236_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_2 -p 342 -st topic236_1_1 -pt None -u 0.0012785919910637822 > ./result_10chains/node236_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_2 -p 401 -st topic236_2_1 -pt None -u 0.0489096573386002 > ./result_10chains/node236_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_2 -p 486 -st topic236_3_1 -pt None -u 0.007062104975603778 > ./result_10chains/node236_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_4_2 -p 496 -st topic236_4_1 -pt None -u 0.008542658568159 > ./result_10chains/node236_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_5_2 -p 521 -st topic236_5_1 -pt None -u 0.013949858592581271 > ./result_10chains/node236_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_6_2 -p 597 -st topic236_6_1 -pt None -u 0.0010448246447733456 > ./result_10chains/node236_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_7_2 -p 807 -st topic236_7_1 -pt None -u 0.003403061748952385 > ./result_10chains/node236_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_8_2 -p 898 -st topic236_8_1 -pt None -u 0.001767605385206858 > ./result_10chains/node236_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_9_2 -p 993 -st topic236_9_1 -pt None -u 0.05498419026680073 > ./result_10chains/node236_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_0_0 -p 167 -st none -pt topic236_0_0 -u 0.03245871123665489 > ./result_10chains/node236_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_1_0 -p 342 -st none -pt topic236_1_0 -u 0.007603656866169428 > ./result_10chains/node236_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_2_0 -p 401 -st none -pt topic236_2_0 -u 0.009219790804911643 > ./result_10chains/node236_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_3_0 -p 486 -st none -pt topic236_3_0 -u 0.011685283253380196 > ./result_10chains/node236_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_4_0 -p 496 -st none -pt topic236_4_0 -u 0.00043923495625780573 > ./result_10chains/node236_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_5_0 -p 521 -st none -pt topic236_5_0 -u 0.03835600672578704 > ./result_10chains/node236_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_6_0 -p 597 -st none -pt topic236_6_0 -u 0.008824372598930402 > ./result_10chains/node236_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_7_0 -p 807 -st none -pt topic236_7_0 -u 0.0438706420024422 > ./result_10chains/node236_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node236_8_0 -p 898 -st none -pt topic236_8_0 -u 0.007479544823164513 > ./result_10chains/node236_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node236_9_0 -p 993 -st none -pt topic236_9_0 -u 0.03476849096278327 > ./result_10chains/node236_9_0.txt &
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
    "./result_10chains/node236_0_0.txt 90"
    "./result_10chains/node236_0_2.txt 90"
    "./result_10chains/node236_1_0.txt 89"
    "./result_10chains/node236_1_2.txt 89"
    "./result_10chains/node236_2_0.txt 88"
    "./result_10chains/node236_2_2.txt 88"
    "./result_10chains/node236_3_0.txt 87"
    "./result_10chains/node236_3_2.txt 87"
    "./result_10chains/node236_4_0.txt 86"
    "./result_10chains/node236_4_2.txt 86"
    "./result_10chains/node236_5_0.txt 85"
    "./result_10chains/node236_5_2.txt 85"
    "./result_10chains/node236_6_0.txt 84"
    "./result_10chains/node236_6_2.txt 84"
    "./result_10chains/node236_7_0.txt 83"
    "./result_10chains/node236_7_2.txt 83"
    "./result_10chains/node236_8_0.txt 82"
    "./result_10chains/node236_8_2.txt 82"
    "./result_10chains/node236_9_0.txt 81"
    "./result_10chains/node236_9_2.txt 81"
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

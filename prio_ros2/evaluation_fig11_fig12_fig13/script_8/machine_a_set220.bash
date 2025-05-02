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
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_2 -p 276 -st topic220_0_1 -pt None -u 0.018700221357349223 > ./result_8chains/node220_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_2 -p 281 -st topic220_1_1 -pt None -u 0.0018837726703113122 > ./result_8chains/node220_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_2 -p 307 -st topic220_2_1 -pt None -u 0.004124078014638266 > ./result_8chains/node220_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_2 -p 513 -st topic220_3_1 -pt None -u 0.04479264585255874 > ./result_8chains/node220_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_2 -p 559 -st topic220_4_1 -pt None -u 0.012158158479699643 > ./result_8chains/node220_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_2 -p 648 -st topic220_5_1 -pt None -u 0.0018183618135348967 > ./result_8chains/node220_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_6_2 -p 809 -st topic220_6_1 -pt None -u 0.0010588323076289735 > ./result_8chains/node220_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_7_2 -p 854 -st topic220_7_1 -pt None -u 0.0015186163752317738 > ./result_8chains/node220_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_0_0 -p 276 -st none -pt topic220_0_0 -u 0.01723440509177865 > ./result_8chains/node220_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_1_0 -p 281 -st none -pt topic220_1_0 -u 0.03313703768901766 > ./result_8chains/node220_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_2_0 -p 307 -st none -pt topic220_2_0 -u 0.02387460089030391 > ./result_8chains/node220_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_3_0 -p 513 -st none -pt topic220_3_0 -u 0.10595169310770816 > ./result_8chains/node220_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_4_0 -p 559 -st none -pt topic220_4_0 -u 0.04042198415357234 > ./result_8chains/node220_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_5_0 -p 648 -st none -pt topic220_5_0 -u 0.008408167932740435 > ./result_8chains/node220_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node220_6_0 -p 809 -st none -pt topic220_6_0 -u 0.03248100224828469 > ./result_8chains/node220_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node220_7_0 -p 854 -st none -pt topic220_7_0 -u 0.013649231362224127 > ./result_8chains/node220_7_0.txt &
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
    "./result_8chains/node220_0_0.txt 90"
    "./result_8chains/node220_0_2.txt 90"
    "./result_8chains/node220_1_0.txt 89"
    "./result_8chains/node220_1_2.txt 89"
    "./result_8chains/node220_2_0.txt 88"
    "./result_8chains/node220_2_2.txt 88"
    "./result_8chains/node220_3_0.txt 87"
    "./result_8chains/node220_3_2.txt 87"
    "./result_8chains/node220_4_0.txt 86"
    "./result_8chains/node220_4_2.txt 86"
    "./result_8chains/node220_5_0.txt 85"
    "./result_8chains/node220_5_2.txt 85"
    "./result_8chains/node220_6_0.txt 84"
    "./result_8chains/node220_6_2.txt 84"
    "./result_8chains/node220_7_0.txt 83"
    "./result_8chains/node220_7_2.txt 83"
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

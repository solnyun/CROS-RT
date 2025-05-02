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
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_2 -p 32 -st topic379_0_1 -pt None -u 0.022569442091551928 > ./result_8chains/node379_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_2 -p 52 -st topic379_1_1 -pt None -u 0.020506253130364527 > ./result_8chains/node379_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_2 -p 68 -st topic379_2_1 -pt None -u 0.004285673524349165 > ./result_8chains/node379_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_2 -p 487 -st topic379_3_1 -pt None -u 0.02569048235071167 > ./result_8chains/node379_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_2 -p 681 -st topic379_4_1 -pt None -u 0.008250219869867431 > ./result_8chains/node379_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_2 -p 828 -st topic379_5_1 -pt None -u 0.005344619917812599 > ./result_8chains/node379_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_6_2 -p 942 -st topic379_6_1 -pt None -u 0.014188110396880185 > ./result_8chains/node379_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_7_2 -p 954 -st topic379_7_1 -pt None -u 0.031190563985158116 > ./result_8chains/node379_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_0 -p 32 -st none -pt topic379_0_0 -u 0.06592693735021438 > ./result_8chains/node379_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_0 -p 52 -st none -pt topic379_1_0 -u 0.0008216115933560308 > ./result_8chains/node379_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_0 -p 68 -st none -pt topic379_2_0 -u 0.005870613479708575 > ./result_8chains/node379_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_0 -p 487 -st none -pt topic379_3_0 -u 0.002145048055936405 > ./result_8chains/node379_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_0 -p 681 -st none -pt topic379_4_0 -u 0.00555045757675493 > ./result_8chains/node379_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_0 -p 828 -st none -pt topic379_5_0 -u 0.016919184770165574 > ./result_8chains/node379_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_6_0 -p 942 -st none -pt topic379_6_0 -u 0.025117623228221003 > ./result_8chains/node379_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_7_0 -p 954 -st none -pt topic379_7_0 -u 0.0016561373272980032 > ./result_8chains/node379_7_0.txt &
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
    "./result_8chains/node379_0_0.txt 90"
    "./result_8chains/node379_0_2.txt 90"
    "./result_8chains/node379_1_0.txt 89"
    "./result_8chains/node379_1_2.txt 89"
    "./result_8chains/node379_2_0.txt 88"
    "./result_8chains/node379_2_2.txt 88"
    "./result_8chains/node379_3_0.txt 87"
    "./result_8chains/node379_3_2.txt 87"
    "./result_8chains/node379_4_0.txt 86"
    "./result_8chains/node379_4_2.txt 86"
    "./result_8chains/node379_5_0.txt 85"
    "./result_8chains/node379_5_2.txt 85"
    "./result_8chains/node379_6_0.txt 84"
    "./result_8chains/node379_6_2.txt 84"
    "./result_8chains/node379_7_0.txt 83"
    "./result_8chains/node379_7_2.txt 83"
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

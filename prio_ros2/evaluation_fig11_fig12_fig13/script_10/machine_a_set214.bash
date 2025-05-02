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
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_2 -p 101 -st topic214_0_1 -pt None -u 0.0047376432488207 > ./result_10chains/node214_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_2 -p 119 -st topic214_1_1 -pt None -u 0.002869457340184789 > ./result_10chains/node214_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_2 -p 150 -st topic214_2_1 -pt None -u 0.010523784608697684 > ./result_10chains/node214_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_2 -p 229 -st topic214_3_1 -pt None -u 0.04110099240084658 > ./result_10chains/node214_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_2 -p 298 -st topic214_4_1 -pt None -u 0.019697997379032495 > ./result_10chains/node214_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_2 -p 307 -st topic214_5_1 -pt None -u 0.013807695256469688 > ./result_10chains/node214_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_6_2 -p 344 -st topic214_6_1 -pt None -u 0.005493951660057977 > ./result_10chains/node214_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_7_2 -p 450 -st topic214_7_1 -pt None -u 0.04887535665825317 > ./result_10chains/node214_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_8_2 -p 886 -st topic214_8_1 -pt None -u 0.020127448473077826 > ./result_10chains/node214_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_9_2 -p 962 -st topic214_9_1 -pt None -u 0.006446285360324193 > ./result_10chains/node214_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_0_0 -p 101 -st none -pt topic214_0_0 -u 0.003871138949879116 > ./result_10chains/node214_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_1_0 -p 119 -st none -pt topic214_1_0 -u 0.015076706406614737 > ./result_10chains/node214_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_2_0 -p 150 -st none -pt topic214_2_0 -u 0.0014592117096587365 > ./result_10chains/node214_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_3_0 -p 229 -st none -pt topic214_3_0 -u 0.060680303985326256 > ./result_10chains/node214_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_4_0 -p 298 -st none -pt topic214_4_0 -u 0.011664789693125455 > ./result_10chains/node214_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_5_0 -p 307 -st none -pt topic214_5_0 -u 0.013133056735709692 > ./result_10chains/node214_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_6_0 -p 344 -st none -pt topic214_6_0 -u 0.02793542384281611 > ./result_10chains/node214_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_7_0 -p 450 -st none -pt topic214_7_0 -u 0.0044304797113653704 > ./result_10chains/node214_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node214_8_0 -p 886 -st none -pt topic214_8_0 -u 0.0015592593157363749 > ./result_10chains/node214_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node214_9_0 -p 962 -st none -pt topic214_9_0 -u 0.018366036925738915 > ./result_10chains/node214_9_0.txt &
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
    "./result_10chains/node214_0_0.txt 90"
    "./result_10chains/node214_0_2.txt 90"
    "./result_10chains/node214_1_0.txt 89"
    "./result_10chains/node214_1_2.txt 89"
    "./result_10chains/node214_2_0.txt 88"
    "./result_10chains/node214_2_2.txt 88"
    "./result_10chains/node214_3_0.txt 87"
    "./result_10chains/node214_3_2.txt 87"
    "./result_10chains/node214_4_0.txt 86"
    "./result_10chains/node214_4_2.txt 86"
    "./result_10chains/node214_5_0.txt 85"
    "./result_10chains/node214_5_2.txt 85"
    "./result_10chains/node214_6_0.txt 84"
    "./result_10chains/node214_6_2.txt 84"
    "./result_10chains/node214_7_0.txt 83"
    "./result_10chains/node214_7_2.txt 83"
    "./result_10chains/node214_8_0.txt 82"
    "./result_10chains/node214_8_2.txt 82"
    "./result_10chains/node214_9_0.txt 81"
    "./result_10chains/node214_9_2.txt 81"
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

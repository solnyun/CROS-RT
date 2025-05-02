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
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_2 -p 58 -st topic362_0_1 -pt None -u 0.0025427762697723955 > ./result_10chains/node362_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_2 -p 80 -st topic362_1_1 -pt None -u 0.04161210283620553 > ./result_10chains/node362_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_2 -p 164 -st topic362_2_1 -pt None -u 0.03259590631851966 > ./result_10chains/node362_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_2 -p 226 -st topic362_3_1 -pt None -u 0.06356631943255509 > ./result_10chains/node362_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_2 -p 356 -st topic362_4_1 -pt None -u 0.07040572790735275 > ./result_10chains/node362_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_2 -p 483 -st topic362_5_1 -pt None -u 0.003735280522750156 > ./result_10chains/node362_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_6_2 -p 713 -st topic362_6_1 -pt None -u 0.0025235097354957686 > ./result_10chains/node362_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_7_2 -p 757 -st topic362_7_1 -pt None -u 0.0019550228618835513 > ./result_10chains/node362_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_8_2 -p 758 -st topic362_8_1 -pt None -u 0.0035677967442188235 > ./result_10chains/node362_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_9_2 -p 861 -st topic362_9_1 -pt None -u 0.004141176864660579 > ./result_10chains/node362_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_0_0 -p 58 -st none -pt topic362_0_0 -u 0.04712140066998921 > ./result_10chains/node362_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_1_0 -p 80 -st none -pt topic362_1_0 -u 0.01776803772963259 > ./result_10chains/node362_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_2_0 -p 164 -st none -pt topic362_2_0 -u 0.003541774099107886 > ./result_10chains/node362_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_3_0 -p 226 -st none -pt topic362_3_0 -u 0.013766492971386435 > ./result_10chains/node362_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_4_0 -p 356 -st none -pt topic362_4_0 -u 0.005879976136024201 > ./result_10chains/node362_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_5_0 -p 483 -st none -pt topic362_5_0 -u 0.0006104273859096898 > ./result_10chains/node362_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_6_0 -p 713 -st none -pt topic362_6_0 -u 0.003911144891511925 > ./result_10chains/node362_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_7_0 -p 757 -st none -pt topic362_7_0 -u 0.04581525492930495 > ./result_10chains/node362_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node362_8_0 -p 758 -st none -pt topic362_8_0 -u 0.015779142243665376 > ./result_10chains/node362_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node362_9_0 -p 861 -st none -pt topic362_9_0 -u 0.008244013635966415 > ./result_10chains/node362_9_0.txt &
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
    "./result_10chains/node362_0_0.txt 90"
    "./result_10chains/node362_0_2.txt 90"
    "./result_10chains/node362_1_0.txt 89"
    "./result_10chains/node362_1_2.txt 89"
    "./result_10chains/node362_2_0.txt 88"
    "./result_10chains/node362_2_2.txt 88"
    "./result_10chains/node362_3_0.txt 87"
    "./result_10chains/node362_3_2.txt 87"
    "./result_10chains/node362_4_0.txt 86"
    "./result_10chains/node362_4_2.txt 86"
    "./result_10chains/node362_5_0.txt 85"
    "./result_10chains/node362_5_2.txt 85"
    "./result_10chains/node362_6_0.txt 84"
    "./result_10chains/node362_6_2.txt 84"
    "./result_10chains/node362_7_0.txt 83"
    "./result_10chains/node362_7_2.txt 83"
    "./result_10chains/node362_8_0.txt 82"
    "./result_10chains/node362_8_2.txt 82"
    "./result_10chains/node362_9_0.txt 81"
    "./result_10chains/node362_9_2.txt 81"
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

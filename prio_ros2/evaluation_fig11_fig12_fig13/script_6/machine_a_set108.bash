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
ros2 run evaluation_3_randomdag uunifast_node -n node108_0_2 -p 189 -st topic108_0_1 -pt None -u 0.06417006273782228 > ./result_6chains/node108_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_1_2 -p 357 -st topic108_1_1 -pt None -u 0.03555238420361223 > ./result_6chains/node108_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_2_2 -p 387 -st topic108_2_1 -pt None -u 0.004033850599069022 > ./result_6chains/node108_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_3_2 -p 502 -st topic108_3_1 -pt None -u 0.011200888248628277 > ./result_6chains/node108_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_4_2 -p 730 -st topic108_4_1 -pt None -u 0.009560806459782023 > ./result_6chains/node108_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_5_2 -p 959 -st topic108_5_1 -pt None -u 0.053510391457769355 > ./result_6chains/node108_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_0_0 -p 189 -st none -pt topic108_0_0 -u 0.07511048291069272 > ./result_6chains/node108_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_1_0 -p 357 -st none -pt topic108_1_0 -u 0.007793771924584747 > ./result_6chains/node108_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_2_0 -p 387 -st none -pt topic108_2_0 -u 0.018967294181903183 > ./result_6chains/node108_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_3_0 -p 502 -st none -pt topic108_3_0 -u 0.07855361822953025 > ./result_6chains/node108_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_4_0 -p 730 -st none -pt topic108_4_0 -u 0.022609511507917193 > ./result_6chains/node108_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_5_0 -p 959 -st none -pt topic108_5_0 -u 0.017881741871077106 > ./result_6chains/node108_5_0.txt &
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
    "./result_6chains/node108_0_0.txt 90"
    "./result_6chains/node108_0_2.txt 90"
    "./result_6chains/node108_1_0.txt 89"
    "./result_6chains/node108_1_2.txt 89"
    "./result_6chains/node108_2_0.txt 88"
    "./result_6chains/node108_2_2.txt 88"
    "./result_6chains/node108_3_0.txt 87"
    "./result_6chains/node108_3_2.txt 87"
    "./result_6chains/node108_4_0.txt 86"
    "./result_6chains/node108_4_2.txt 86"
    "./result_6chains/node108_5_0.txt 85"
    "./result_6chains/node108_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

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
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_2 -p 197 -st topic478_0_1 -pt None -u 0.05231652605524001 > ./result_6chains/node478_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_2 -p 264 -st topic478_1_1 -pt None -u 0.011708986487730777 > ./result_6chains/node478_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_2 -p 720 -st topic478_2_1 -pt None -u 0.004077704826003586 > ./result_6chains/node478_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_2 -p 880 -st topic478_3_1 -pt None -u 0.002403137372442604 > ./result_6chains/node478_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_2 -p 925 -st topic478_4_1 -pt None -u 0.009723941828997072 > ./result_6chains/node478_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_2 -p 956 -st topic478_5_1 -pt None -u 0.019156143789144923 > ./result_6chains/node478_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_0_0 -p 197 -st none -pt topic478_0_0 -u 0.03253411622110569 > ./result_6chains/node478_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_1_0 -p 264 -st none -pt topic478_1_0 -u 0.15624001483053945 > ./result_6chains/node478_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_2_0 -p 720 -st none -pt topic478_2_0 -u 0.012880237571146619 > ./result_6chains/node478_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_3_0 -p 880 -st none -pt topic478_3_0 -u 0.015456255569266414 > ./result_6chains/node478_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node478_4_0 -p 925 -st none -pt topic478_4_0 -u 0.024896275632833892 > ./result_6chains/node478_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node478_5_0 -p 956 -st none -pt topic478_5_0 -u 0.012026929922722564 > ./result_6chains/node478_5_0.txt &
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
    "./result_6chains/node478_0_0.txt 90"
    "./result_6chains/node478_0_2.txt 90"
    "./result_6chains/node478_1_0.txt 89"
    "./result_6chains/node478_1_2.txt 89"
    "./result_6chains/node478_2_0.txt 88"
    "./result_6chains/node478_2_2.txt 88"
    "./result_6chains/node478_3_0.txt 87"
    "./result_6chains/node478_3_2.txt 87"
    "./result_6chains/node478_4_0.txt 86"
    "./result_6chains/node478_4_2.txt 86"
    "./result_6chains/node478_5_0.txt 85"
    "./result_6chains/node478_5_2.txt 85"
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

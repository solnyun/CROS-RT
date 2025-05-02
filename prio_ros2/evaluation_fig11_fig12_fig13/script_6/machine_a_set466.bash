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
ros2 run evaluation_3_randomdag uunifast_node -n node466_0_2 -p 16 -st topic466_0_1 -pt None -u 0.03803548123329492 > ./result_6chains/node466_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_1_2 -p 381 -st topic466_1_1 -pt None -u 0.0135392137219571 > ./result_6chains/node466_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_2_2 -p 392 -st topic466_2_1 -pt None -u 0.02904925413759374 > ./result_6chains/node466_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_3_2 -p 659 -st topic466_3_1 -pt None -u 0.010292434880406626 > ./result_6chains/node466_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_4_2 -p 859 -st topic466_4_1 -pt None -u 0.08861281564991831 > ./result_6chains/node466_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_5_2 -p 911 -st topic466_5_1 -pt None -u 0.010602025166666574 > ./result_6chains/node466_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_0_0 -p 16 -st none -pt topic466_0_0 -u 0.02984668414746533 > ./result_6chains/node466_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_1_0 -p 381 -st none -pt topic466_1_0 -u 0.09059188279180147 > ./result_6chains/node466_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_2_0 -p 392 -st none -pt topic466_2_0 -u 0.016101903861863887 > ./result_6chains/node466_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_3_0 -p 659 -st none -pt topic466_3_0 -u 0.027118833208455706 > ./result_6chains/node466_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_4_0 -p 859 -st none -pt topic466_4_0 -u 0.004185541574917295 > ./result_6chains/node466_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_5_0 -p 911 -st none -pt topic466_5_0 -u 0.012324581761904173 > ./result_6chains/node466_5_0.txt &
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
    "./result_6chains/node466_0_0.txt 90"
    "./result_6chains/node466_0_2.txt 90"
    "./result_6chains/node466_1_0.txt 89"
    "./result_6chains/node466_1_2.txt 89"
    "./result_6chains/node466_2_0.txt 88"
    "./result_6chains/node466_2_2.txt 88"
    "./result_6chains/node466_3_0.txt 87"
    "./result_6chains/node466_3_2.txt 87"
    "./result_6chains/node466_4_0.txt 86"
    "./result_6chains/node466_4_2.txt 86"
    "./result_6chains/node466_5_0.txt 85"
    "./result_6chains/node466_5_2.txt 85"
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

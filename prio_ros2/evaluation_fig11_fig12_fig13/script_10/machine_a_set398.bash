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
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_2 -p 14 -st topic398_0_1 -pt None -u 0.01611057693355572 > ./result_10chains/node398_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_2 -p 36 -st topic398_1_1 -pt None -u 0.0016626877142985053 > ./result_10chains/node398_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_2 -p 83 -st topic398_2_1 -pt None -u 0.03990518373789026 > ./result_10chains/node398_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_2 -p 101 -st topic398_3_1 -pt None -u 0.011873867028366847 > ./result_10chains/node398_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_4_2 -p 193 -st topic398_4_1 -pt None -u 0.03159281836865124 > ./result_10chains/node398_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_5_2 -p 206 -st topic398_5_1 -pt None -u 0.011372057945959885 > ./result_10chains/node398_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_6_2 -p 369 -st topic398_6_1 -pt None -u 0.022313752872399395 > ./result_10chains/node398_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_7_2 -p 673 -st topic398_7_1 -pt None -u 0.0077079546694285295 > ./result_10chains/node398_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_8_2 -p 900 -st topic398_8_1 -pt None -u 0.0024159497448366443 > ./result_10chains/node398_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_9_2 -p 983 -st topic398_9_1 -pt None -u 0.01298007144028426 > ./result_10chains/node398_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_0_0 -p 14 -st none -pt topic398_0_0 -u 0.0070784830931253095 > ./result_10chains/node398_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_1_0 -p 36 -st none -pt topic398_1_0 -u 0.013030744860980936 > ./result_10chains/node398_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_2_0 -p 83 -st none -pt topic398_2_0 -u 0.0008117306676556635 > ./result_10chains/node398_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_3_0 -p 101 -st none -pt topic398_3_0 -u 0.01882458735875009 > ./result_10chains/node398_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_4_0 -p 193 -st none -pt topic398_4_0 -u 0.044525462322017206 > ./result_10chains/node398_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_5_0 -p 206 -st none -pt topic398_5_0 -u 0.007463352906746712 > ./result_10chains/node398_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_6_0 -p 369 -st none -pt topic398_6_0 -u 0.00881366248189519 > ./result_10chains/node398_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_7_0 -p 673 -st none -pt topic398_7_0 -u 0.0029176737886661974 > ./result_10chains/node398_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node398_8_0 -p 900 -st none -pt topic398_8_0 -u 0.018045970938048425 > ./result_10chains/node398_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node398_9_0 -p 983 -st none -pt topic398_9_0 -u 0.0005333736656585875 > ./result_10chains/node398_9_0.txt &
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
    "./result_10chains/node398_0_0.txt 90"
    "./result_10chains/node398_0_2.txt 90"
    "./result_10chains/node398_1_0.txt 89"
    "./result_10chains/node398_1_2.txt 89"
    "./result_10chains/node398_2_0.txt 88"
    "./result_10chains/node398_2_2.txt 88"
    "./result_10chains/node398_3_0.txt 87"
    "./result_10chains/node398_3_2.txt 87"
    "./result_10chains/node398_4_0.txt 86"
    "./result_10chains/node398_4_2.txt 86"
    "./result_10chains/node398_5_0.txt 85"
    "./result_10chains/node398_5_2.txt 85"
    "./result_10chains/node398_6_0.txt 84"
    "./result_10chains/node398_6_2.txt 84"
    "./result_10chains/node398_7_0.txt 83"
    "./result_10chains/node398_7_2.txt 83"
    "./result_10chains/node398_8_0.txt 82"
    "./result_10chains/node398_8_2.txt 82"
    "./result_10chains/node398_9_0.txt 81"
    "./result_10chains/node398_9_2.txt 81"
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

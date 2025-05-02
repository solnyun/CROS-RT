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
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_2 -p 29 -st topic470_0_1 -pt None -u 0.07329352625889268 > ./result_6chains/node470_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_2 -p 241 -st topic470_1_1 -pt None -u 0.0012950999870491864 > ./result_6chains/node470_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_2 -p 286 -st topic470_2_1 -pt None -u 0.0214462900926361 > ./result_6chains/node470_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_2 -p 320 -st topic470_3_1 -pt None -u 0.016841403622404938 > ./result_6chains/node470_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_2 -p 679 -st topic470_4_1 -pt None -u 0.025636738196938277 > ./result_6chains/node470_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_2 -p 994 -st topic470_5_1 -pt None -u 0.0011559656160506767 > ./result_6chains/node470_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_0_0 -p 29 -st none -pt topic470_0_0 -u 0.08717632659445601 > ./result_6chains/node470_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_1_0 -p 241 -st none -pt topic470_1_0 -u 0.015513047181023032 > ./result_6chains/node470_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_2_0 -p 286 -st none -pt topic470_2_0 -u 0.03657136457566873 > ./result_6chains/node470_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_3_0 -p 320 -st none -pt topic470_3_0 -u 0.024604970306594337 > ./result_6chains/node470_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node470_4_0 -p 679 -st none -pt topic470_4_0 -u 0.028975557926160342 > ./result_6chains/node470_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node470_5_0 -p 994 -st none -pt topic470_5_0 -u 0.014355370768542867 > ./result_6chains/node470_5_0.txt &
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
    "./result_6chains/node470_0_0.txt 90"
    "./result_6chains/node470_0_2.txt 90"
    "./result_6chains/node470_1_0.txt 89"
    "./result_6chains/node470_1_2.txt 89"
    "./result_6chains/node470_2_0.txt 88"
    "./result_6chains/node470_2_2.txt 88"
    "./result_6chains/node470_3_0.txt 87"
    "./result_6chains/node470_3_2.txt 87"
    "./result_6chains/node470_4_0.txt 86"
    "./result_6chains/node470_4_2.txt 86"
    "./result_6chains/node470_5_0.txt 85"
    "./result_6chains/node470_5_2.txt 85"
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

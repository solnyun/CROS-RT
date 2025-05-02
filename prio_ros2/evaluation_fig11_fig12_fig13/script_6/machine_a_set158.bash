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
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_2 -p 90 -st topic158_0_1 -pt None -u 0.007058888089836846 > ./result_6chains/node158_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_2 -p 174 -st topic158_1_1 -pt None -u 0.023709445036911414 > ./result_6chains/node158_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_2 -p 195 -st topic158_2_1 -pt None -u 0.005278182720606539 > ./result_6chains/node158_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_2 -p 259 -st topic158_3_1 -pt None -u 0.024224888211987566 > ./result_6chains/node158_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_4_2 -p 818 -st topic158_4_1 -pt None -u 0.038923897068932234 > ./result_6chains/node158_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_5_2 -p 873 -st topic158_5_1 -pt None -u 0.054079695293609155 > ./result_6chains/node158_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_0_0 -p 90 -st none -pt topic158_0_0 -u 0.0017011813082045135 > ./result_6chains/node158_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_1_0 -p 174 -st none -pt topic158_1_0 -u 0.03610106291414217 > ./result_6chains/node158_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_2_0 -p 195 -st none -pt topic158_2_0 -u 0.0482085709696774 > ./result_6chains/node158_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_3_0 -p 259 -st none -pt topic158_3_0 -u 0.020988552521913395 > ./result_6chains/node158_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node158_4_0 -p 818 -st none -pt topic158_4_0 -u 0.03820429360912339 > ./result_6chains/node158_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node158_5_0 -p 873 -st none -pt topic158_5_0 -u 0.025912088993876953 > ./result_6chains/node158_5_0.txt &
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
    "./result_6chains/node158_0_0.txt 90"
    "./result_6chains/node158_0_2.txt 90"
    "./result_6chains/node158_1_0.txt 89"
    "./result_6chains/node158_1_2.txt 89"
    "./result_6chains/node158_2_0.txt 88"
    "./result_6chains/node158_2_2.txt 88"
    "./result_6chains/node158_3_0.txt 87"
    "./result_6chains/node158_3_2.txt 87"
    "./result_6chains/node158_4_0.txt 86"
    "./result_6chains/node158_4_2.txt 86"
    "./result_6chains/node158_5_0.txt 85"
    "./result_6chains/node158_5_2.txt 85"
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

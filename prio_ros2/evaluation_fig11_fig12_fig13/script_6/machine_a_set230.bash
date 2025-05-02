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
ros2 run evaluation_3_randomdag uunifast_node -n node230_0_2 -p 106 -st topic230_0_1 -pt None -u 0.008290295116775481 > ./result_6chains/node230_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_1_2 -p 382 -st topic230_1_1 -pt None -u 0.04004177957092858 > ./result_6chains/node230_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_2_2 -p 433 -st topic230_2_1 -pt None -u 0.07708548592731249 > ./result_6chains/node230_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_3_2 -p 874 -st topic230_3_1 -pt None -u 0.02166034006232763 > ./result_6chains/node230_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_4_2 -p 993 -st topic230_4_1 -pt None -u 0.01252625541185725 > ./result_6chains/node230_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_5_2 -p 996 -st topic230_5_1 -pt None -u 0.021286504494627274 > ./result_6chains/node230_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_0_0 -p 106 -st none -pt topic230_0_0 -u 0.027992828846213236 > ./result_6chains/node230_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_1_0 -p 382 -st none -pt topic230_1_0 -u 0.03200486739488878 > ./result_6chains/node230_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_2_0 -p 433 -st none -pt topic230_2_0 -u 0.07004402735610443 > ./result_6chains/node230_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_3_0 -p 874 -st none -pt topic230_3_0 -u 0.07622531558045018 > ./result_6chains/node230_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node230_4_0 -p 993 -st none -pt topic230_4_0 -u 0.011040592234109803 > ./result_6chains/node230_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node230_5_0 -p 996 -st none -pt topic230_5_0 -u 0.003882452642341973 > ./result_6chains/node230_5_0.txt &
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
    "./result_6chains/node230_0_0.txt 90"
    "./result_6chains/node230_0_2.txt 90"
    "./result_6chains/node230_1_0.txt 89"
    "./result_6chains/node230_1_2.txt 89"
    "./result_6chains/node230_2_0.txt 88"
    "./result_6chains/node230_2_2.txt 88"
    "./result_6chains/node230_3_0.txt 87"
    "./result_6chains/node230_3_2.txt 87"
    "./result_6chains/node230_4_0.txt 86"
    "./result_6chains/node230_4_2.txt 86"
    "./result_6chains/node230_5_0.txt 85"
    "./result_6chains/node230_5_2.txt 85"
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

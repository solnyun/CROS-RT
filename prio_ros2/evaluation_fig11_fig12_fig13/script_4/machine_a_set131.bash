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
ros2 run evaluation_3_randomdag uunifast_node -n node131_0_2 -p 220 -st topic131_0_1 -pt None -u 0.08290751108577604 > ./result_4chains/node131_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_1_2 -p 228 -st topic131_1_1 -pt None -u 0.062205401656993314 > ./result_4chains/node131_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_2_2 -p 339 -st topic131_2_1 -pt None -u 0.04213550102961218 > ./result_4chains/node131_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_3_2 -p 435 -st topic131_3_1 -pt None -u 0.01131683456545344 > ./result_4chains/node131_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_0_0 -p 220 -st none -pt topic131_0_0 -u 0.00855647187185532 > ./result_4chains/node131_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_1_0 -p 228 -st none -pt topic131_1_0 -u 0.0026744047518175718 > ./result_4chains/node131_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node131_2_0 -p 339 -st none -pt topic131_2_0 -u 0.010966870119543504 > ./result_4chains/node131_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node131_3_0 -p 435 -st none -pt topic131_3_0 -u 0.04891349922665015 > ./result_4chains/node131_3_0.txt &
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
    "./result_4chains/node131_0_0.txt 90"
    "./result_4chains/node131_0_2.txt 90"
    "./result_4chains/node131_1_0.txt 89"
    "./result_4chains/node131_1_2.txt 89"
    "./result_4chains/node131_2_0.txt 88"
    "./result_4chains/node131_2_2.txt 88"
    "./result_4chains/node131_3_0.txt 87"
    "./result_4chains/node131_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

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
ros2 run evaluation_3_randomdag uunifast_node -n node244_0_2 -p 405 -st topic244_0_1 -pt None -u 0.016133367083176753 > ./result_6chains/node244_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_1_2 -p 517 -st topic244_1_1 -pt None -u 0.024205076739825526 > ./result_6chains/node244_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_2_2 -p 567 -st topic244_2_1 -pt None -u 0.006035368056663992 > ./result_6chains/node244_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_3_2 -p 569 -st topic244_3_1 -pt None -u 0.01138151932445347 > ./result_6chains/node244_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_4_2 -p 618 -st topic244_4_1 -pt None -u 0.003537918979420518 > ./result_6chains/node244_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_5_2 -p 668 -st topic244_5_1 -pt None -u 0.04918241447039602 > ./result_6chains/node244_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_0_0 -p 405 -st none -pt topic244_0_0 -u 0.005313069924748393 > ./result_6chains/node244_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_1_0 -p 517 -st none -pt topic244_1_0 -u 0.01422627153748074 > ./result_6chains/node244_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_2_0 -p 567 -st none -pt topic244_2_0 -u 0.0017130165458223434 > ./result_6chains/node244_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_3_0 -p 569 -st none -pt topic244_3_0 -u 0.0018838977826088898 > ./result_6chains/node244_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node244_4_0 -p 618 -st none -pt topic244_4_0 -u 0.02219990464363139 > ./result_6chains/node244_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node244_5_0 -p 668 -st none -pt topic244_5_0 -u 0.044594244416833975 > ./result_6chains/node244_5_0.txt &
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
    "./result_6chains/node244_0_0.txt 90"
    "./result_6chains/node244_0_2.txt 90"
    "./result_6chains/node244_1_0.txt 89"
    "./result_6chains/node244_1_2.txt 89"
    "./result_6chains/node244_2_0.txt 88"
    "./result_6chains/node244_2_2.txt 88"
    "./result_6chains/node244_3_0.txt 87"
    "./result_6chains/node244_3_2.txt 87"
    "./result_6chains/node244_4_0.txt 86"
    "./result_6chains/node244_4_2.txt 86"
    "./result_6chains/node244_5_0.txt 85"
    "./result_6chains/node244_5_2.txt 85"
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

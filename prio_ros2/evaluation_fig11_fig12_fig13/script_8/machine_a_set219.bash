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
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_2 -p 52 -st topic219_0_1 -pt None -u 0.0011625483449683172 > ./result_8chains/node219_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_2 -p 320 -st topic219_1_1 -pt None -u 0.03672053799445646 > ./result_8chains/node219_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_2 -p 438 -st topic219_2_1 -pt None -u 0.012666754065309815 > ./result_8chains/node219_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_2 -p 655 -st topic219_3_1 -pt None -u 0.0063340462759965965 > ./result_8chains/node219_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_2 -p 670 -st topic219_4_1 -pt None -u 0.004658495375557015 > ./result_8chains/node219_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_2 -p 683 -st topic219_5_1 -pt None -u 0.02486341673973534 > ./result_8chains/node219_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_6_2 -p 860 -st topic219_6_1 -pt None -u 0.0015905346405396988 > ./result_8chains/node219_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_7_2 -p 896 -st topic219_7_1 -pt None -u 0.007059435522730392 > ./result_8chains/node219_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_0_0 -p 52 -st none -pt topic219_0_0 -u 0.010450178431442858 > ./result_8chains/node219_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_1_0 -p 320 -st none -pt topic219_1_0 -u 0.09163964332681013 > ./result_8chains/node219_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_2_0 -p 438 -st none -pt topic219_2_0 -u 0.052164603412786226 > ./result_8chains/node219_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_3_0 -p 655 -st none -pt topic219_3_0 -u 0.027722731273646578 > ./result_8chains/node219_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_4_0 -p 670 -st none -pt topic219_4_0 -u 0.010114639910337425 > ./result_8chains/node219_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_5_0 -p 683 -st none -pt topic219_5_0 -u 0.03681024301984262 > ./result_8chains/node219_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node219_6_0 -p 860 -st none -pt topic219_6_0 -u 0.009035898174666289 > ./result_8chains/node219_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node219_7_0 -p 896 -st none -pt topic219_7_0 -u 0.007097176203351634 > ./result_8chains/node219_7_0.txt &
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
    "./result_8chains/node219_0_0.txt 90"
    "./result_8chains/node219_0_2.txt 90"
    "./result_8chains/node219_1_0.txt 89"
    "./result_8chains/node219_1_2.txt 89"
    "./result_8chains/node219_2_0.txt 88"
    "./result_8chains/node219_2_2.txt 88"
    "./result_8chains/node219_3_0.txt 87"
    "./result_8chains/node219_3_2.txt 87"
    "./result_8chains/node219_4_0.txt 86"
    "./result_8chains/node219_4_2.txt 86"
    "./result_8chains/node219_5_0.txt 85"
    "./result_8chains/node219_5_2.txt 85"
    "./result_8chains/node219_6_0.txt 84"
    "./result_8chains/node219_6_2.txt 84"
    "./result_8chains/node219_7_0.txt 83"
    "./result_8chains/node219_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

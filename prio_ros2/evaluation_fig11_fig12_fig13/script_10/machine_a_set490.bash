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
ros2 run evaluation_3_randomdag uunifast_node -n node490_0_2 -p 206 -st topic490_0_1 -pt None -u 0.03635279007832409 > ./result_10chains/node490_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_1_2 -p 226 -st topic490_1_1 -pt None -u 0.013602950491585664 > ./result_10chains/node490_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_2_2 -p 374 -st topic490_2_1 -pt None -u 0.02947010904598052 > ./result_10chains/node490_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_3_2 -p 521 -st topic490_3_1 -pt None -u 0.02468488666107882 > ./result_10chains/node490_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_4_2 -p 608 -st topic490_4_1 -pt None -u 0.041567549224408834 > ./result_10chains/node490_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_5_2 -p 699 -st topic490_5_1 -pt None -u 0.020491191589785657 > ./result_10chains/node490_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_6_2 -p 899 -st topic490_6_1 -pt None -u 0.010795110753530054 > ./result_10chains/node490_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_7_2 -p 926 -st topic490_7_1 -pt None -u 0.009199544620292419 > ./result_10chains/node490_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_8_2 -p 959 -st topic490_8_1 -pt None -u 0.004681677185696016 > ./result_10chains/node490_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_9_2 -p 969 -st topic490_9_1 -pt None -u 0.010307233572393068 > ./result_10chains/node490_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_0_0 -p 206 -st none -pt topic490_0_0 -u 0.018010599886334244 > ./result_10chains/node490_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_1_0 -p 226 -st none -pt topic490_1_0 -u 0.006606872532739061 > ./result_10chains/node490_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_2_0 -p 374 -st none -pt topic490_2_0 -u 0.05567446797992698 > ./result_10chains/node490_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_3_0 -p 521 -st none -pt topic490_3_0 -u 0.026863984812810215 > ./result_10chains/node490_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_4_0 -p 608 -st none -pt topic490_4_0 -u 0.002091423691915062 > ./result_10chains/node490_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_5_0 -p 699 -st none -pt topic490_5_0 -u 0.02916521829457666 > ./result_10chains/node490_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_6_0 -p 899 -st none -pt topic490_6_0 -u 0.0010200830610361533 > ./result_10chains/node490_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_7_0 -p 926 -st none -pt topic490_7_0 -u 0.01028076980456051 > ./result_10chains/node490_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node490_8_0 -p 959 -st none -pt topic490_8_0 -u 0.01087496854060059 > ./result_10chains/node490_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node490_9_0 -p 969 -st none -pt topic490_9_0 -u 0.010398270647668094 > ./result_10chains/node490_9_0.txt &
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
    "./result_10chains/node490_0_0.txt 90"
    "./result_10chains/node490_0_2.txt 90"
    "./result_10chains/node490_1_0.txt 89"
    "./result_10chains/node490_1_2.txt 89"
    "./result_10chains/node490_2_0.txt 88"
    "./result_10chains/node490_2_2.txt 88"
    "./result_10chains/node490_3_0.txt 87"
    "./result_10chains/node490_3_2.txt 87"
    "./result_10chains/node490_4_0.txt 86"
    "./result_10chains/node490_4_2.txt 86"
    "./result_10chains/node490_5_0.txt 85"
    "./result_10chains/node490_5_2.txt 85"
    "./result_10chains/node490_6_0.txt 84"
    "./result_10chains/node490_6_2.txt 84"
    "./result_10chains/node490_7_0.txt 83"
    "./result_10chains/node490_7_2.txt 83"
    "./result_10chains/node490_8_0.txt 82"
    "./result_10chains/node490_8_2.txt 82"
    "./result_10chains/node490_9_0.txt 81"
    "./result_10chains/node490_9_2.txt 81"
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

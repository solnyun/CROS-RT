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
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_2 -p 73 -st topic327_0_1 -pt None -u 0.0037627589754902213 > ./result_10chains/node327_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_2 -p 147 -st topic327_1_1 -pt None -u 0.00511985717234148 > ./result_10chains/node327_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_2 -p 221 -st topic327_2_1 -pt None -u 0.02314522047316303 > ./result_10chains/node327_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_2 -p 236 -st topic327_3_1 -pt None -u 0.012014441545193877 > ./result_10chains/node327_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_4_2 -p 361 -st topic327_4_1 -pt None -u 0.00412479943009425 > ./result_10chains/node327_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_5_2 -p 422 -st topic327_5_1 -pt None -u 0.011798504696000495 > ./result_10chains/node327_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_6_2 -p 436 -st topic327_6_1 -pt None -u 0.004487119433582126 > ./result_10chains/node327_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_7_2 -p 572 -st topic327_7_1 -pt None -u 0.012565100348033653 > ./result_10chains/node327_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_8_2 -p 707 -st topic327_8_1 -pt None -u 0.002593015751684226 > ./result_10chains/node327_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_9_2 -p 711 -st topic327_9_1 -pt None -u 0.020941491924233453 > ./result_10chains/node327_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_0_0 -p 73 -st none -pt topic327_0_0 -u 0.05883595409010678 > ./result_10chains/node327_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_1_0 -p 147 -st none -pt topic327_1_0 -u 0.002392034581453928 > ./result_10chains/node327_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_2_0 -p 221 -st none -pt topic327_2_0 -u 0.06866094021468083 > ./result_10chains/node327_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_3_0 -p 236 -st none -pt topic327_3_0 -u 0.015713251659405625 > ./result_10chains/node327_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_4_0 -p 361 -st none -pt topic327_4_0 -u 0.006015980536305615 > ./result_10chains/node327_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_5_0 -p 422 -st none -pt topic327_5_0 -u 0.004929908082907775 > ./result_10chains/node327_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_6_0 -p 436 -st none -pt topic327_6_0 -u 0.00557009747498588 > ./result_10chains/node327_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_7_0 -p 572 -st none -pt topic327_7_0 -u 0.05100289827208987 > ./result_10chains/node327_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node327_8_0 -p 707 -st none -pt topic327_8_0 -u 0.00796348261369273 > ./result_10chains/node327_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node327_9_0 -p 711 -st none -pt topic327_9_0 -u 0.01627130344221532 > ./result_10chains/node327_9_0.txt &
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
    "./result_10chains/node327_0_0.txt 90"
    "./result_10chains/node327_0_2.txt 90"
    "./result_10chains/node327_1_0.txt 89"
    "./result_10chains/node327_1_2.txt 89"
    "./result_10chains/node327_2_0.txt 88"
    "./result_10chains/node327_2_2.txt 88"
    "./result_10chains/node327_3_0.txt 87"
    "./result_10chains/node327_3_2.txt 87"
    "./result_10chains/node327_4_0.txt 86"
    "./result_10chains/node327_4_2.txt 86"
    "./result_10chains/node327_5_0.txt 85"
    "./result_10chains/node327_5_2.txt 85"
    "./result_10chains/node327_6_0.txt 84"
    "./result_10chains/node327_6_2.txt 84"
    "./result_10chains/node327_7_0.txt 83"
    "./result_10chains/node327_7_2.txt 83"
    "./result_10chains/node327_8_0.txt 82"
    "./result_10chains/node327_8_2.txt 82"
    "./result_10chains/node327_9_0.txt 81"
    "./result_10chains/node327_9_2.txt 81"
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

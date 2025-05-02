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
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_2 -p 230 -st topic69_0_1 -pt None -u 0.03979614284630412 > ./result_10chains/node69_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_2 -p 242 -st topic69_1_1 -pt None -u 0.003215040962214366 > ./result_10chains/node69_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_2 -p 244 -st topic69_2_1 -pt None -u 0.0010230702002338998 > ./result_10chains/node69_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_2 -p 351 -st topic69_3_1 -pt None -u 0.018962700110468467 > ./result_10chains/node69_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_2 -p 524 -st topic69_4_1 -pt None -u 0.021302166003026313 > ./result_10chains/node69_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_2 -p 550 -st topic69_5_1 -pt None -u 0.0244552531641673 > ./result_10chains/node69_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_6_2 -p 750 -st topic69_6_1 -pt None -u 0.12527227887510334 > ./result_10chains/node69_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_7_2 -p 882 -st topic69_7_1 -pt None -u 0.0046994617738820715 > ./result_10chains/node69_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_8_2 -p 891 -st topic69_8_1 -pt None -u 0.004000992465428236 > ./result_10chains/node69_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_9_2 -p 939 -st topic69_9_1 -pt None -u 0.009937940914671059 > ./result_10chains/node69_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_0 -p 230 -st none -pt topic69_0_0 -u 0.0216781149785506 > ./result_10chains/node69_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_0 -p 242 -st none -pt topic69_1_0 -u 0.00950185593152536 > ./result_10chains/node69_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_0 -p 244 -st none -pt topic69_2_0 -u 0.001410731814527666 > ./result_10chains/node69_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_0 -p 351 -st none -pt topic69_3_0 -u 0.015693680022715206 > ./result_10chains/node69_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_0 -p 524 -st none -pt topic69_4_0 -u 0.036078375342047 > ./result_10chains/node69_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_0 -p 550 -st none -pt topic69_5_0 -u 0.00895796048950337 > ./result_10chains/node69_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_6_0 -p 750 -st none -pt topic69_6_0 -u 0.014059899803307019 > ./result_10chains/node69_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_7_0 -p 882 -st none -pt topic69_7_0 -u 0.008302455176071186 > ./result_10chains/node69_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_8_0 -p 891 -st none -pt topic69_8_0 -u 0.019319162072539243 > ./result_10chains/node69_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_9_0 -p 939 -st none -pt topic69_9_0 -u 0.013541949893969922 > ./result_10chains/node69_9_0.txt &
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
    "./result_10chains/node69_0_0.txt 90"
    "./result_10chains/node69_0_2.txt 90"
    "./result_10chains/node69_1_0.txt 89"
    "./result_10chains/node69_1_2.txt 89"
    "./result_10chains/node69_2_0.txt 88"
    "./result_10chains/node69_2_2.txt 88"
    "./result_10chains/node69_3_0.txt 87"
    "./result_10chains/node69_3_2.txt 87"
    "./result_10chains/node69_4_0.txt 86"
    "./result_10chains/node69_4_2.txt 86"
    "./result_10chains/node69_5_0.txt 85"
    "./result_10chains/node69_5_2.txt 85"
    "./result_10chains/node69_6_0.txt 84"
    "./result_10chains/node69_6_2.txt 84"
    "./result_10chains/node69_7_0.txt 83"
    "./result_10chains/node69_7_2.txt 83"
    "./result_10chains/node69_8_0.txt 82"
    "./result_10chains/node69_8_2.txt 82"
    "./result_10chains/node69_9_0.txt 81"
    "./result_10chains/node69_9_2.txt 81"
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

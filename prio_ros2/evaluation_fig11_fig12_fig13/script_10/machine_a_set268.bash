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
ros2 run evaluation_3_randomdag uunifast_node -n node268_0_2 -p 96 -st topic268_0_1 -pt None -u 0.026703781398807303 > ./result_10chains/node268_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_1_2 -p 100 -st topic268_1_1 -pt None -u 0.024624946039641604 > ./result_10chains/node268_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_2_2 -p 401 -st topic268_2_1 -pt None -u 0.003856703298415365 > ./result_10chains/node268_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_3_2 -p 590 -st topic268_3_1 -pt None -u 0.01291498331456209 > ./result_10chains/node268_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_4_2 -p 611 -st topic268_4_1 -pt None -u 0.007241274639147921 > ./result_10chains/node268_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_5_2 -p 685 -st topic268_5_1 -pt None -u 0.005788838610733815 > ./result_10chains/node268_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_6_2 -p 748 -st topic268_6_1 -pt None -u 0.024575055687640013 > ./result_10chains/node268_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_7_2 -p 886 -st topic268_7_1 -pt None -u 0.03425754328954912 > ./result_10chains/node268_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_8_2 -p 902 -st topic268_8_1 -pt None -u 0.01603392733308212 > ./result_10chains/node268_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_9_2 -p 963 -st topic268_9_1 -pt None -u 0.010982077437930171 > ./result_10chains/node268_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_0_0 -p 96 -st none -pt topic268_0_0 -u 0.010756352043501283 > ./result_10chains/node268_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_1_0 -p 100 -st none -pt topic268_1_0 -u 0.017785505448180416 > ./result_10chains/node268_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_2_0 -p 401 -st none -pt topic268_2_0 -u 0.00032999191097926595 > ./result_10chains/node268_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_3_0 -p 590 -st none -pt topic268_3_0 -u 0.00826957746720769 > ./result_10chains/node268_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_4_0 -p 611 -st none -pt topic268_4_0 -u 0.06613194286645052 > ./result_10chains/node268_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_5_0 -p 685 -st none -pt topic268_5_0 -u 0.01840273615156368 > ./result_10chains/node268_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_6_0 -p 748 -st none -pt topic268_6_0 -u 0.032425749721151226 > ./result_10chains/node268_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_7_0 -p 886 -st none -pt topic268_7_0 -u 0.007363902921859178 > ./result_10chains/node268_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node268_8_0 -p 902 -st none -pt topic268_8_0 -u 0.021893263572201643 > ./result_10chains/node268_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node268_9_0 -p 963 -st none -pt topic268_9_0 -u 0.03109212677285522 > ./result_10chains/node268_9_0.txt &
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
    "./result_10chains/node268_0_0.txt 90"
    "./result_10chains/node268_0_2.txt 90"
    "./result_10chains/node268_1_0.txt 89"
    "./result_10chains/node268_1_2.txt 89"
    "./result_10chains/node268_2_0.txt 88"
    "./result_10chains/node268_2_2.txt 88"
    "./result_10chains/node268_3_0.txt 87"
    "./result_10chains/node268_3_2.txt 87"
    "./result_10chains/node268_4_0.txt 86"
    "./result_10chains/node268_4_2.txt 86"
    "./result_10chains/node268_5_0.txt 85"
    "./result_10chains/node268_5_2.txt 85"
    "./result_10chains/node268_6_0.txt 84"
    "./result_10chains/node268_6_2.txt 84"
    "./result_10chains/node268_7_0.txt 83"
    "./result_10chains/node268_7_2.txt 83"
    "./result_10chains/node268_8_0.txt 82"
    "./result_10chains/node268_8_2.txt 82"
    "./result_10chains/node268_9_0.txt 81"
    "./result_10chains/node268_9_2.txt 81"
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

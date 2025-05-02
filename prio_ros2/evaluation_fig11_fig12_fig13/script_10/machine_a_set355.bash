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
ros2 run evaluation_3_randomdag uunifast_node -n node355_0_2 -p 41 -st topic355_0_1 -pt None -u 0.011368428014761844 > ./result_10chains/node355_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_1_2 -p 81 -st topic355_1_1 -pt None -u 0.011055807362580272 > ./result_10chains/node355_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_2_2 -p 185 -st topic355_2_1 -pt None -u 0.005189911336424713 > ./result_10chains/node355_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_3_2 -p 221 -st topic355_3_1 -pt None -u 0.017155235571056193 > ./result_10chains/node355_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_4_2 -p 423 -st topic355_4_1 -pt None -u 0.014702521323730677 > ./result_10chains/node355_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_5_2 -p 459 -st topic355_5_1 -pt None -u 0.00283172293109607 > ./result_10chains/node355_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_6_2 -p 682 -st topic355_6_1 -pt None -u 0.03976243430938703 > ./result_10chains/node355_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_7_2 -p 722 -st topic355_7_1 -pt None -u 0.02599674785525838 > ./result_10chains/node355_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_8_2 -p 776 -st topic355_8_1 -pt None -u 0.03854814088030627 > ./result_10chains/node355_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_9_2 -p 932 -st topic355_9_1 -pt None -u 0.015519409142102458 > ./result_10chains/node355_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_0_0 -p 41 -st none -pt topic355_0_0 -u 0.02866312474725724 > ./result_10chains/node355_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_1_0 -p 81 -st none -pt topic355_1_0 -u 0.021751260092910563 > ./result_10chains/node355_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_2_0 -p 185 -st none -pt topic355_2_0 -u 0.011859193060597017 > ./result_10chains/node355_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_3_0 -p 221 -st none -pt topic355_3_0 -u 0.002300377685004351 > ./result_10chains/node355_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_4_0 -p 423 -st none -pt topic355_4_0 -u 0.01311037603099452 > ./result_10chains/node355_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_5_0 -p 459 -st none -pt topic355_5_0 -u 0.004003106784586152 > ./result_10chains/node355_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_6_0 -p 682 -st none -pt topic355_6_0 -u 0.013981390108841751 > ./result_10chains/node355_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_7_0 -p 722 -st none -pt topic355_7_0 -u 0.004996211592219885 > ./result_10chains/node355_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_8_0 -p 776 -st none -pt topic355_8_0 -u 0.006812508778039822 > ./result_10chains/node355_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_9_0 -p 932 -st none -pt topic355_9_0 -u 0.08518894231826425 > ./result_10chains/node355_9_0.txt &
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
    "./result_10chains/node355_0_0.txt 90"
    "./result_10chains/node355_0_2.txt 90"
    "./result_10chains/node355_1_0.txt 89"
    "./result_10chains/node355_1_2.txt 89"
    "./result_10chains/node355_2_0.txt 88"
    "./result_10chains/node355_2_2.txt 88"
    "./result_10chains/node355_3_0.txt 87"
    "./result_10chains/node355_3_2.txt 87"
    "./result_10chains/node355_4_0.txt 86"
    "./result_10chains/node355_4_2.txt 86"
    "./result_10chains/node355_5_0.txt 85"
    "./result_10chains/node355_5_2.txt 85"
    "./result_10chains/node355_6_0.txt 84"
    "./result_10chains/node355_6_2.txt 84"
    "./result_10chains/node355_7_0.txt 83"
    "./result_10chains/node355_7_2.txt 83"
    "./result_10chains/node355_8_0.txt 82"
    "./result_10chains/node355_8_2.txt 82"
    "./result_10chains/node355_9_0.txt 81"
    "./result_10chains/node355_9_2.txt 81"
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

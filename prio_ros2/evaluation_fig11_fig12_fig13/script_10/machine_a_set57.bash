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
ros2 run evaluation_3_randomdag uunifast_node -n node57_0_2 -p 273 -st topic57_0_1 -pt None -u 0.019546580764104926 > ./result_10chains/node57_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_1_2 -p 294 -st topic57_1_1 -pt None -u 0.02302700824110082 > ./result_10chains/node57_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_2_2 -p 311 -st topic57_2_1 -pt None -u 0.017794637431513605 > ./result_10chains/node57_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_3_2 -p 412 -st topic57_3_1 -pt None -u 0.007276309484878618 > ./result_10chains/node57_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_4_2 -p 453 -st topic57_4_1 -pt None -u 0.015291933845488492 > ./result_10chains/node57_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_5_2 -p 580 -st topic57_5_1 -pt None -u 0.00028262611538931726 > ./result_10chains/node57_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_6_2 -p 581 -st topic57_6_1 -pt None -u 0.012133478382862994 > ./result_10chains/node57_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_7_2 -p 639 -st topic57_7_1 -pt None -u 0.003177893821940503 > ./result_10chains/node57_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_8_2 -p 744 -st topic57_8_1 -pt None -u 0.05514867968252742 > ./result_10chains/node57_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_9_2 -p 853 -st topic57_9_1 -pt None -u 0.015151814757885698 > ./result_10chains/node57_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_0_0 -p 273 -st none -pt topic57_0_0 -u 0.0006189206862441954 > ./result_10chains/node57_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_1_0 -p 294 -st none -pt topic57_1_0 -u 0.012282662249392506 > ./result_10chains/node57_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_2_0 -p 311 -st none -pt topic57_2_0 -u 0.0035875626475024847 > ./result_10chains/node57_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_3_0 -p 412 -st none -pt topic57_3_0 -u 0.0022278220181508046 > ./result_10chains/node57_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_4_0 -p 453 -st none -pt topic57_4_0 -u 0.00777330139634741 > ./result_10chains/node57_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_5_0 -p 580 -st none -pt topic57_5_0 -u 0.0003615988589303343 > ./result_10chains/node57_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_6_0 -p 581 -st none -pt topic57_6_0 -u 0.020176695748139684 > ./result_10chains/node57_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_7_0 -p 639 -st none -pt topic57_7_0 -u 0.04766387280843212 > ./result_10chains/node57_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node57_8_0 -p 744 -st none -pt topic57_8_0 -u 0.013658606924499134 > ./result_10chains/node57_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node57_9_0 -p 853 -st none -pt topic57_9_0 -u 0.0041720552525727345 > ./result_10chains/node57_9_0.txt &
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
    "./result_10chains/node57_0_0.txt 90"
    "./result_10chains/node57_0_2.txt 90"
    "./result_10chains/node57_1_0.txt 89"
    "./result_10chains/node57_1_2.txt 89"
    "./result_10chains/node57_2_0.txt 88"
    "./result_10chains/node57_2_2.txt 88"
    "./result_10chains/node57_3_0.txt 87"
    "./result_10chains/node57_3_2.txt 87"
    "./result_10chains/node57_4_0.txt 86"
    "./result_10chains/node57_4_2.txt 86"
    "./result_10chains/node57_5_0.txt 85"
    "./result_10chains/node57_5_2.txt 85"
    "./result_10chains/node57_6_0.txt 84"
    "./result_10chains/node57_6_2.txt 84"
    "./result_10chains/node57_7_0.txt 83"
    "./result_10chains/node57_7_2.txt 83"
    "./result_10chains/node57_8_0.txt 82"
    "./result_10chains/node57_8_2.txt 82"
    "./result_10chains/node57_9_0.txt 81"
    "./result_10chains/node57_9_2.txt 81"
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

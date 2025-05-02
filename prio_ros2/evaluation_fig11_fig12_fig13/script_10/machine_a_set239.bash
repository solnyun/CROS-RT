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
ros2 run evaluation_3_randomdag uunifast_node -n node239_0_2 -p 62 -st topic239_0_1 -pt None -u 0.01981475275958189 > ./result_10chains/node239_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_1_2 -p 110 -st topic239_1_1 -pt None -u 0.008178891768626295 > ./result_10chains/node239_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_2_2 -p 262 -st topic239_2_1 -pt None -u 0.001307640709111435 > ./result_10chains/node239_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_3_2 -p 336 -st topic239_3_1 -pt None -u 0.027417347338309472 > ./result_10chains/node239_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_4_2 -p 552 -st topic239_4_1 -pt None -u 0.0031867852173353417 > ./result_10chains/node239_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_5_2 -p 566 -st topic239_5_1 -pt None -u 0.020900979121762947 > ./result_10chains/node239_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_6_2 -p 843 -st topic239_6_1 -pt None -u 0.009673377706773595 > ./result_10chains/node239_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_7_2 -p 867 -st topic239_7_1 -pt None -u 0.0025391739886133358 > ./result_10chains/node239_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_8_2 -p 895 -st topic239_8_1 -pt None -u 0.05654942280718517 > ./result_10chains/node239_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_9_2 -p 914 -st topic239_9_1 -pt None -u 0.012325551577815614 > ./result_10chains/node239_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_0_0 -p 62 -st none -pt topic239_0_0 -u 0.015336067665573438 > ./result_10chains/node239_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_1_0 -p 110 -st none -pt topic239_1_0 -u 0.023624581263237077 > ./result_10chains/node239_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_2_0 -p 262 -st none -pt topic239_2_0 -u 0.007792149573829288 > ./result_10chains/node239_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_3_0 -p 336 -st none -pt topic239_3_0 -u 0.014325738085120387 > ./result_10chains/node239_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_4_0 -p 552 -st none -pt topic239_4_0 -u 0.009277985892349405 > ./result_10chains/node239_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_5_0 -p 566 -st none -pt topic239_5_0 -u 0.008661968385736601 > ./result_10chains/node239_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_6_0 -p 843 -st none -pt topic239_6_0 -u 0.00519159380324255 > ./result_10chains/node239_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_7_0 -p 867 -st none -pt topic239_7_0 -u 0.003178360516150419 > ./result_10chains/node239_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node239_8_0 -p 895 -st none -pt topic239_8_0 -u 0.0026893678082755557 > ./result_10chains/node239_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node239_9_0 -p 914 -st none -pt topic239_9_0 -u 0.057201752043271256 > ./result_10chains/node239_9_0.txt &
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
    "./result_10chains/node239_0_0.txt 90"
    "./result_10chains/node239_0_2.txt 90"
    "./result_10chains/node239_1_0.txt 89"
    "./result_10chains/node239_1_2.txt 89"
    "./result_10chains/node239_2_0.txt 88"
    "./result_10chains/node239_2_2.txt 88"
    "./result_10chains/node239_3_0.txt 87"
    "./result_10chains/node239_3_2.txt 87"
    "./result_10chains/node239_4_0.txt 86"
    "./result_10chains/node239_4_2.txt 86"
    "./result_10chains/node239_5_0.txt 85"
    "./result_10chains/node239_5_2.txt 85"
    "./result_10chains/node239_6_0.txt 84"
    "./result_10chains/node239_6_2.txt 84"
    "./result_10chains/node239_7_0.txt 83"
    "./result_10chains/node239_7_2.txt 83"
    "./result_10chains/node239_8_0.txt 82"
    "./result_10chains/node239_8_2.txt 82"
    "./result_10chains/node239_9_0.txt 81"
    "./result_10chains/node239_9_2.txt 81"
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

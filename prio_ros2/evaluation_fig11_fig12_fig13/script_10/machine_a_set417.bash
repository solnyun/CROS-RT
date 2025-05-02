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
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_2 -p 144 -st topic417_0_1 -pt None -u 0.010904105333925107 > ./result_10chains/node417_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_2 -p 250 -st topic417_1_1 -pt None -u 0.05769356555886035 > ./result_10chains/node417_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_2 -p 261 -st topic417_2_1 -pt None -u 0.02742254654011378 > ./result_10chains/node417_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_2 -p 402 -st topic417_3_1 -pt None -u 0.013979902612106576 > ./result_10chains/node417_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_2 -p 404 -st topic417_4_1 -pt None -u 0.019909916078020617 > ./result_10chains/node417_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_2 -p 506 -st topic417_5_1 -pt None -u 0.010247176677695896 > ./result_10chains/node417_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_6_2 -p 655 -st topic417_6_1 -pt None -u 0.0019096200735209123 > ./result_10chains/node417_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_7_2 -p 682 -st topic417_7_1 -pt None -u 0.03374224956704765 > ./result_10chains/node417_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_8_2 -p 745 -st topic417_8_1 -pt None -u 0.021289610856115332 > ./result_10chains/node417_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_9_2 -p 772 -st topic417_9_1 -pt None -u 0.005860443174253133 > ./result_10chains/node417_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_0_0 -p 144 -st none -pt topic417_0_0 -u 0.03406747392715875 > ./result_10chains/node417_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_1_0 -p 250 -st none -pt topic417_1_0 -u 0.012886435232025095 > ./result_10chains/node417_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_2_0 -p 261 -st none -pt topic417_2_0 -u 0.010394122371085168 > ./result_10chains/node417_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_3_0 -p 402 -st none -pt topic417_3_0 -u 0.01108583259831325 > ./result_10chains/node417_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_4_0 -p 404 -st none -pt topic417_4_0 -u 0.014955834612439933 > ./result_10chains/node417_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_5_0 -p 506 -st none -pt topic417_5_0 -u 0.0056353820545424205 > ./result_10chains/node417_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_6_0 -p 655 -st none -pt topic417_6_0 -u 0.0026259441244355364 > ./result_10chains/node417_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_7_0 -p 682 -st none -pt topic417_7_0 -u 0.002808442567653918 > ./result_10chains/node417_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node417_8_0 -p 745 -st none -pt topic417_8_0 -u 0.00364359435982102 > ./result_10chains/node417_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node417_9_0 -p 772 -st none -pt topic417_9_0 -u 0.002048161956703272 > ./result_10chains/node417_9_0.txt &
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
    "./result_10chains/node417_0_0.txt 90"
    "./result_10chains/node417_0_2.txt 90"
    "./result_10chains/node417_1_0.txt 89"
    "./result_10chains/node417_1_2.txt 89"
    "./result_10chains/node417_2_0.txt 88"
    "./result_10chains/node417_2_2.txt 88"
    "./result_10chains/node417_3_0.txt 87"
    "./result_10chains/node417_3_2.txt 87"
    "./result_10chains/node417_4_0.txt 86"
    "./result_10chains/node417_4_2.txt 86"
    "./result_10chains/node417_5_0.txt 85"
    "./result_10chains/node417_5_2.txt 85"
    "./result_10chains/node417_6_0.txt 84"
    "./result_10chains/node417_6_2.txt 84"
    "./result_10chains/node417_7_0.txt 83"
    "./result_10chains/node417_7_2.txt 83"
    "./result_10chains/node417_8_0.txt 82"
    "./result_10chains/node417_8_2.txt 82"
    "./result_10chains/node417_9_0.txt 81"
    "./result_10chains/node417_9_2.txt 81"
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

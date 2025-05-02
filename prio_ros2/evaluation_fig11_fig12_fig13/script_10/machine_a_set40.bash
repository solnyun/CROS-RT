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
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_2 -p 218 -st topic40_0_1 -pt None -u 0.0012778088766896012 > ./result_10chains/node40_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_2 -p 251 -st topic40_1_1 -pt None -u 0.0031836429917542763 > ./result_10chains/node40_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_2 -p 281 -st topic40_2_1 -pt None -u 0.010795868966251565 > ./result_10chains/node40_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_2 -p 286 -st topic40_3_1 -pt None -u 0.025917536258736718 > ./result_10chains/node40_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_2 -p 610 -st topic40_4_1 -pt None -u 0.045498689358150324 > ./result_10chains/node40_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_2 -p 687 -st topic40_5_1 -pt None -u 0.0010420525198462371 > ./result_10chains/node40_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_6_2 -p 781 -st topic40_6_1 -pt None -u 0.000827721973776091 > ./result_10chains/node40_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_7_2 -p 833 -st topic40_7_1 -pt None -u 0.009795812426251119 > ./result_10chains/node40_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_8_2 -p 883 -st topic40_8_1 -pt None -u 0.015690719068018354 > ./result_10chains/node40_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_9_2 -p 908 -st topic40_9_1 -pt None -u 0.008223811744114929 > ./result_10chains/node40_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_0_0 -p 218 -st none -pt topic40_0_0 -u 0.009340034994241686 > ./result_10chains/node40_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_1_0 -p 251 -st none -pt topic40_1_0 -u 0.021475441461387412 > ./result_10chains/node40_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_2_0 -p 281 -st none -pt topic40_2_0 -u 0.0016710879509594379 > ./result_10chains/node40_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_3_0 -p 286 -st none -pt topic40_3_0 -u 0.01370333787962208 > ./result_10chains/node40_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_4_0 -p 610 -st none -pt topic40_4_0 -u 0.03235038273433061 > ./result_10chains/node40_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_5_0 -p 687 -st none -pt topic40_5_0 -u 0.031180708805211566 > ./result_10chains/node40_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_6_0 -p 781 -st none -pt topic40_6_0 -u 0.002666929779903543 > ./result_10chains/node40_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_7_0 -p 833 -st none -pt topic40_7_0 -u 0.06661400486224975 > ./result_10chains/node40_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node40_8_0 -p 883 -st none -pt topic40_8_0 -u 0.003577104329675715 > ./result_10chains/node40_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node40_9_0 -p 908 -st none -pt topic40_9_0 -u 0.024300201369386286 > ./result_10chains/node40_9_0.txt &
sleep 10
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
    "./result_10chains/node40_0_0.txt 90"
    "./result_10chains/node40_0_2.txt 90"
    "./result_10chains/node40_1_0.txt 89"
    "./result_10chains/node40_1_2.txt 89"
    "./result_10chains/node40_2_0.txt 88"
    "./result_10chains/node40_2_2.txt 88"
    "./result_10chains/node40_3_0.txt 87"
    "./result_10chains/node40_3_2.txt 87"
    "./result_10chains/node40_4_0.txt 86"
    "./result_10chains/node40_4_2.txt 86"
    "./result_10chains/node40_5_0.txt 85"
    "./result_10chains/node40_5_2.txt 85"
    "./result_10chains/node40_6_0.txt 84"
    "./result_10chains/node40_6_2.txt 84"
    "./result_10chains/node40_7_0.txt 83"
    "./result_10chains/node40_7_2.txt 83"
    "./result_10chains/node40_8_0.txt 82"
    "./result_10chains/node40_8_2.txt 82"
    "./result_10chains/node40_9_0.txt 81"
    "./result_10chains/node40_9_2.txt 81"
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
sleep 80s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

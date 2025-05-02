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
ros2 run evaluation_3_randomdag uunifast_node -n node108_0_2 -p 374 -st topic108_0_1 -pt None -u 0.0011739811473260864 > ./result_10chains/node108_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_1_2 -p 460 -st topic108_1_1 -pt None -u 0.037246966342830534 > ./result_10chains/node108_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_2_2 -p 704 -st topic108_2_1 -pt None -u 0.011312201146912948 > ./result_10chains/node108_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_3_2 -p 746 -st topic108_3_1 -pt None -u 0.0051076027519241785 > ./result_10chains/node108_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_4_2 -p 748 -st topic108_4_1 -pt None -u 0.015101568805740317 > ./result_10chains/node108_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_5_2 -p 751 -st topic108_5_1 -pt None -u 0.004919047690466888 > ./result_10chains/node108_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_6_2 -p 769 -st topic108_6_1 -pt None -u 0.02207199689982968 > ./result_10chains/node108_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_7_2 -p 867 -st topic108_7_1 -pt None -u 0.0011613167239194616 > ./result_10chains/node108_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_8_2 -p 879 -st topic108_8_1 -pt None -u 0.029269574916464713 > ./result_10chains/node108_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_9_2 -p 889 -st topic108_9_1 -pt None -u 0.009669689798555273 > ./result_10chains/node108_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_0_0 -p 374 -st none -pt topic108_0_0 -u 0.003836548424581976 > ./result_10chains/node108_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_1_0 -p 460 -st none -pt topic108_1_0 -u 0.0015147187118270677 > ./result_10chains/node108_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_2_0 -p 704 -st none -pt topic108_2_0 -u 0.03879538575393954 > ./result_10chains/node108_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_3_0 -p 746 -st none -pt topic108_3_0 -u 0.007313740314921602 > ./result_10chains/node108_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_4_0 -p 748 -st none -pt topic108_4_0 -u 0.013397674801196136 > ./result_10chains/node108_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_5_0 -p 751 -st none -pt topic108_5_0 -u 1.2509983077890752e-05 > ./result_10chains/node108_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_6_0 -p 769 -st none -pt topic108_6_0 -u 0.053042303168081284 > ./result_10chains/node108_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_7_0 -p 867 -st none -pt topic108_7_0 -u 0.002411626655934404 > ./result_10chains/node108_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node108_8_0 -p 879 -st none -pt topic108_8_0 -u 0.001369387208852213 > ./result_10chains/node108_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node108_9_0 -p 889 -st none -pt topic108_9_0 -u 0.008063180090458703 > ./result_10chains/node108_9_0.txt &
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
    "./result_10chains/node108_0_0.txt 90"
    "./result_10chains/node108_0_2.txt 90"
    "./result_10chains/node108_1_0.txt 89"
    "./result_10chains/node108_1_2.txt 89"
    "./result_10chains/node108_2_0.txt 88"
    "./result_10chains/node108_2_2.txt 88"
    "./result_10chains/node108_3_0.txt 87"
    "./result_10chains/node108_3_2.txt 87"
    "./result_10chains/node108_4_0.txt 86"
    "./result_10chains/node108_4_2.txt 86"
    "./result_10chains/node108_5_0.txt 85"
    "./result_10chains/node108_5_2.txt 85"
    "./result_10chains/node108_6_0.txt 84"
    "./result_10chains/node108_6_2.txt 84"
    "./result_10chains/node108_7_0.txt 83"
    "./result_10chains/node108_7_2.txt 83"
    "./result_10chains/node108_8_0.txt 82"
    "./result_10chains/node108_8_2.txt 82"
    "./result_10chains/node108_9_0.txt 81"
    "./result_10chains/node108_9_2.txt 81"
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

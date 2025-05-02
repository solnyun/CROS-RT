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
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_2 -p 34 -st topic84_0_1 -pt None -u 0.07058753550304747 > ./result_10chains/node84_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_2 -p 223 -st topic84_1_1 -pt None -u 0.013715003937429249 > ./result_10chains/node84_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_2 -p 224 -st topic84_2_1 -pt None -u 0.013214078066178192 > ./result_10chains/node84_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_2 -p 328 -st topic84_3_1 -pt None -u 0.03964990031324028 > ./result_10chains/node84_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_2 -p 337 -st topic84_4_1 -pt None -u 0.009357412150916566 > ./result_10chains/node84_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_2 -p 429 -st topic84_5_1 -pt None -u 0.005755591476457378 > ./result_10chains/node84_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_6_2 -p 478 -st topic84_6_1 -pt None -u 0.04063769574718326 > ./result_10chains/node84_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_7_2 -p 827 -st topic84_7_1 -pt None -u 0.009111470133108465 > ./result_10chains/node84_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_8_2 -p 868 -st topic84_8_1 -pt None -u 0.000427139882747396 > ./result_10chains/node84_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_9_2 -p 936 -st topic84_9_1 -pt None -u 0.018963029882916742 > ./result_10chains/node84_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_0_0 -p 34 -st none -pt topic84_0_0 -u 0.010329546545762791 > ./result_10chains/node84_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_1_0 -p 223 -st none -pt topic84_1_0 -u 0.016140171889148847 > ./result_10chains/node84_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_2_0 -p 224 -st none -pt topic84_2_0 -u 0.029062769322781734 > ./result_10chains/node84_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_3_0 -p 328 -st none -pt topic84_3_0 -u 0.007436882243708531 > ./result_10chains/node84_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_4_0 -p 337 -st none -pt topic84_4_0 -u 0.01858706252253678 > ./result_10chains/node84_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_5_0 -p 429 -st none -pt topic84_5_0 -u 0.006890567481269871 > ./result_10chains/node84_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_6_0 -p 478 -st none -pt topic84_6_0 -u 0.015254914561752903 > ./result_10chains/node84_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_7_0 -p 827 -st none -pt topic84_7_0 -u 0.004089177067682831 > ./result_10chains/node84_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node84_8_0 -p 868 -st none -pt topic84_8_0 -u 0.0018515929252118646 > ./result_10chains/node84_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node84_9_0 -p 936 -st none -pt topic84_9_0 -u 0.008959477085107668 > ./result_10chains/node84_9_0.txt &
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
    "./result_10chains/node84_0_0.txt 90"
    "./result_10chains/node84_0_2.txt 90"
    "./result_10chains/node84_1_0.txt 89"
    "./result_10chains/node84_1_2.txt 89"
    "./result_10chains/node84_2_0.txt 88"
    "./result_10chains/node84_2_2.txt 88"
    "./result_10chains/node84_3_0.txt 87"
    "./result_10chains/node84_3_2.txt 87"
    "./result_10chains/node84_4_0.txt 86"
    "./result_10chains/node84_4_2.txt 86"
    "./result_10chains/node84_5_0.txt 85"
    "./result_10chains/node84_5_2.txt 85"
    "./result_10chains/node84_6_0.txt 84"
    "./result_10chains/node84_6_2.txt 84"
    "./result_10chains/node84_7_0.txt 83"
    "./result_10chains/node84_7_2.txt 83"
    "./result_10chains/node84_8_0.txt 82"
    "./result_10chains/node84_8_2.txt 82"
    "./result_10chains/node84_9_0.txt 81"
    "./result_10chains/node84_9_2.txt 81"
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

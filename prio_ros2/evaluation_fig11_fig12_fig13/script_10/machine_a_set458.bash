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
ros2 run evaluation_3_randomdag uunifast_node -n node458_0_2 -p 239 -st topic458_0_1 -pt None -u 0.0041649013473391006 > ./result_10chains/node458_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_1_2 -p 332 -st topic458_1_1 -pt None -u 0.019253651078251666 > ./result_10chains/node458_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_2_2 -p 348 -st topic458_2_1 -pt None -u 0.017146711316408325 > ./result_10chains/node458_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_3_2 -p 458 -st topic458_3_1 -pt None -u 0.002218958672605631 > ./result_10chains/node458_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_4_2 -p 521 -st topic458_4_1 -pt None -u 0.025328195082475025 > ./result_10chains/node458_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_5_2 -p 550 -st topic458_5_1 -pt None -u 0.054019536341533586 > ./result_10chains/node458_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_6_2 -p 750 -st topic458_6_1 -pt None -u 0.003683559200314074 > ./result_10chains/node458_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_7_2 -p 840 -st topic458_7_1 -pt None -u 0.06693723454943001 > ./result_10chains/node458_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_8_2 -p 854 -st topic458_8_1 -pt None -u 0.023588150956536602 > ./result_10chains/node458_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_9_2 -p 936 -st topic458_9_1 -pt None -u 0.05789425048558338 > ./result_10chains/node458_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_0_0 -p 239 -st none -pt topic458_0_0 -u 0.01540845661530399 > ./result_10chains/node458_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_1_0 -p 332 -st none -pt topic458_1_0 -u 0.01262074329352697 > ./result_10chains/node458_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_2_0 -p 348 -st none -pt topic458_2_0 -u 0.008031084874071726 > ./result_10chains/node458_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_3_0 -p 458 -st none -pt topic458_3_0 -u 0.020648230405784174 > ./result_10chains/node458_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_4_0 -p 521 -st none -pt topic458_4_0 -u 0.005940518167070641 > ./result_10chains/node458_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_5_0 -p 550 -st none -pt topic458_5_0 -u 0.0008094580725592215 > ./result_10chains/node458_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_6_0 -p 750 -st none -pt topic458_6_0 -u 0.005565449113525356 > ./result_10chains/node458_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_7_0 -p 840 -st none -pt topic458_7_0 -u 0.01508412403193804 > ./result_10chains/node458_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node458_8_0 -p 854 -st none -pt topic458_8_0 -u 0.007748932360209057 > ./result_10chains/node458_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node458_9_0 -p 936 -st none -pt topic458_9_0 -u 0.0024593881120485023 > ./result_10chains/node458_9_0.txt &
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
    "./result_10chains/node458_0_0.txt 90"
    "./result_10chains/node458_0_2.txt 90"
    "./result_10chains/node458_1_0.txt 89"
    "./result_10chains/node458_1_2.txt 89"
    "./result_10chains/node458_2_0.txt 88"
    "./result_10chains/node458_2_2.txt 88"
    "./result_10chains/node458_3_0.txt 87"
    "./result_10chains/node458_3_2.txt 87"
    "./result_10chains/node458_4_0.txt 86"
    "./result_10chains/node458_4_2.txt 86"
    "./result_10chains/node458_5_0.txt 85"
    "./result_10chains/node458_5_2.txt 85"
    "./result_10chains/node458_6_0.txt 84"
    "./result_10chains/node458_6_2.txt 84"
    "./result_10chains/node458_7_0.txt 83"
    "./result_10chains/node458_7_2.txt 83"
    "./result_10chains/node458_8_0.txt 82"
    "./result_10chains/node458_8_2.txt 82"
    "./result_10chains/node458_9_0.txt 81"
    "./result_10chains/node458_9_2.txt 81"
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

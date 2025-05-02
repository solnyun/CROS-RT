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
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_2 -p 27 -st topic18_0_1 -pt None -u 0.0076588998408646525 > ./result_10chains/node18_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_2 -p 160 -st topic18_1_1 -pt None -u 0.032552776640669134 > ./result_10chains/node18_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_2 -p 174 -st topic18_2_1 -pt None -u 0.016516311438529274 > ./result_10chains/node18_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_2 -p 292 -st topic18_3_1 -pt None -u 0.013123449875589388 > ./result_10chains/node18_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_4_2 -p 366 -st topic18_4_1 -pt None -u 0.008464127192358173 > ./result_10chains/node18_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_5_2 -p 469 -st topic18_5_1 -pt None -u 0.0020763267059616675 > ./result_10chains/node18_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_6_2 -p 488 -st topic18_6_1 -pt None -u 0.026790432543094045 > ./result_10chains/node18_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_7_2 -p 601 -st topic18_7_1 -pt None -u 0.035542567070762573 > ./result_10chains/node18_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_8_2 -p 771 -st topic18_8_1 -pt None -u 0.022213317994275443 > ./result_10chains/node18_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_9_2 -p 940 -st topic18_9_1 -pt None -u 0.010487344211685748 > ./result_10chains/node18_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_0_0 -p 27 -st none -pt topic18_0_0 -u 0.0030176401193458546 > ./result_10chains/node18_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_1_0 -p 160 -st none -pt topic18_1_0 -u 0.009351616125958861 > ./result_10chains/node18_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_2_0 -p 174 -st none -pt topic18_2_0 -u 0.002939896033833156 > ./result_10chains/node18_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_3_0 -p 292 -st none -pt topic18_3_0 -u 0.02718423395737385 > ./result_10chains/node18_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_4_0 -p 366 -st none -pt topic18_4_0 -u 0.007166890497904532 > ./result_10chains/node18_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_5_0 -p 469 -st none -pt topic18_5_0 -u 0.029094137281379856 > ./result_10chains/node18_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_6_0 -p 488 -st none -pt topic18_6_0 -u 0.02371135359815829 > ./result_10chains/node18_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_7_0 -p 601 -st none -pt topic18_7_0 -u 0.03728138574965377 > ./result_10chains/node18_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node18_8_0 -p 771 -st none -pt topic18_8_0 -u 0.002336714131085438 > ./result_10chains/node18_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node18_9_0 -p 940 -st none -pt topic18_9_0 -u 0.001168230583953829 > ./result_10chains/node18_9_0.txt &
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
    "./result_10chains/node18_0_0.txt 90"
    "./result_10chains/node18_0_2.txt 90"
    "./result_10chains/node18_1_0.txt 89"
    "./result_10chains/node18_1_2.txt 89"
    "./result_10chains/node18_2_0.txt 88"
    "./result_10chains/node18_2_2.txt 88"
    "./result_10chains/node18_3_0.txt 87"
    "./result_10chains/node18_3_2.txt 87"
    "./result_10chains/node18_4_0.txt 86"
    "./result_10chains/node18_4_2.txt 86"
    "./result_10chains/node18_5_0.txt 85"
    "./result_10chains/node18_5_2.txt 85"
    "./result_10chains/node18_6_0.txt 84"
    "./result_10chains/node18_6_2.txt 84"
    "./result_10chains/node18_7_0.txt 83"
    "./result_10chains/node18_7_2.txt 83"
    "./result_10chains/node18_8_0.txt 82"
    "./result_10chains/node18_8_2.txt 82"
    "./result_10chains/node18_9_0.txt 81"
    "./result_10chains/node18_9_2.txt 81"
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

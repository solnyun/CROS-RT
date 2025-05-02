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
ros2 run evaluation_3_randomdag uunifast_node -n node384_0_2 -p 250 -st topic384_0_1 -pt None -u 0.026633772687424173 > ./result_8chains/node384_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_1_2 -p 368 -st topic384_1_1 -pt None -u 0.003971690212482559 > ./result_8chains/node384_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_2_2 -p 490 -st topic384_2_1 -pt None -u 0.029683981881484245 > ./result_8chains/node384_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_3_2 -p 603 -st topic384_3_1 -pt None -u 0.054732063639650885 > ./result_8chains/node384_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_4_2 -p 638 -st topic384_4_1 -pt None -u 0.003508362446556973 > ./result_8chains/node384_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_5_2 -p 680 -st topic384_5_1 -pt None -u 0.02360192244520326 > ./result_8chains/node384_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_6_2 -p 728 -st topic384_6_1 -pt None -u 0.018373495638031076 > ./result_8chains/node384_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_7_2 -p 941 -st topic384_7_1 -pt None -u 0.004426593341793792 > ./result_8chains/node384_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_0_0 -p 250 -st none -pt topic384_0_0 -u 0.011967059276718095 > ./result_8chains/node384_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_1_0 -p 368 -st none -pt topic384_1_0 -u 0.026871231586174604 > ./result_8chains/node384_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_2_0 -p 490 -st none -pt topic384_2_0 -u 0.0026888913985436136 > ./result_8chains/node384_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_3_0 -p 603 -st none -pt topic384_3_0 -u 0.011350431544752737 > ./result_8chains/node384_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_4_0 -p 638 -st none -pt topic384_4_0 -u 0.02752510640474473 > ./result_8chains/node384_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_5_0 -p 680 -st none -pt topic384_5_0 -u 0.0007018063587523327 > ./result_8chains/node384_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_6_0 -p 728 -st none -pt topic384_6_0 -u 0.04613458915311902 > ./result_8chains/node384_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_7_0 -p 941 -st none -pt topic384_7_0 -u 0.043271270248687654 > ./result_8chains/node384_7_0.txt &
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
    "./result_8chains/node384_0_0.txt 90"
    "./result_8chains/node384_0_2.txt 90"
    "./result_8chains/node384_1_0.txt 89"
    "./result_8chains/node384_1_2.txt 89"
    "./result_8chains/node384_2_0.txt 88"
    "./result_8chains/node384_2_2.txt 88"
    "./result_8chains/node384_3_0.txt 87"
    "./result_8chains/node384_3_2.txt 87"
    "./result_8chains/node384_4_0.txt 86"
    "./result_8chains/node384_4_2.txt 86"
    "./result_8chains/node384_5_0.txt 85"
    "./result_8chains/node384_5_2.txt 85"
    "./result_8chains/node384_6_0.txt 84"
    "./result_8chains/node384_6_2.txt 84"
    "./result_8chains/node384_7_0.txt 83"
    "./result_8chains/node384_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

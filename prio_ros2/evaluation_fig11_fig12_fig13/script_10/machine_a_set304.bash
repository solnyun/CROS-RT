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
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_2 -p 14 -st topic304_0_1 -pt None -u 0.003879182954733995 > ./result_10chains/node304_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_2 -p 37 -st topic304_1_1 -pt None -u 0.049802032742093216 > ./result_10chains/node304_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_2 -p 62 -st topic304_2_1 -pt None -u 0.0662669355472128 > ./result_10chains/node304_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_2 -p 178 -st topic304_3_1 -pt None -u 0.013607936236970292 > ./result_10chains/node304_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_2 -p 233 -st topic304_4_1 -pt None -u 0.05341807825134132 > ./result_10chains/node304_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_2 -p 332 -st topic304_5_1 -pt None -u 0.02077053265369995 > ./result_10chains/node304_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_6_2 -p 345 -st topic304_6_1 -pt None -u 0.013072589576928861 > ./result_10chains/node304_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_7_2 -p 570 -st topic304_7_1 -pt None -u 0.008829691829911557 > ./result_10chains/node304_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_8_2 -p 613 -st topic304_8_1 -pt None -u 0.006507699926740482 > ./result_10chains/node304_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_9_2 -p 646 -st topic304_9_1 -pt None -u 0.024940139013931585 > ./result_10chains/node304_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_0_0 -p 14 -st none -pt topic304_0_0 -u 0.03892569108095523 > ./result_10chains/node304_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_1_0 -p 37 -st none -pt topic304_1_0 -u 0.012738024197551934 > ./result_10chains/node304_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_2_0 -p 62 -st none -pt topic304_2_0 -u 0.01049406236880901 > ./result_10chains/node304_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_3_0 -p 178 -st none -pt topic304_3_0 -u 0.0018219718035862864 > ./result_10chains/node304_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_4_0 -p 233 -st none -pt topic304_4_0 -u 0.0039086822502185925 > ./result_10chains/node304_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_5_0 -p 332 -st none -pt topic304_5_0 -u 0.017182573781605842 > ./result_10chains/node304_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_6_0 -p 345 -st none -pt topic304_6_0 -u 0.0006519909339729874 > ./result_10chains/node304_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_7_0 -p 570 -st none -pt topic304_7_0 -u 0.0027173604334901624 > ./result_10chains/node304_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node304_8_0 -p 613 -st none -pt topic304_8_0 -u 0.006312406510949359 > ./result_10chains/node304_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node304_9_0 -p 646 -st none -pt topic304_9_0 -u 0.01740495373449831 > ./result_10chains/node304_9_0.txt &
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
    "./result_10chains/node304_0_0.txt 90"
    "./result_10chains/node304_0_2.txt 90"
    "./result_10chains/node304_1_0.txt 89"
    "./result_10chains/node304_1_2.txt 89"
    "./result_10chains/node304_2_0.txt 88"
    "./result_10chains/node304_2_2.txt 88"
    "./result_10chains/node304_3_0.txt 87"
    "./result_10chains/node304_3_2.txt 87"
    "./result_10chains/node304_4_0.txt 86"
    "./result_10chains/node304_4_2.txt 86"
    "./result_10chains/node304_5_0.txt 85"
    "./result_10chains/node304_5_2.txt 85"
    "./result_10chains/node304_6_0.txt 84"
    "./result_10chains/node304_6_2.txt 84"
    "./result_10chains/node304_7_0.txt 83"
    "./result_10chains/node304_7_2.txt 83"
    "./result_10chains/node304_8_0.txt 82"
    "./result_10chains/node304_8_2.txt 82"
    "./result_10chains/node304_9_0.txt 81"
    "./result_10chains/node304_9_2.txt 81"
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

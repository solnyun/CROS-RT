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
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_2 -p 83 -st topic153_0_1 -pt None -u 0.0005052270630550026 > ./result_10chains/node153_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_2 -p 252 -st topic153_1_1 -pt None -u 0.01819513193929312 > ./result_10chains/node153_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_2 -p 339 -st topic153_2_1 -pt None -u 0.007879217214913747 > ./result_10chains/node153_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_2 -p 399 -st topic153_3_1 -pt None -u 0.007340287954075153 > ./result_10chains/node153_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_2 -p 632 -st topic153_4_1 -pt None -u 0.024011722435718585 > ./result_10chains/node153_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_2 -p 670 -st topic153_5_1 -pt None -u 0.005756397230706339 > ./result_10chains/node153_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_6_2 -p 692 -st topic153_6_1 -pt None -u 4.032074821080922e-06 > ./result_10chains/node153_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_7_2 -p 742 -st topic153_7_1 -pt None -u 0.03214390248151679 > ./result_10chains/node153_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_8_2 -p 920 -st topic153_8_1 -pt None -u 0.03548609991882963 > ./result_10chains/node153_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_9_2 -p 999 -st topic153_9_1 -pt None -u 0.023380693361590203 > ./result_10chains/node153_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_0_0 -p 83 -st none -pt topic153_0_0 -u 0.028370481705392137 > ./result_10chains/node153_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_1_0 -p 252 -st none -pt topic153_1_0 -u 0.02256988621508621 > ./result_10chains/node153_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_2_0 -p 339 -st none -pt topic153_2_0 -u 0.007175548256723507 > ./result_10chains/node153_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_3_0 -p 399 -st none -pt topic153_3_0 -u 0.01698372400443321 > ./result_10chains/node153_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_4_0 -p 632 -st none -pt topic153_4_0 -u 0.03538928360437993 > ./result_10chains/node153_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_5_0 -p 670 -st none -pt topic153_5_0 -u 0.021109402778159925 > ./result_10chains/node153_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_6_0 -p 692 -st none -pt topic153_6_0 -u 0.04190084834771299 > ./result_10chains/node153_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_7_0 -p 742 -st none -pt topic153_7_0 -u 0.033421131319638614 > ./result_10chains/node153_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node153_8_0 -p 920 -st none -pt topic153_8_0 -u 0.04567043333583122 > ./result_10chains/node153_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node153_9_0 -p 999 -st none -pt topic153_9_0 -u 0.0005130121154066115 > ./result_10chains/node153_9_0.txt &
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
    "./result_10chains/node153_0_0.txt 90"
    "./result_10chains/node153_0_2.txt 90"
    "./result_10chains/node153_1_0.txt 89"
    "./result_10chains/node153_1_2.txt 89"
    "./result_10chains/node153_2_0.txt 88"
    "./result_10chains/node153_2_2.txt 88"
    "./result_10chains/node153_3_0.txt 87"
    "./result_10chains/node153_3_2.txt 87"
    "./result_10chains/node153_4_0.txt 86"
    "./result_10chains/node153_4_2.txt 86"
    "./result_10chains/node153_5_0.txt 85"
    "./result_10chains/node153_5_2.txt 85"
    "./result_10chains/node153_6_0.txt 84"
    "./result_10chains/node153_6_2.txt 84"
    "./result_10chains/node153_7_0.txt 83"
    "./result_10chains/node153_7_2.txt 83"
    "./result_10chains/node153_8_0.txt 82"
    "./result_10chains/node153_8_2.txt 82"
    "./result_10chains/node153_9_0.txt 81"
    "./result_10chains/node153_9_2.txt 81"
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

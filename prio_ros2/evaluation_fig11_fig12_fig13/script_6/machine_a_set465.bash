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
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_2 -p 60 -st topic465_0_1 -pt None -u 0.034993107836382764 > ./result_6chains/node465_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_2 -p 171 -st topic465_1_1 -pt None -u 0.03415019446305384 > ./result_6chains/node465_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_2 -p 287 -st topic465_2_1 -pt None -u 0.010885134857629292 > ./result_6chains/node465_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_2 -p 546 -st topic465_3_1 -pt None -u 0.013644653682746005 > ./result_6chains/node465_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_4_2 -p 688 -st topic465_4_1 -pt None -u 0.002753953116882521 > ./result_6chains/node465_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_5_2 -p 702 -st topic465_5_1 -pt None -u 0.00807274129843284 > ./result_6chains/node465_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_0_0 -p 60 -st none -pt topic465_0_0 -u 0.03963561839930707 > ./result_6chains/node465_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_1_0 -p 171 -st none -pt topic465_1_0 -u 0.005320632050559659 > ./result_6chains/node465_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_2_0 -p 287 -st none -pt topic465_2_0 -u 0.06743181700283851 > ./result_6chains/node465_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_3_0 -p 546 -st none -pt topic465_3_0 -u 0.024360251814067452 > ./result_6chains/node465_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node465_4_0 -p 688 -st none -pt topic465_4_0 -u 0.004770663099678579 > ./result_6chains/node465_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node465_5_0 -p 702 -st none -pt topic465_5_0 -u 0.07036043660602326 > ./result_6chains/node465_5_0.txt &
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
    "./result_6chains/node465_0_0.txt 90"
    "./result_6chains/node465_0_2.txt 90"
    "./result_6chains/node465_1_0.txt 89"
    "./result_6chains/node465_1_2.txt 89"
    "./result_6chains/node465_2_0.txt 88"
    "./result_6chains/node465_2_2.txt 88"
    "./result_6chains/node465_3_0.txt 87"
    "./result_6chains/node465_3_2.txt 87"
    "./result_6chains/node465_4_0.txt 86"
    "./result_6chains/node465_4_2.txt 86"
    "./result_6chains/node465_5_0.txt 85"
    "./result_6chains/node465_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

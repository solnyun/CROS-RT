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
ros2 run evaluation_3_randomdag uunifast_node -n node66_0_2 -p 78 -st topic66_0_1 -pt None -u 0.005468114100159294 > ./result_10chains/node66_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_1_2 -p 156 -st topic66_1_1 -pt None -u 0.018333499038832357 > ./result_10chains/node66_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_2_2 -p 215 -st topic66_2_1 -pt None -u 0.01900503747144927 > ./result_10chains/node66_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_3_2 -p 276 -st topic66_3_1 -pt None -u 0.02473546010582328 > ./result_10chains/node66_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_4_2 -p 301 -st topic66_4_1 -pt None -u 0.014316076408044998 > ./result_10chains/node66_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_5_2 -p 421 -st topic66_5_1 -pt None -u 0.0015005239685399463 > ./result_10chains/node66_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_6_2 -p 452 -st topic66_6_1 -pt None -u 0.019941777537976546 > ./result_10chains/node66_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_7_2 -p 588 -st topic66_7_1 -pt None -u 0.0050092744340432815 > ./result_10chains/node66_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_8_2 -p 882 -st topic66_8_1 -pt None -u 0.01744483039423672 > ./result_10chains/node66_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_9_2 -p 916 -st topic66_9_1 -pt None -u 0.030702124588024148 > ./result_10chains/node66_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_0_0 -p 78 -st none -pt topic66_0_0 -u 0.006653268751154018 > ./result_10chains/node66_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_1_0 -p 156 -st none -pt topic66_1_0 -u 0.003860210956078136 > ./result_10chains/node66_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_2_0 -p 215 -st none -pt topic66_2_0 -u 0.0028408453185745364 > ./result_10chains/node66_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_3_0 -p 276 -st none -pt topic66_3_0 -u 0.011543686853306367 > ./result_10chains/node66_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_4_0 -p 301 -st none -pt topic66_4_0 -u 0.021737082269384533 > ./result_10chains/node66_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_5_0 -p 421 -st none -pt topic66_5_0 -u 0.007362255065914924 > ./result_10chains/node66_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_6_0 -p 452 -st none -pt topic66_6_0 -u 0.015232130125649779 > ./result_10chains/node66_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_7_0 -p 588 -st none -pt topic66_7_0 -u 0.01408466198688621 > ./result_10chains/node66_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node66_8_0 -p 882 -st none -pt topic66_8_0 -u 0.043479366934624925 > ./result_10chains/node66_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node66_9_0 -p 916 -st none -pt topic66_9_0 -u 0.03563241635255464 > ./result_10chains/node66_9_0.txt &
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
    "./result_10chains/node66_0_0.txt 90"
    "./result_10chains/node66_0_2.txt 90"
    "./result_10chains/node66_1_0.txt 89"
    "./result_10chains/node66_1_2.txt 89"
    "./result_10chains/node66_2_0.txt 88"
    "./result_10chains/node66_2_2.txt 88"
    "./result_10chains/node66_3_0.txt 87"
    "./result_10chains/node66_3_2.txt 87"
    "./result_10chains/node66_4_0.txt 86"
    "./result_10chains/node66_4_2.txt 86"
    "./result_10chains/node66_5_0.txt 85"
    "./result_10chains/node66_5_2.txt 85"
    "./result_10chains/node66_6_0.txt 84"
    "./result_10chains/node66_6_2.txt 84"
    "./result_10chains/node66_7_0.txt 83"
    "./result_10chains/node66_7_2.txt 83"
    "./result_10chains/node66_8_0.txt 82"
    "./result_10chains/node66_8_2.txt 82"
    "./result_10chains/node66_9_0.txt 81"
    "./result_10chains/node66_9_2.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_2 -p 55 -st topic357_0_1 -pt None -u 0.006656241595646206 > ./result_10chains/node357_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_2 -p 76 -st topic357_1_1 -pt None -u 0.03139940028833199 > ./result_10chains/node357_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_2 -p 238 -st topic357_2_1 -pt None -u 0.015746914015799196 > ./result_10chains/node357_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_2 -p 500 -st topic357_3_1 -pt None -u 0.0027082862211749714 > ./result_10chains/node357_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_2 -p 561 -st topic357_4_1 -pt None -u 0.0040493506130611645 > ./result_10chains/node357_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_2 -p 724 -st topic357_5_1 -pt None -u 0.019446047109626413 > ./result_10chains/node357_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_6_2 -p 819 -st topic357_6_1 -pt None -u 0.009786779929980075 > ./result_10chains/node357_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_7_2 -p 829 -st topic357_7_1 -pt None -u 0.024053610626520457 > ./result_10chains/node357_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_8_2 -p 854 -st topic357_8_1 -pt None -u 0.003885167678571815 > ./result_10chains/node357_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_9_2 -p 860 -st topic357_9_1 -pt None -u 0.0002541647152727442 > ./result_10chains/node357_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_0_0 -p 55 -st none -pt topic357_0_0 -u 0.010124910957740374 > ./result_10chains/node357_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_1_0 -p 76 -st none -pt topic357_1_0 -u 0.007941962454775353 > ./result_10chains/node357_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_2_0 -p 238 -st none -pt topic357_2_0 -u 0.001538326279850788 > ./result_10chains/node357_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_3_0 -p 500 -st none -pt topic357_3_0 -u 0.024669744201382626 > ./result_10chains/node357_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_4_0 -p 561 -st none -pt topic357_4_0 -u 0.03286643275126139 > ./result_10chains/node357_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_5_0 -p 724 -st none -pt topic357_5_0 -u 0.000382104209725842 > ./result_10chains/node357_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_6_0 -p 819 -st none -pt topic357_6_0 -u 0.028914349467306644 > ./result_10chains/node357_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_7_0 -p 829 -st none -pt topic357_7_0 -u 0.0007423462895483346 > ./result_10chains/node357_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node357_8_0 -p 854 -st none -pt topic357_8_0 -u 0.005152641049859914 > ./result_10chains/node357_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node357_9_0 -p 860 -st none -pt topic357_9_0 -u 0.0003948079854850031 > ./result_10chains/node357_9_0.txt &
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
    "./result_10chains/node357_0_0.txt 90"
    "./result_10chains/node357_0_2.txt 90"
    "./result_10chains/node357_1_0.txt 89"
    "./result_10chains/node357_1_2.txt 89"
    "./result_10chains/node357_2_0.txt 88"
    "./result_10chains/node357_2_2.txt 88"
    "./result_10chains/node357_3_0.txt 87"
    "./result_10chains/node357_3_2.txt 87"
    "./result_10chains/node357_4_0.txt 86"
    "./result_10chains/node357_4_2.txt 86"
    "./result_10chains/node357_5_0.txt 85"
    "./result_10chains/node357_5_2.txt 85"
    "./result_10chains/node357_6_0.txt 84"
    "./result_10chains/node357_6_2.txt 84"
    "./result_10chains/node357_7_0.txt 83"
    "./result_10chains/node357_7_2.txt 83"
    "./result_10chains/node357_8_0.txt 82"
    "./result_10chains/node357_8_2.txt 82"
    "./result_10chains/node357_9_0.txt 81"
    "./result_10chains/node357_9_2.txt 81"
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

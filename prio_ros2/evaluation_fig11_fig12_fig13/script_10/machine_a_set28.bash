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
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_2 -p 32 -st topic28_0_1 -pt None -u 0.0006709260094396319 > ./result_10chains/node28_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_2 -p 406 -st topic28_1_1 -pt None -u 0.016843284138159276 > ./result_10chains/node28_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_2 -p 460 -st topic28_2_1 -pt None -u 0.006422828475070863 > ./result_10chains/node28_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_2 -p 502 -st topic28_3_1 -pt None -u 0.026547236028580723 > ./result_10chains/node28_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_2 -p 514 -st topic28_4_1 -pt None -u 0.003925469190638742 > ./result_10chains/node28_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_2 -p 518 -st topic28_5_1 -pt None -u 0.021540983381357126 > ./result_10chains/node28_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_6_2 -p 646 -st topic28_6_1 -pt None -u 0.0185537955784168 > ./result_10chains/node28_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_7_2 -p 813 -st topic28_7_1 -pt None -u 0.00902294047851783 > ./result_10chains/node28_7_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_8_2 -p 826 -st topic28_8_1 -pt None -u 0.0001453500647890238 > ./result_10chains/node28_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_9_2 -p 926 -st topic28_9_1 -pt None -u 0.010115467042448902 > ./result_10chains/node28_9_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_0_0 -p 32 -st none -pt topic28_0_0 -u 0.03404940557028979 > ./result_10chains/node28_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_1_0 -p 406 -st none -pt topic28_1_0 -u 0.01402251942219751 > ./result_10chains/node28_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_2_0 -p 460 -st none -pt topic28_2_0 -u 0.009850811441734164 > ./result_10chains/node28_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_3_0 -p 502 -st none -pt topic28_3_0 -u 0.004117427492177472 > ./result_10chains/node28_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_4_0 -p 514 -st none -pt topic28_4_0 -u 0.005457611209042534 > ./result_10chains/node28_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_5_0 -p 518 -st none -pt topic28_5_0 -u 0.05322578786970403 > ./result_10chains/node28_5_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_6_0 -p 646 -st none -pt topic28_6_0 -u 0.0013457052663767843 > ./result_10chains/node28_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_7_0 -p 813 -st none -pt topic28_7_0 -u 0.029879265988569284 > ./result_10chains/node28_7_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node28_8_0 -p 826 -st none -pt topic28_8_0 -u 0.0039066683298288885 > ./result_10chains/node28_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node28_9_0 -p 926 -st none -pt topic28_9_0 -u 0.014932386236924798 > ./result_10chains/node28_9_0.txt &
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
    "./result_10chains/node28_0_0.txt 90"
    "./result_10chains/node28_0_2.txt 90"
    "./result_10chains/node28_1_0.txt 89"
    "./result_10chains/node28_1_2.txt 89"
    "./result_10chains/node28_2_0.txt 88"
    "./result_10chains/node28_2_2.txt 88"
    "./result_10chains/node28_3_0.txt 87"
    "./result_10chains/node28_3_2.txt 87"
    "./result_10chains/node28_4_0.txt 86"
    "./result_10chains/node28_4_2.txt 86"
    "./result_10chains/node28_5_0.txt 85"
    "./result_10chains/node28_5_2.txt 85"
    "./result_10chains/node28_6_0.txt 84"
    "./result_10chains/node28_6_2.txt 84"
    "./result_10chains/node28_7_0.txt 83"
    "./result_10chains/node28_7_2.txt 83"
    "./result_10chains/node28_8_0.txt 82"
    "./result_10chains/node28_8_2.txt 82"
    "./result_10chains/node28_9_0.txt 81"
    "./result_10chains/node28_9_2.txt 81"
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

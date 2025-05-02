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
ros2 run evaluation_3_randomdag uunifast_node -n node485_0_2 -p 113 -st topic485_0_1 -pt None -u 0.022965910651927934 > ./result_10chains/node485_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_1_2 -p 187 -st topic485_1_1 -pt None -u 0.0948548116948959 > ./result_10chains/node485_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_2_2 -p 209 -st topic485_2_1 -pt None -u 0.03568026901801985 > ./result_10chains/node485_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_3_2 -p 234 -st topic485_3_1 -pt None -u 0.0005213855811879442 > ./result_10chains/node485_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_4_2 -p 362 -st topic485_4_1 -pt None -u 0.001534074068913427 > ./result_10chains/node485_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_5_2 -p 440 -st topic485_5_1 -pt None -u 0.0021538769208554742 > ./result_10chains/node485_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_6_2 -p 498 -st topic485_6_1 -pt None -u 0.005081357031820888 > ./result_10chains/node485_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_7_2 -p 531 -st topic485_7_1 -pt None -u 0.017422300684541356 > ./result_10chains/node485_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_8_2 -p 749 -st topic485_8_1 -pt None -u 0.00759786592405285 > ./result_10chains/node485_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_9_2 -p 808 -st topic485_9_1 -pt None -u 0.038691298381386824 > ./result_10chains/node485_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_0_0 -p 113 -st none -pt topic485_0_0 -u 0.00917499578527825 > ./result_10chains/node485_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_1_0 -p 187 -st none -pt topic485_1_0 -u 0.028674250984255967 > ./result_10chains/node485_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_2_0 -p 209 -st none -pt topic485_2_0 -u 0.021510126635649773 > ./result_10chains/node485_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_3_0 -p 234 -st none -pt topic485_3_0 -u 0.012181162995656192 > ./result_10chains/node485_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_4_0 -p 362 -st none -pt topic485_4_0 -u 0.0018456432822677171 > ./result_10chains/node485_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_5_0 -p 440 -st none -pt topic485_5_0 -u 0.0013216706073419515 > ./result_10chains/node485_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_6_0 -p 498 -st none -pt topic485_6_0 -u 0.032174848631141784 > ./result_10chains/node485_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_7_0 -p 531 -st none -pt topic485_7_0 -u 0.0012948067668188956 > ./result_10chains/node485_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node485_8_0 -p 749 -st none -pt topic485_8_0 -u 0.027362518090097133 > ./result_10chains/node485_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node485_9_0 -p 808 -st none -pt topic485_9_0 -u 0.0023474268009670216 > ./result_10chains/node485_9_0.txt &
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
    "./result_10chains/node485_0_0.txt 90"
    "./result_10chains/node485_0_2.txt 90"
    "./result_10chains/node485_1_0.txt 89"
    "./result_10chains/node485_1_2.txt 89"
    "./result_10chains/node485_2_0.txt 88"
    "./result_10chains/node485_2_2.txt 88"
    "./result_10chains/node485_3_0.txt 87"
    "./result_10chains/node485_3_2.txt 87"
    "./result_10chains/node485_4_0.txt 86"
    "./result_10chains/node485_4_2.txt 86"
    "./result_10chains/node485_5_0.txt 85"
    "./result_10chains/node485_5_2.txt 85"
    "./result_10chains/node485_6_0.txt 84"
    "./result_10chains/node485_6_2.txt 84"
    "./result_10chains/node485_7_0.txt 83"
    "./result_10chains/node485_7_2.txt 83"
    "./result_10chains/node485_8_0.txt 82"
    "./result_10chains/node485_8_2.txt 82"
    "./result_10chains/node485_9_0.txt 81"
    "./result_10chains/node485_9_2.txt 81"
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

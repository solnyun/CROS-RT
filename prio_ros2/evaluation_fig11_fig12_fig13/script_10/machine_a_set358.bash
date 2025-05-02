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
ros2 run evaluation_3_randomdag uunifast_node -n node358_0_2 -p 211 -st topic358_0_1 -pt None -u 0.003349272322990704 > ./result_10chains/node358_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_1_2 -p 230 -st topic358_1_1 -pt None -u 0.05914122241625197 > ./result_10chains/node358_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_2_2 -p 300 -st topic358_2_1 -pt None -u 0.035536220508519956 > ./result_10chains/node358_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_3_2 -p 317 -st topic358_3_1 -pt None -u 0.012951128283430424 > ./result_10chains/node358_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_4_2 -p 378 -st topic358_4_1 -pt None -u 0.007648411477334693 > ./result_10chains/node358_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_5_2 -p 458 -st topic358_5_1 -pt None -u 0.014994437046534623 > ./result_10chains/node358_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_6_2 -p 530 -st topic358_6_1 -pt None -u 0.0028201969021106332 > ./result_10chains/node358_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_7_2 -p 707 -st topic358_7_1 -pt None -u 0.0036457810683135916 > ./result_10chains/node358_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_8_2 -p 816 -st topic358_8_1 -pt None -u 0.035200995320371783 > ./result_10chains/node358_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_9_2 -p 908 -st topic358_9_1 -pt None -u 0.00758322207298805 > ./result_10chains/node358_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_0_0 -p 211 -st none -pt topic358_0_0 -u 0.00888907008747769 > ./result_10chains/node358_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_1_0 -p 230 -st none -pt topic358_1_0 -u 0.010022090845427045 > ./result_10chains/node358_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_2_0 -p 300 -st none -pt topic358_2_0 -u 0.002512307654681134 > ./result_10chains/node358_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_3_0 -p 317 -st none -pt topic358_3_0 -u 0.04010322417438844 > ./result_10chains/node358_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_4_0 -p 378 -st none -pt topic358_4_0 -u 0.047119447000401216 > ./result_10chains/node358_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_5_0 -p 458 -st none -pt topic358_5_0 -u 0.0030663450648230894 > ./result_10chains/node358_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_6_0 -p 530 -st none -pt topic358_6_0 -u 0.002204754103746681 > ./result_10chains/node358_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_7_0 -p 707 -st none -pt topic358_7_0 -u 0.008023315746421747 > ./result_10chains/node358_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node358_8_0 -p 816 -st none -pt topic358_8_0 -u 0.005690928910854633 > ./result_10chains/node358_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node358_9_0 -p 908 -st none -pt topic358_9_0 -u 0.003980753605002267 > ./result_10chains/node358_9_0.txt &
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
    "./result_10chains/node358_0_0.txt 90"
    "./result_10chains/node358_0_2.txt 90"
    "./result_10chains/node358_1_0.txt 89"
    "./result_10chains/node358_1_2.txt 89"
    "./result_10chains/node358_2_0.txt 88"
    "./result_10chains/node358_2_2.txt 88"
    "./result_10chains/node358_3_0.txt 87"
    "./result_10chains/node358_3_2.txt 87"
    "./result_10chains/node358_4_0.txt 86"
    "./result_10chains/node358_4_2.txt 86"
    "./result_10chains/node358_5_0.txt 85"
    "./result_10chains/node358_5_2.txt 85"
    "./result_10chains/node358_6_0.txt 84"
    "./result_10chains/node358_6_2.txt 84"
    "./result_10chains/node358_7_0.txt 83"
    "./result_10chains/node358_7_2.txt 83"
    "./result_10chains/node358_8_0.txt 82"
    "./result_10chains/node358_8_2.txt 82"
    "./result_10chains/node358_9_0.txt 81"
    "./result_10chains/node358_9_2.txt 81"
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

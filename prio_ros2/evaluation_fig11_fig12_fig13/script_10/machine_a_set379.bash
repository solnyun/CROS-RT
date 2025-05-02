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
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_2 -p 18 -st topic379_0_1 -pt None -u 0.00019698352789782048 > ./result_10chains/node379_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_2 -p 134 -st topic379_1_1 -pt None -u 0.0003315336611803277 > ./result_10chains/node379_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_2 -p 228 -st topic379_2_1 -pt None -u 0.052212415548715974 > ./result_10chains/node379_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_2 -p 475 -st topic379_3_1 -pt None -u 0.018644989106080145 > ./result_10chains/node379_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_2 -p 502 -st topic379_4_1 -pt None -u 0.008195219759645489 > ./result_10chains/node379_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_2 -p 632 -st topic379_5_1 -pt None -u 0.034510388027726685 > ./result_10chains/node379_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_6_2 -p 714 -st topic379_6_1 -pt None -u 0.015081788098645826 > ./result_10chains/node379_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_7_2 -p 774 -st topic379_7_1 -pt None -u 0.035138541895897185 > ./result_10chains/node379_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_8_2 -p 838 -st topic379_8_1 -pt None -u 0.019246481096699124 > ./result_10chains/node379_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_9_2 -p 897 -st topic379_9_1 -pt None -u 0.008263603639704626 > ./result_10chains/node379_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_0_0 -p 18 -st none -pt topic379_0_0 -u 0.00872212887264917 > ./result_10chains/node379_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_1_0 -p 134 -st none -pt topic379_1_0 -u 0.005035660079542592 > ./result_10chains/node379_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_2_0 -p 228 -st none -pt topic379_2_0 -u 0.017181484468672348 > ./result_10chains/node379_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_3_0 -p 475 -st none -pt topic379_3_0 -u 0.021274119016977122 > ./result_10chains/node379_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_4_0 -p 502 -st none -pt topic379_4_0 -u 0.004746611624985297 > ./result_10chains/node379_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_5_0 -p 632 -st none -pt topic379_5_0 -u 0.01323104711490447 > ./result_10chains/node379_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_6_0 -p 714 -st none -pt topic379_6_0 -u 0.0023841069887298727 > ./result_10chains/node379_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_7_0 -p 774 -st none -pt topic379_7_0 -u 0.0008456651652219427 > ./result_10chains/node379_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node379_8_0 -p 838 -st none -pt topic379_8_0 -u 0.02586147135885017 > ./result_10chains/node379_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node379_9_0 -p 897 -st none -pt topic379_9_0 -u 0.018374818550142884 > ./result_10chains/node379_9_0.txt &
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
    "./result_10chains/node379_0_0.txt 90"
    "./result_10chains/node379_0_2.txt 90"
    "./result_10chains/node379_1_0.txt 89"
    "./result_10chains/node379_1_2.txt 89"
    "./result_10chains/node379_2_0.txt 88"
    "./result_10chains/node379_2_2.txt 88"
    "./result_10chains/node379_3_0.txt 87"
    "./result_10chains/node379_3_2.txt 87"
    "./result_10chains/node379_4_0.txt 86"
    "./result_10chains/node379_4_2.txt 86"
    "./result_10chains/node379_5_0.txt 85"
    "./result_10chains/node379_5_2.txt 85"
    "./result_10chains/node379_6_0.txt 84"
    "./result_10chains/node379_6_2.txt 84"
    "./result_10chains/node379_7_0.txt 83"
    "./result_10chains/node379_7_2.txt 83"
    "./result_10chains/node379_8_0.txt 82"
    "./result_10chains/node379_8_2.txt 82"
    "./result_10chains/node379_9_0.txt 81"
    "./result_10chains/node379_9_2.txt 81"
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

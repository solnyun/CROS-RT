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
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_2 -p 60 -st topic123_0_1 -pt None -u 0.01044817860817221 > ./result_10chains/node123_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_2 -p 79 -st topic123_1_1 -pt None -u 0.03268395502156268 > ./result_10chains/node123_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_2 -p 167 -st topic123_2_1 -pt None -u 0.011543147619547112 > ./result_10chains/node123_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_2 -p 448 -st topic123_3_1 -pt None -u 0.02151833176575041 > ./result_10chains/node123_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_2 -p 490 -st topic123_4_1 -pt None -u 0.031437788379521076 > ./result_10chains/node123_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_2 -p 708 -st topic123_5_1 -pt None -u 0.0019370879710137734 > ./result_10chains/node123_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_6_2 -p 834 -st topic123_6_1 -pt None -u 0.008032868948204569 > ./result_10chains/node123_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_7_2 -p 883 -st topic123_7_1 -pt None -u 0.0019376556021746538 > ./result_10chains/node123_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_8_2 -p 893 -st topic123_8_1 -pt None -u 0.006311351682698585 > ./result_10chains/node123_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_9_2 -p 941 -st topic123_9_1 -pt None -u 0.023655353943703012 > ./result_10chains/node123_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_0 -p 60 -st none -pt topic123_0_0 -u 0.012472689125498926 > ./result_10chains/node123_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_0 -p 79 -st none -pt topic123_1_0 -u 0.00020371553889680927 > ./result_10chains/node123_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_0 -p 167 -st none -pt topic123_2_0 -u 0.004097723170606471 > ./result_10chains/node123_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_0 -p 448 -st none -pt topic123_3_0 -u 0.09722711227405051 > ./result_10chains/node123_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_0 -p 490 -st none -pt topic123_4_0 -u 0.0006689275038067044 > ./result_10chains/node123_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_0 -p 708 -st none -pt topic123_5_0 -u 0.013854173235340328 > ./result_10chains/node123_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_6_0 -p 834 -st none -pt topic123_6_0 -u 0.0027486299097356226 > ./result_10chains/node123_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_7_0 -p 883 -st none -pt topic123_7_0 -u 0.033129396172951464 > ./result_10chains/node123_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_8_0 -p 893 -st none -pt topic123_8_0 -u 0.008738658138316896 > ./result_10chains/node123_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_9_0 -p 941 -st none -pt topic123_9_0 -u 0.00020461030470863423 > ./result_10chains/node123_9_0.txt &
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
    "./result_10chains/node123_0_0.txt 90"
    "./result_10chains/node123_0_2.txt 90"
    "./result_10chains/node123_1_0.txt 89"
    "./result_10chains/node123_1_2.txt 89"
    "./result_10chains/node123_2_0.txt 88"
    "./result_10chains/node123_2_2.txt 88"
    "./result_10chains/node123_3_0.txt 87"
    "./result_10chains/node123_3_2.txt 87"
    "./result_10chains/node123_4_0.txt 86"
    "./result_10chains/node123_4_2.txt 86"
    "./result_10chains/node123_5_0.txt 85"
    "./result_10chains/node123_5_2.txt 85"
    "./result_10chains/node123_6_0.txt 84"
    "./result_10chains/node123_6_2.txt 84"
    "./result_10chains/node123_7_0.txt 83"
    "./result_10chains/node123_7_2.txt 83"
    "./result_10chains/node123_8_0.txt 82"
    "./result_10chains/node123_8_2.txt 82"
    "./result_10chains/node123_9_0.txt 81"
    "./result_10chains/node123_9_2.txt 81"
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

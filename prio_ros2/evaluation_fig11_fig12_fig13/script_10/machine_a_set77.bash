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
ros2 run evaluation_3_randomdag uunifast_node -n node77_0_2 -p 74 -st topic77_0_1 -pt None -u 0.0004468650618052461 > ./result_10chains/node77_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_1_2 -p 359 -st topic77_1_1 -pt None -u 0.01828924737012827 > ./result_10chains/node77_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_2_2 -p 456 -st topic77_2_1 -pt None -u 0.009477467845786347 > ./result_10chains/node77_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_3_2 -p 487 -st topic77_3_1 -pt None -u 0.01994513691201133 > ./result_10chains/node77_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_4_2 -p 547 -st topic77_4_1 -pt None -u 0.0025236704829778023 > ./result_10chains/node77_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_5_2 -p 576 -st topic77_5_1 -pt None -u 0.005761583548345134 > ./result_10chains/node77_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_6_2 -p 662 -st topic77_6_1 -pt None -u 0.021805797397217358 > ./result_10chains/node77_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_7_2 -p 682 -st topic77_7_1 -pt None -u 0.0030364270932494997 > ./result_10chains/node77_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_8_2 -p 723 -st topic77_8_1 -pt None -u 0.029591511446522403 > ./result_10chains/node77_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_9_2 -p 884 -st topic77_9_1 -pt None -u 0.014803864780090617 > ./result_10chains/node77_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_0_0 -p 74 -st none -pt topic77_0_0 -u 0.00316552636314571 > ./result_10chains/node77_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_1_0 -p 359 -st none -pt topic77_1_0 -u 0.008578296693744991 > ./result_10chains/node77_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_2_0 -p 456 -st none -pt topic77_2_0 -u 0.002530763038721795 > ./result_10chains/node77_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_3_0 -p 487 -st none -pt topic77_3_0 -u 0.02870085982782966 > ./result_10chains/node77_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_4_0 -p 547 -st none -pt topic77_4_0 -u 0.029242037293337964 > ./result_10chains/node77_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_5_0 -p 576 -st none -pt topic77_5_0 -u 0.0010845218905580212 > ./result_10chains/node77_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_6_0 -p 662 -st none -pt topic77_6_0 -u 0.037842523271156725 > ./result_10chains/node77_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_7_0 -p 682 -st none -pt topic77_7_0 -u 0.0024365737248617236 > ./result_10chains/node77_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node77_8_0 -p 723 -st none -pt topic77_8_0 -u 0.04745902464322274 > ./result_10chains/node77_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node77_9_0 -p 884 -st none -pt topic77_9_0 -u 0.0171782490370309 > ./result_10chains/node77_9_0.txt &
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
    "./result_10chains/node77_0_0.txt 90"
    "./result_10chains/node77_0_2.txt 90"
    "./result_10chains/node77_1_0.txt 89"
    "./result_10chains/node77_1_2.txt 89"
    "./result_10chains/node77_2_0.txt 88"
    "./result_10chains/node77_2_2.txt 88"
    "./result_10chains/node77_3_0.txt 87"
    "./result_10chains/node77_3_2.txt 87"
    "./result_10chains/node77_4_0.txt 86"
    "./result_10chains/node77_4_2.txt 86"
    "./result_10chains/node77_5_0.txt 85"
    "./result_10chains/node77_5_2.txt 85"
    "./result_10chains/node77_6_0.txt 84"
    "./result_10chains/node77_6_2.txt 84"
    "./result_10chains/node77_7_0.txt 83"
    "./result_10chains/node77_7_2.txt 83"
    "./result_10chains/node77_8_0.txt 82"
    "./result_10chains/node77_8_2.txt 82"
    "./result_10chains/node77_9_0.txt 81"
    "./result_10chains/node77_9_2.txt 81"
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

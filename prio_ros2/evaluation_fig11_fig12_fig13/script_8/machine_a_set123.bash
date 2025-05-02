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
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_2 -p 13 -st topic123_0_1 -pt None -u 0.03464443960244834 > ./result_8chains/node123_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_2 -p 260 -st topic123_1_1 -pt None -u 0.015591497489252204 > ./result_8chains/node123_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_2 -p 302 -st topic123_2_1 -pt None -u 0.0018353980207752862 > ./result_8chains/node123_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_2 -p 380 -st topic123_3_1 -pt None -u 0.016797485966741965 > ./result_8chains/node123_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_2 -p 527 -st topic123_4_1 -pt None -u 0.01250774429590279 > ./result_8chains/node123_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_2 -p 635 -st topic123_5_1 -pt None -u 0.012189227783034051 > ./result_8chains/node123_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_6_2 -p 920 -st topic123_6_1 -pt None -u 0.022688337163810073 > ./result_8chains/node123_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_7_2 -p 926 -st topic123_7_1 -pt None -u 0.022859075074784626 > ./result_8chains/node123_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_0_0 -p 13 -st none -pt topic123_0_0 -u 0.05890366287785298 > ./result_8chains/node123_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_1_0 -p 260 -st none -pt topic123_1_0 -u 0.045208642546280264 > ./result_8chains/node123_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_2_0 -p 302 -st none -pt topic123_2_0 -u 0.04215067398849193 > ./result_8chains/node123_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_3_0 -p 380 -st none -pt topic123_3_0 -u 0.0015061361806953943 > ./result_8chains/node123_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_4_0 -p 527 -st none -pt topic123_4_0 -u 0.02972339141126165 > ./result_8chains/node123_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_5_0 -p 635 -st none -pt topic123_5_0 -u 0.008254072563093129 > ./result_8chains/node123_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node123_6_0 -p 920 -st none -pt topic123_6_0 -u 0.012508430716053273 > ./result_8chains/node123_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node123_7_0 -p 926 -st none -pt topic123_7_0 -u 0.006436324185917247 > ./result_8chains/node123_7_0.txt &
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
    "./result_8chains/node123_0_0.txt 90"
    "./result_8chains/node123_0_2.txt 90"
    "./result_8chains/node123_1_0.txt 89"
    "./result_8chains/node123_1_2.txt 89"
    "./result_8chains/node123_2_0.txt 88"
    "./result_8chains/node123_2_2.txt 88"
    "./result_8chains/node123_3_0.txt 87"
    "./result_8chains/node123_3_2.txt 87"
    "./result_8chains/node123_4_0.txt 86"
    "./result_8chains/node123_4_2.txt 86"
    "./result_8chains/node123_5_0.txt 85"
    "./result_8chains/node123_5_2.txt 85"
    "./result_8chains/node123_6_0.txt 84"
    "./result_8chains/node123_6_2.txt 84"
    "./result_8chains/node123_7_0.txt 83"
    "./result_8chains/node123_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

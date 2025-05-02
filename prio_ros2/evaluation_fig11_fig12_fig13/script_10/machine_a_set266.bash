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
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_2 -p 25 -st topic266_0_1 -pt None -u 0.0028912465476407245 > ./result_10chains/node266_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_2 -p 394 -st topic266_1_1 -pt None -u 0.0014472931863599992 > ./result_10chains/node266_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_2 -p 532 -st topic266_2_1 -pt None -u 0.0013823897624269943 > ./result_10chains/node266_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_2 -p 601 -st topic266_3_1 -pt None -u 0.019658396038209847 > ./result_10chains/node266_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_2 -p 616 -st topic266_4_1 -pt None -u 0.025234573812431438 > ./result_10chains/node266_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_2 -p 683 -st topic266_5_1 -pt None -u 0.0026287040858730126 > ./result_10chains/node266_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_6_2 -p 761 -st topic266_6_1 -pt None -u 0.001994975171868571 > ./result_10chains/node266_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_7_2 -p 886 -st topic266_7_1 -pt None -u 0.015066193541712417 > ./result_10chains/node266_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_8_2 -p 942 -st topic266_8_1 -pt None -u 0.019412004456250742 > ./result_10chains/node266_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_9_2 -p 968 -st topic266_9_1 -pt None -u 0.0008317607199995676 > ./result_10chains/node266_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_0_0 -p 25 -st none -pt topic266_0_0 -u 0.014714454010248124 > ./result_10chains/node266_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_1_0 -p 394 -st none -pt topic266_1_0 -u 0.07719002408342807 > ./result_10chains/node266_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_2_0 -p 532 -st none -pt topic266_2_0 -u 0.005498822466238507 > ./result_10chains/node266_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_3_0 -p 601 -st none -pt topic266_3_0 -u 0.012394255825169453 > ./result_10chains/node266_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_4_0 -p 616 -st none -pt topic266_4_0 -u 0.0058532285142096074 > ./result_10chains/node266_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_5_0 -p 683 -st none -pt topic266_5_0 -u 0.005161887553553901 > ./result_10chains/node266_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_6_0 -p 761 -st none -pt topic266_6_0 -u 0.03510401285278303 > ./result_10chains/node266_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_7_0 -p 886 -st none -pt topic266_7_0 -u 0.012668883659540761 > ./result_10chains/node266_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node266_8_0 -p 942 -st none -pt topic266_8_0 -u 0.018936606387431866 > ./result_10chains/node266_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node266_9_0 -p 968 -st none -pt topic266_9_0 -u 0.0016466763603669998 > ./result_10chains/node266_9_0.txt &
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
    "./result_10chains/node266_0_0.txt 90"
    "./result_10chains/node266_0_2.txt 90"
    "./result_10chains/node266_1_0.txt 89"
    "./result_10chains/node266_1_2.txt 89"
    "./result_10chains/node266_2_0.txt 88"
    "./result_10chains/node266_2_2.txt 88"
    "./result_10chains/node266_3_0.txt 87"
    "./result_10chains/node266_3_2.txt 87"
    "./result_10chains/node266_4_0.txt 86"
    "./result_10chains/node266_4_2.txt 86"
    "./result_10chains/node266_5_0.txt 85"
    "./result_10chains/node266_5_2.txt 85"
    "./result_10chains/node266_6_0.txt 84"
    "./result_10chains/node266_6_2.txt 84"
    "./result_10chains/node266_7_0.txt 83"
    "./result_10chains/node266_7_2.txt 83"
    "./result_10chains/node266_8_0.txt 82"
    "./result_10chains/node266_8_2.txt 82"
    "./result_10chains/node266_9_0.txt 81"
    "./result_10chains/node266_9_2.txt 81"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_2 -p 183 -st topic67_0_1 -pt None -u 0.025367815058078336 > ./result_8chains/node67_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_2 -p 306 -st topic67_1_1 -pt None -u 0.01832835382108794 > ./result_8chains/node67_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_2 -p 337 -st topic67_2_1 -pt None -u 0.03414107557977969 > ./result_8chains/node67_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_2 -p 566 -st topic67_3_1 -pt None -u 0.01742198559355765 > ./result_8chains/node67_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_2 -p 570 -st topic67_4_1 -pt None -u 0.0012484131007053922 > ./result_8chains/node67_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_2 -p 593 -st topic67_5_1 -pt None -u 0.008548466284086259 > ./result_8chains/node67_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_6_2 -p 870 -st topic67_6_1 -pt None -u 0.11820064505497388 > ./result_8chains/node67_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_7_2 -p 975 -st topic67_7_1 -pt None -u 0.014523847046275164 > ./result_8chains/node67_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_0_0 -p 183 -st none -pt topic67_0_0 -u 0.019664472945405687 > ./result_8chains/node67_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_1_0 -p 306 -st none -pt topic67_1_0 -u 0.015322812163546362 > ./result_8chains/node67_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_2_0 -p 337 -st none -pt topic67_2_0 -u 0.049200828140893715 > ./result_8chains/node67_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_3_0 -p 566 -st none -pt topic67_3_0 -u 0.007888310223998996 > ./result_8chains/node67_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_4_0 -p 570 -st none -pt topic67_4_0 -u 0.003395785161914716 > ./result_8chains/node67_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_5_0 -p 593 -st none -pt topic67_5_0 -u 0.000409226022578979 > ./result_8chains/node67_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node67_6_0 -p 870 -st none -pt topic67_6_0 -u 0.003771407805238547 > ./result_8chains/node67_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node67_7_0 -p 975 -st none -pt topic67_7_0 -u 0.026264720471663693 > ./result_8chains/node67_7_0.txt &
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
    "./result_8chains/node67_0_0.txt 90"
    "./result_8chains/node67_0_2.txt 90"
    "./result_8chains/node67_1_0.txt 89"
    "./result_8chains/node67_1_2.txt 89"
    "./result_8chains/node67_2_0.txt 88"
    "./result_8chains/node67_2_2.txt 88"
    "./result_8chains/node67_3_0.txt 87"
    "./result_8chains/node67_3_2.txt 87"
    "./result_8chains/node67_4_0.txt 86"
    "./result_8chains/node67_4_2.txt 86"
    "./result_8chains/node67_5_0.txt 85"
    "./result_8chains/node67_5_2.txt 85"
    "./result_8chains/node67_6_0.txt 84"
    "./result_8chains/node67_6_2.txt 84"
    "./result_8chains/node67_7_0.txt 83"
    "./result_8chains/node67_7_2.txt 83"
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

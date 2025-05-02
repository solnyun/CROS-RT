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
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_2 -p 221 -st topic498_0_1 -pt None -u 0.008251163496197589 > ./result_10chains/node498_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_2 -p 280 -st topic498_1_1 -pt None -u 0.05285312707941514 > ./result_10chains/node498_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_2 -p 334 -st topic498_2_1 -pt None -u 0.022791232751590618 > ./result_10chains/node498_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_2 -p 454 -st topic498_3_1 -pt None -u 0.0005319821131556934 > ./result_10chains/node498_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_2 -p 652 -st topic498_4_1 -pt None -u 0.008506020254609614 > ./result_10chains/node498_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_2 -p 672 -st topic498_5_1 -pt None -u 0.003839804044698053 > ./result_10chains/node498_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_6_2 -p 755 -st topic498_6_1 -pt None -u 0.0002781991815548335 > ./result_10chains/node498_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_7_2 -p 819 -st topic498_7_1 -pt None -u 0.027956416618904967 > ./result_10chains/node498_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_8_2 -p 867 -st topic498_8_1 -pt None -u 0.004430103336305745 > ./result_10chains/node498_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_9_2 -p 972 -st topic498_9_1 -pt None -u 0.0023048352580011798 > ./result_10chains/node498_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_0_0 -p 221 -st none -pt topic498_0_0 -u 0.006425152971839876 > ./result_10chains/node498_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_1_0 -p 280 -st none -pt topic498_1_0 -u 0.04543719498700799 > ./result_10chains/node498_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_2_0 -p 334 -st none -pt topic498_2_0 -u 0.0002386590174199843 > ./result_10chains/node498_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_3_0 -p 454 -st none -pt topic498_3_0 -u 0.0090878741457881 > ./result_10chains/node498_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_4_0 -p 652 -st none -pt topic498_4_0 -u 0.032900747062921426 > ./result_10chains/node498_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_5_0 -p 672 -st none -pt topic498_5_0 -u 0.022168081860505395 > ./result_10chains/node498_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_6_0 -p 755 -st none -pt topic498_6_0 -u 0.018371847825563697 > ./result_10chains/node498_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_7_0 -p 819 -st none -pt topic498_7_0 -u 0.03470426758399761 > ./result_10chains/node498_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node498_8_0 -p 867 -st none -pt topic498_8_0 -u 0.010948730181522426 > ./result_10chains/node498_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node498_9_0 -p 972 -st none -pt topic498_9_0 -u 0.016194719497747416 > ./result_10chains/node498_9_0.txt &
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
    "./result_10chains/node498_0_0.txt 90"
    "./result_10chains/node498_0_2.txt 90"
    "./result_10chains/node498_1_0.txt 89"
    "./result_10chains/node498_1_2.txt 89"
    "./result_10chains/node498_2_0.txt 88"
    "./result_10chains/node498_2_2.txt 88"
    "./result_10chains/node498_3_0.txt 87"
    "./result_10chains/node498_3_2.txt 87"
    "./result_10chains/node498_4_0.txt 86"
    "./result_10chains/node498_4_2.txt 86"
    "./result_10chains/node498_5_0.txt 85"
    "./result_10chains/node498_5_2.txt 85"
    "./result_10chains/node498_6_0.txt 84"
    "./result_10chains/node498_6_2.txt 84"
    "./result_10chains/node498_7_0.txt 83"
    "./result_10chains/node498_7_2.txt 83"
    "./result_10chains/node498_8_0.txt 82"
    "./result_10chains/node498_8_2.txt 82"
    "./result_10chains/node498_9_0.txt 81"
    "./result_10chains/node498_9_2.txt 81"
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

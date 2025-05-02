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
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_2 -p 82 -st topic321_0_1 -pt None -u 0.004740576184866174 > ./result_10chains/node321_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_2 -p 355 -st topic321_1_1 -pt None -u 0.008102449994666194 > ./result_10chains/node321_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_2 -p 395 -st topic321_2_1 -pt None -u 0.004329756731881518 > ./result_10chains/node321_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_2 -p 473 -st topic321_3_1 -pt None -u 0.0030654214725882034 > ./result_10chains/node321_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_2 -p 527 -st topic321_4_1 -pt None -u 0.0226185899361408 > ./result_10chains/node321_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_2 -p 587 -st topic321_5_1 -pt None -u 0.008877201104498245 > ./result_10chains/node321_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_6_2 -p 596 -st topic321_6_1 -pt None -u 0.06484345756468671 > ./result_10chains/node321_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_7_2 -p 701 -st topic321_7_1 -pt None -u 0.012954874193801147 > ./result_10chains/node321_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_8_2 -p 961 -st topic321_8_1 -pt None -u 0.03247243726546911 > ./result_10chains/node321_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_9_2 -p 993 -st topic321_9_1 -pt None -u 0.030589550591977068 > ./result_10chains/node321_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_0_0 -p 82 -st none -pt topic321_0_0 -u 0.003607809726158817 > ./result_10chains/node321_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_1_0 -p 355 -st none -pt topic321_1_0 -u 0.02152855569254236 > ./result_10chains/node321_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_2_0 -p 395 -st none -pt topic321_2_0 -u 0.000714082069947608 > ./result_10chains/node321_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_3_0 -p 473 -st none -pt topic321_3_0 -u 0.03907677193706244 > ./result_10chains/node321_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_4_0 -p 527 -st none -pt topic321_4_0 -u 0.0033721053441834736 > ./result_10chains/node321_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_5_0 -p 587 -st none -pt topic321_5_0 -u 0.005357729252977728 > ./result_10chains/node321_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_6_0 -p 596 -st none -pt topic321_6_0 -u 0.010123989060422833 > ./result_10chains/node321_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_7_0 -p 701 -st none -pt topic321_7_0 -u 0.004724965705399736 > ./result_10chains/node321_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node321_8_0 -p 961 -st none -pt topic321_8_0 -u 0.0004404582450130978 > ./result_10chains/node321_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node321_9_0 -p 993 -st none -pt topic321_9_0 -u 0.0790495185916139 > ./result_10chains/node321_9_0.txt &
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
    "./result_10chains/node321_0_0.txt 90"
    "./result_10chains/node321_0_2.txt 90"
    "./result_10chains/node321_1_0.txt 89"
    "./result_10chains/node321_1_2.txt 89"
    "./result_10chains/node321_2_0.txt 88"
    "./result_10chains/node321_2_2.txt 88"
    "./result_10chains/node321_3_0.txt 87"
    "./result_10chains/node321_3_2.txt 87"
    "./result_10chains/node321_4_0.txt 86"
    "./result_10chains/node321_4_2.txt 86"
    "./result_10chains/node321_5_0.txt 85"
    "./result_10chains/node321_5_2.txt 85"
    "./result_10chains/node321_6_0.txt 84"
    "./result_10chains/node321_6_2.txt 84"
    "./result_10chains/node321_7_0.txt 83"
    "./result_10chains/node321_7_2.txt 83"
    "./result_10chains/node321_8_0.txt 82"
    "./result_10chains/node321_8_2.txt 82"
    "./result_10chains/node321_9_0.txt 81"
    "./result_10chains/node321_9_2.txt 81"
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

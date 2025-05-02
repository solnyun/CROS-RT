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
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_2 -p 109 -st topic312_0_1 -pt None -u 0.018175559579509615 > ./result_8chains/node312_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_2 -p 180 -st topic312_1_1 -pt None -u 0.004596705926031286 > ./result_8chains/node312_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_2 -p 184 -st topic312_2_1 -pt None -u 0.005105661169662878 > ./result_8chains/node312_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_2 -p 524 -st topic312_3_1 -pt None -u 0.008481912628575256 > ./result_8chains/node312_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_2 -p 582 -st topic312_4_1 -pt None -u 0.01022064843919801 > ./result_8chains/node312_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_2 -p 826 -st topic312_5_1 -pt None -u 0.0034336010235594613 > ./result_8chains/node312_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_6_2 -p 947 -st topic312_6_1 -pt None -u 0.003321444786209153 > ./result_8chains/node312_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_7_2 -p 998 -st topic312_7_1 -pt None -u 0.003019309592859468 > ./result_8chains/node312_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_0_0 -p 109 -st none -pt topic312_0_0 -u 0.00496211133236707 > ./result_8chains/node312_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_1_0 -p 180 -st none -pt topic312_1_0 -u 0.015604937156945664 > ./result_8chains/node312_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_2_0 -p 184 -st none -pt topic312_2_0 -u 0.11025614098899705 > ./result_8chains/node312_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_3_0 -p 524 -st none -pt topic312_3_0 -u 0.03693389411385542 > ./result_8chains/node312_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_4_0 -p 582 -st none -pt topic312_4_0 -u 0.0019143144367332054 > ./result_8chains/node312_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_5_0 -p 826 -st none -pt topic312_5_0 -u 0.02392895573564477 > ./result_8chains/node312_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node312_6_0 -p 947 -st none -pt topic312_6_0 -u 0.00868407978485422 > ./result_8chains/node312_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node312_7_0 -p 998 -st none -pt topic312_7_0 -u 0.0023586961490128094 > ./result_8chains/node312_7_0.txt &
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
    "./result_8chains/node312_0_0.txt 90"
    "./result_8chains/node312_0_2.txt 90"
    "./result_8chains/node312_1_0.txt 89"
    "./result_8chains/node312_1_2.txt 89"
    "./result_8chains/node312_2_0.txt 88"
    "./result_8chains/node312_2_2.txt 88"
    "./result_8chains/node312_3_0.txt 87"
    "./result_8chains/node312_3_2.txt 87"
    "./result_8chains/node312_4_0.txt 86"
    "./result_8chains/node312_4_2.txt 86"
    "./result_8chains/node312_5_0.txt 85"
    "./result_8chains/node312_5_2.txt 85"
    "./result_8chains/node312_6_0.txt 84"
    "./result_8chains/node312_6_2.txt 84"
    "./result_8chains/node312_7_0.txt 83"
    "./result_8chains/node312_7_2.txt 83"
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

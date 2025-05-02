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
ros2 run evaluation_3_randomdag uunifast_node -n node203_0_2 -p 64 -st topic203_0_1 -pt None -u 0.011359926421663336 > ./result_8chains/node203_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_1_2 -p 174 -st topic203_1_1 -pt None -u 0.00616030494737535 > ./result_8chains/node203_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_2_2 -p 195 -st topic203_2_1 -pt None -u 0.0782489275314831 > ./result_8chains/node203_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_3_2 -p 269 -st topic203_3_1 -pt None -u 0.005123681297434762 > ./result_8chains/node203_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_4_2 -p 438 -st topic203_4_1 -pt None -u 0.0014893326403435658 > ./result_8chains/node203_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_5_2 -p 688 -st topic203_5_1 -pt None -u 0.014801668115988958 > ./result_8chains/node203_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_6_2 -p 735 -st topic203_6_1 -pt None -u 0.04121396093746878 > ./result_8chains/node203_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_7_2 -p 937 -st topic203_7_1 -pt None -u 0.0392373287827746 > ./result_8chains/node203_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_0_0 -p 64 -st none -pt topic203_0_0 -u 0.01466839303272166 > ./result_8chains/node203_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_1_0 -p 174 -st none -pt topic203_1_0 -u 0.012390568988685735 > ./result_8chains/node203_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_2_0 -p 195 -st none -pt topic203_2_0 -u 0.011648579668366632 > ./result_8chains/node203_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_3_0 -p 269 -st none -pt topic203_3_0 -u 0.09160201825883801 > ./result_8chains/node203_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_4_0 -p 438 -st none -pt topic203_4_0 -u 0.020529886760982385 > ./result_8chains/node203_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_5_0 -p 688 -st none -pt topic203_5_0 -u 0.015557400463731996 > ./result_8chains/node203_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node203_6_0 -p 735 -st none -pt topic203_6_0 -u 0.025288494355982807 > ./result_8chains/node203_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node203_7_0 -p 937 -st none -pt topic203_7_0 -u 0.002611751682075017 > ./result_8chains/node203_7_0.txt &
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
    "./result_8chains/node203_0_0.txt 90"
    "./result_8chains/node203_0_2.txt 90"
    "./result_8chains/node203_1_0.txt 89"
    "./result_8chains/node203_1_2.txt 89"
    "./result_8chains/node203_2_0.txt 88"
    "./result_8chains/node203_2_2.txt 88"
    "./result_8chains/node203_3_0.txt 87"
    "./result_8chains/node203_3_2.txt 87"
    "./result_8chains/node203_4_0.txt 86"
    "./result_8chains/node203_4_2.txt 86"
    "./result_8chains/node203_5_0.txt 85"
    "./result_8chains/node203_5_2.txt 85"
    "./result_8chains/node203_6_0.txt 84"
    "./result_8chains/node203_6_2.txt 84"
    "./result_8chains/node203_7_0.txt 83"
    "./result_8chains/node203_7_2.txt 83"
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

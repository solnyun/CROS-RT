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
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_2 -p 76 -st topic69_0_1 -pt None -u 0.0005346222102887155 > ./result_8chains/node69_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_2 -p 120 -st topic69_1_1 -pt None -u 0.020556152404152428 > ./result_8chains/node69_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_2 -p 303 -st topic69_2_1 -pt None -u 0.0668692536599621 > ./result_8chains/node69_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_2 -p 384 -st topic69_3_1 -pt None -u 0.011445448044394596 > ./result_8chains/node69_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_2 -p 519 -st topic69_4_1 -pt None -u 0.04876788532836365 > ./result_8chains/node69_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_2 -p 895 -st topic69_5_1 -pt None -u 0.0022256845808833192 > ./result_8chains/node69_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_6_2 -p 932 -st topic69_6_1 -pt None -u 0.001969069668322443 > ./result_8chains/node69_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_7_2 -p 983 -st topic69_7_1 -pt None -u 0.013426870448335437 > ./result_8chains/node69_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_0_0 -p 76 -st none -pt topic69_0_0 -u 0.007853501790562378 > ./result_8chains/node69_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_1_0 -p 120 -st none -pt topic69_1_0 -u 0.03213310644219075 > ./result_8chains/node69_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_2_0 -p 303 -st none -pt topic69_2_0 -u 0.002503842179199911 > ./result_8chains/node69_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_3_0 -p 384 -st none -pt topic69_3_0 -u 0.002425241824311919 > ./result_8chains/node69_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_4_0 -p 519 -st none -pt topic69_4_0 -u 0.002881466793768217 > ./result_8chains/node69_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_5_0 -p 895 -st none -pt topic69_5_0 -u 0.015538579479605075 > ./result_8chains/node69_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node69_6_0 -p 932 -st none -pt topic69_6_0 -u 0.02281854220278566 > ./result_8chains/node69_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node69_7_0 -p 983 -st none -pt topic69_7_0 -u 0.03213097911160104 > ./result_8chains/node69_7_0.txt &
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
    "./result_8chains/node69_0_0.txt 90"
    "./result_8chains/node69_0_2.txt 90"
    "./result_8chains/node69_1_0.txt 89"
    "./result_8chains/node69_1_2.txt 89"
    "./result_8chains/node69_2_0.txt 88"
    "./result_8chains/node69_2_2.txt 88"
    "./result_8chains/node69_3_0.txt 87"
    "./result_8chains/node69_3_2.txt 87"
    "./result_8chains/node69_4_0.txt 86"
    "./result_8chains/node69_4_2.txt 86"
    "./result_8chains/node69_5_0.txt 85"
    "./result_8chains/node69_5_2.txt 85"
    "./result_8chains/node69_6_0.txt 84"
    "./result_8chains/node69_6_2.txt 84"
    "./result_8chains/node69_7_0.txt 83"
    "./result_8chains/node69_7_2.txt 83"
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

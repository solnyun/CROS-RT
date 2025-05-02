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
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_2 -p 99 -st topic195_0_1 -pt None -u 0.005988298705044748 > ./result_10chains/node195_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_2 -p 247 -st topic195_1_1 -pt None -u 0.001337975117950474 > ./result_10chains/node195_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_2 -p 302 -st topic195_2_1 -pt None -u 0.017543863205297938 > ./result_10chains/node195_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_2 -p 306 -st topic195_3_1 -pt None -u 0.03226943020496714 > ./result_10chains/node195_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_2 -p 485 -st topic195_4_1 -pt None -u 0.02563391045155128 > ./result_10chains/node195_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_2 -p 516 -st topic195_5_1 -pt None -u 0.024558667149916613 > ./result_10chains/node195_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_6_2 -p 838 -st topic195_6_1 -pt None -u 0.022655650984703984 > ./result_10chains/node195_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_7_2 -p 879 -st topic195_7_1 -pt None -u 0.0627314009830914 > ./result_10chains/node195_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_8_2 -p 885 -st topic195_8_1 -pt None -u 0.0035605268936990397 > ./result_10chains/node195_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_9_2 -p 955 -st topic195_9_1 -pt None -u 0.013257606487076731 > ./result_10chains/node195_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_0_0 -p 99 -st none -pt topic195_0_0 -u 0.009902222344800926 > ./result_10chains/node195_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_1_0 -p 247 -st none -pt topic195_1_0 -u 0.01954181567287766 > ./result_10chains/node195_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_2_0 -p 302 -st none -pt topic195_2_0 -u 0.009705885367169542 > ./result_10chains/node195_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_3_0 -p 306 -st none -pt topic195_3_0 -u 0.004283591709593193 > ./result_10chains/node195_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_4_0 -p 485 -st none -pt topic195_4_0 -u 0.005193795848879246 > ./result_10chains/node195_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_5_0 -p 516 -st none -pt topic195_5_0 -u 0.0019899403354911582 > ./result_10chains/node195_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_6_0 -p 838 -st none -pt topic195_6_0 -u 0.007925318749612553 > ./result_10chains/node195_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_7_0 -p 879 -st none -pt topic195_7_0 -u 0.025783089368473316 > ./result_10chains/node195_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node195_8_0 -p 885 -st none -pt topic195_8_0 -u 0.00037473064041769477 > ./result_10chains/node195_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node195_9_0 -p 955 -st none -pt topic195_9_0 -u 0.0012520023017512927 > ./result_10chains/node195_9_0.txt &
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
    "./result_10chains/node195_0_0.txt 90"
    "./result_10chains/node195_0_2.txt 90"
    "./result_10chains/node195_1_0.txt 89"
    "./result_10chains/node195_1_2.txt 89"
    "./result_10chains/node195_2_0.txt 88"
    "./result_10chains/node195_2_2.txt 88"
    "./result_10chains/node195_3_0.txt 87"
    "./result_10chains/node195_3_2.txt 87"
    "./result_10chains/node195_4_0.txt 86"
    "./result_10chains/node195_4_2.txt 86"
    "./result_10chains/node195_5_0.txt 85"
    "./result_10chains/node195_5_2.txt 85"
    "./result_10chains/node195_6_0.txt 84"
    "./result_10chains/node195_6_2.txt 84"
    "./result_10chains/node195_7_0.txt 83"
    "./result_10chains/node195_7_2.txt 83"
    "./result_10chains/node195_8_0.txt 82"
    "./result_10chains/node195_8_2.txt 82"
    "./result_10chains/node195_9_0.txt 81"
    "./result_10chains/node195_9_2.txt 81"
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

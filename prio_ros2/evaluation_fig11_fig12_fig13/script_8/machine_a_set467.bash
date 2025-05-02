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
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_2 -p 78 -st topic467_0_1 -pt None -u 0.048979436542292754 > ./result_8chains/node467_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_2 -p 92 -st topic467_1_1 -pt None -u 0.02024847141858266 > ./result_8chains/node467_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_2 -p 230 -st topic467_2_1 -pt None -u 0.011025873327302371 > ./result_8chains/node467_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_2 -p 284 -st topic467_3_1 -pt None -u 0.0436386780962128 > ./result_8chains/node467_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_2 -p 431 -st topic467_4_1 -pt None -u 0.008021700300982038 > ./result_8chains/node467_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_2 -p 580 -st topic467_5_1 -pt None -u 0.008168944620593976 > ./result_8chains/node467_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_6_2 -p 582 -st topic467_6_1 -pt None -u 0.011303675982646866 > ./result_8chains/node467_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_7_2 -p 855 -st topic467_7_1 -pt None -u 0.02429084188826099 > ./result_8chains/node467_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_0_0 -p 78 -st none -pt topic467_0_0 -u 0.0019967571333094347 > ./result_8chains/node467_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_1_0 -p 92 -st none -pt topic467_1_0 -u 0.026346267160192616 > ./result_8chains/node467_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_2_0 -p 230 -st none -pt topic467_2_0 -u 0.022430250744418345 > ./result_8chains/node467_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_3_0 -p 284 -st none -pt topic467_3_0 -u 0.042811834555668116 > ./result_8chains/node467_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_4_0 -p 431 -st none -pt topic467_4_0 -u 0.024159529875081992 > ./result_8chains/node467_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_5_0 -p 580 -st none -pt topic467_5_0 -u 0.0019309397378035886 > ./result_8chains/node467_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node467_6_0 -p 582 -st none -pt topic467_6_0 -u 0.06826547025058269 > ./result_8chains/node467_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node467_7_0 -p 855 -st none -pt topic467_7_0 -u 0.03072098817784054 > ./result_8chains/node467_7_0.txt &
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
    "./result_8chains/node467_0_0.txt 90"
    "./result_8chains/node467_0_2.txt 90"
    "./result_8chains/node467_1_0.txt 89"
    "./result_8chains/node467_1_2.txt 89"
    "./result_8chains/node467_2_0.txt 88"
    "./result_8chains/node467_2_2.txt 88"
    "./result_8chains/node467_3_0.txt 87"
    "./result_8chains/node467_3_2.txt 87"
    "./result_8chains/node467_4_0.txt 86"
    "./result_8chains/node467_4_2.txt 86"
    "./result_8chains/node467_5_0.txt 85"
    "./result_8chains/node467_5_2.txt 85"
    "./result_8chains/node467_6_0.txt 84"
    "./result_8chains/node467_6_2.txt 84"
    "./result_8chains/node467_7_0.txt 83"
    "./result_8chains/node467_7_2.txt 83"
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

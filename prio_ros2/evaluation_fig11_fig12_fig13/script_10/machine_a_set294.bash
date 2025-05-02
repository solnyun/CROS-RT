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
ros2 run evaluation_3_randomdag uunifast_node -n node294_0_2 -p 47 -st topic294_0_1 -pt None -u 0.0033018948901326617 > ./result_10chains/node294_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_1_2 -p 142 -st topic294_1_1 -pt None -u 0.046336641923020616 > ./result_10chains/node294_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_2_2 -p 265 -st topic294_2_1 -pt None -u 0.012051436136902516 > ./result_10chains/node294_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_3_2 -p 404 -st topic294_3_1 -pt None -u 0.023576592552100484 > ./result_10chains/node294_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_4_2 -p 632 -st topic294_4_1 -pt None -u 0.0007867956664531772 > ./result_10chains/node294_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_5_2 -p 656 -st topic294_5_1 -pt None -u 0.016287281519641095 > ./result_10chains/node294_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_6_2 -p 757 -st topic294_6_1 -pt None -u 0.014200639312679564 > ./result_10chains/node294_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_7_2 -p 780 -st topic294_7_1 -pt None -u 0.02249016721474184 > ./result_10chains/node294_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_8_2 -p 837 -st topic294_8_1 -pt None -u 0.0016694352081529432 > ./result_10chains/node294_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_9_2 -p 959 -st topic294_9_1 -pt None -u 0.004575141598552336 > ./result_10chains/node294_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_0_0 -p 47 -st none -pt topic294_0_0 -u 0.0364851208279412 > ./result_10chains/node294_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_1_0 -p 142 -st none -pt topic294_1_0 -u 0.007778805599211125 > ./result_10chains/node294_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_2_0 -p 265 -st none -pt topic294_2_0 -u 0.008487164538954206 > ./result_10chains/node294_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_3_0 -p 404 -st none -pt topic294_3_0 -u 0.011847943201872768 > ./result_10chains/node294_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_4_0 -p 632 -st none -pt topic294_4_0 -u 0.021358595417571624 > ./result_10chains/node294_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_5_0 -p 656 -st none -pt topic294_5_0 -u 0.04479343379961992 > ./result_10chains/node294_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_6_0 -p 757 -st none -pt topic294_6_0 -u 0.000401749708385607 > ./result_10chains/node294_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_7_0 -p 780 -st none -pt topic294_7_0 -u 0.024251460352049364 > ./result_10chains/node294_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_8_0 -p 837 -st none -pt topic294_8_0 -u 0.013524083720958355 > ./result_10chains/node294_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_9_0 -p 959 -st none -pt topic294_9_0 -u 0.025633079187074574 > ./result_10chains/node294_9_0.txt &
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
    "./result_10chains/node294_0_0.txt 90"
    "./result_10chains/node294_0_2.txt 90"
    "./result_10chains/node294_1_0.txt 89"
    "./result_10chains/node294_1_2.txt 89"
    "./result_10chains/node294_2_0.txt 88"
    "./result_10chains/node294_2_2.txt 88"
    "./result_10chains/node294_3_0.txt 87"
    "./result_10chains/node294_3_2.txt 87"
    "./result_10chains/node294_4_0.txt 86"
    "./result_10chains/node294_4_2.txt 86"
    "./result_10chains/node294_5_0.txt 85"
    "./result_10chains/node294_5_2.txt 85"
    "./result_10chains/node294_6_0.txt 84"
    "./result_10chains/node294_6_2.txt 84"
    "./result_10chains/node294_7_0.txt 83"
    "./result_10chains/node294_7_2.txt 83"
    "./result_10chains/node294_8_0.txt 82"
    "./result_10chains/node294_8_2.txt 82"
    "./result_10chains/node294_9_0.txt 81"
    "./result_10chains/node294_9_2.txt 81"
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

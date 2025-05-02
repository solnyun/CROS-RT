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
ros2 run evaluation_3_randomdag uunifast_node -n node366_0_2 -p 139 -st topic366_0_1 -pt None -u 0.0374116194117618 > ./result_10chains/node366_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_1_2 -p 260 -st topic366_1_1 -pt None -u 0.010781871108241303 > ./result_10chains/node366_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_2_2 -p 268 -st topic366_2_1 -pt None -u 0.022275728347778023 > ./result_10chains/node366_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_3_2 -p 578 -st topic366_3_1 -pt None -u 0.0018734019766253884 > ./result_10chains/node366_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_4_2 -p 634 -st topic366_4_1 -pt None -u 0.0018545206517017188 > ./result_10chains/node366_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_5_2 -p 755 -st topic366_5_1 -pt None -u 0.0241525472886073 > ./result_10chains/node366_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_6_2 -p 820 -st topic366_6_1 -pt None -u 0.04780865196776962 > ./result_10chains/node366_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_7_2 -p 874 -st topic366_7_1 -pt None -u 0.012854755744192717 > ./result_10chains/node366_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_8_2 -p 897 -st topic366_8_1 -pt None -u 0.0017317558489950563 > ./result_10chains/node366_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_9_2 -p 966 -st topic366_9_1 -pt None -u 0.007068002945388112 > ./result_10chains/node366_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_0_0 -p 139 -st none -pt topic366_0_0 -u 0.001608223748786386 > ./result_10chains/node366_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_1_0 -p 260 -st none -pt topic366_1_0 -u 0.009506825140077613 > ./result_10chains/node366_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_2_0 -p 268 -st none -pt topic366_2_0 -u 0.014838360990874877 > ./result_10chains/node366_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_3_0 -p 578 -st none -pt topic366_3_0 -u 0.005025750770231319 > ./result_10chains/node366_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_4_0 -p 634 -st none -pt topic366_4_0 -u 0.002677808496118428 > ./result_10chains/node366_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_5_0 -p 755 -st none -pt topic366_5_0 -u 0.0012914815627600995 > ./result_10chains/node366_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_6_0 -p 820 -st none -pt topic366_6_0 -u 0.0013392658425437909 > ./result_10chains/node366_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_7_0 -p 874 -st none -pt topic366_7_0 -u 0.0014118895588173391 > ./result_10chains/node366_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node366_8_0 -p 897 -st none -pt topic366_8_0 -u 0.023726162038216883 > ./result_10chains/node366_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node366_9_0 -p 966 -st none -pt topic366_9_0 -u 0.0060955333202296486 > ./result_10chains/node366_9_0.txt &
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
    "./result_10chains/node366_0_0.txt 90"
    "./result_10chains/node366_0_2.txt 90"
    "./result_10chains/node366_1_0.txt 89"
    "./result_10chains/node366_1_2.txt 89"
    "./result_10chains/node366_2_0.txt 88"
    "./result_10chains/node366_2_2.txt 88"
    "./result_10chains/node366_3_0.txt 87"
    "./result_10chains/node366_3_2.txt 87"
    "./result_10chains/node366_4_0.txt 86"
    "./result_10chains/node366_4_2.txt 86"
    "./result_10chains/node366_5_0.txt 85"
    "./result_10chains/node366_5_2.txt 85"
    "./result_10chains/node366_6_0.txt 84"
    "./result_10chains/node366_6_2.txt 84"
    "./result_10chains/node366_7_0.txt 83"
    "./result_10chains/node366_7_2.txt 83"
    "./result_10chains/node366_8_0.txt 82"
    "./result_10chains/node366_8_2.txt 82"
    "./result_10chains/node366_9_0.txt 81"
    "./result_10chains/node366_9_2.txt 81"
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

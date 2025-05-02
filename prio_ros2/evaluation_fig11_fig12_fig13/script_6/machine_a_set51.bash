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
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_2 -p 285 -st topic51_0_1 -pt None -u 0.021995454322117136 > ./result_6chains/node51_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_2 -p 513 -st topic51_1_1 -pt None -u 0.00023470637434630515 > ./result_6chains/node51_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_2 -p 645 -st topic51_2_1 -pt None -u 0.11555509143739759 > ./result_6chains/node51_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_2 -p 776 -st topic51_3_1 -pt None -u 0.016585231123961097 > ./result_6chains/node51_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_2 -p 827 -st topic51_4_1 -pt None -u 0.010689972540032656 > ./result_6chains/node51_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_2 -p 862 -st topic51_5_1 -pt None -u 0.01144822323216779 > ./result_6chains/node51_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_0 -p 285 -st none -pt topic51_0_0 -u 0.006520088293777038 > ./result_6chains/node51_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_0 -p 513 -st none -pt topic51_1_0 -u 0.019687662626457936 > ./result_6chains/node51_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_0 -p 645 -st none -pt topic51_2_0 -u 0.05837941388034468 > ./result_6chains/node51_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_0 -p 776 -st none -pt topic51_3_0 -u 0.004931094540654407 > ./result_6chains/node51_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_0 -p 827 -st none -pt topic51_4_0 -u 0.04473820510090196 > ./result_6chains/node51_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_0 -p 862 -st none -pt topic51_5_0 -u 0.0006551844391870787 > ./result_6chains/node51_5_0.txt &
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
    "./result_6chains/node51_0_0.txt 90"
    "./result_6chains/node51_0_2.txt 90"
    "./result_6chains/node51_1_0.txt 89"
    "./result_6chains/node51_1_2.txt 89"
    "./result_6chains/node51_2_0.txt 88"
    "./result_6chains/node51_2_2.txt 88"
    "./result_6chains/node51_3_0.txt 87"
    "./result_6chains/node51_3_2.txt 87"
    "./result_6chains/node51_4_0.txt 86"
    "./result_6chains/node51_4_2.txt 86"
    "./result_6chains/node51_5_0.txt 85"
    "./result_6chains/node51_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

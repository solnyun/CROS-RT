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
ros2 run evaluation_3_randomdag uunifast_node -n node89_0_2 -p 98 -st topic89_0_1 -pt None -u 0.04957015291135902 > ./result_6chains/node89_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_1_2 -p 207 -st topic89_1_1 -pt None -u 0.0163716204751419 > ./result_6chains/node89_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_2_2 -p 211 -st topic89_2_1 -pt None -u 0.01461217200778131 > ./result_6chains/node89_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_3_2 -p 487 -st topic89_3_1 -pt None -u 0.011381564579171222 > ./result_6chains/node89_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_4_2 -p 735 -st topic89_4_1 -pt None -u 0.04434565714392891 > ./result_6chains/node89_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_5_2 -p 866 -st topic89_5_1 -pt None -u 0.04329650293437778 > ./result_6chains/node89_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_0_0 -p 98 -st none -pt topic89_0_0 -u 0.034088830823563454 > ./result_6chains/node89_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_1_0 -p 207 -st none -pt topic89_1_0 -u 0.025600489002750415 > ./result_6chains/node89_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_2_0 -p 211 -st none -pt topic89_2_0 -u 0.008301284049753777 > ./result_6chains/node89_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_3_0 -p 487 -st none -pt topic89_3_0 -u 0.05484015669948275 > ./result_6chains/node89_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node89_4_0 -p 735 -st none -pt topic89_4_0 -u 0.00808459207320783 > ./result_6chains/node89_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node89_5_0 -p 866 -st none -pt topic89_5_0 -u 0.047208786057686 > ./result_6chains/node89_5_0.txt &
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
    "./result_6chains/node89_0_0.txt 90"
    "./result_6chains/node89_0_2.txt 90"
    "./result_6chains/node89_1_0.txt 89"
    "./result_6chains/node89_1_2.txt 89"
    "./result_6chains/node89_2_0.txt 88"
    "./result_6chains/node89_2_2.txt 88"
    "./result_6chains/node89_3_0.txt 87"
    "./result_6chains/node89_3_2.txt 87"
    "./result_6chains/node89_4_0.txt 86"
    "./result_6chains/node89_4_2.txt 86"
    "./result_6chains/node89_5_0.txt 85"
    "./result_6chains/node89_5_2.txt 85"
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

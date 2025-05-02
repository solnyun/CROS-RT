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
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_2 -p 162 -st topic147_0_1 -pt None -u 0.013431773024151605 > ./result_6chains/node147_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_2 -p 422 -st topic147_1_1 -pt None -u 0.02963267620761345 > ./result_6chains/node147_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_2 -p 538 -st topic147_2_1 -pt None -u 7.633943031767898e-05 > ./result_6chains/node147_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_2 -p 591 -st topic147_3_1 -pt None -u 0.0221128504671724 > ./result_6chains/node147_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_2 -p 642 -st topic147_4_1 -pt None -u 0.013945555864083178 > ./result_6chains/node147_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_2 -p 841 -st topic147_5_1 -pt None -u 0.045295355408194654 > ./result_6chains/node147_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_0_0 -p 162 -st none -pt topic147_0_0 -u 0.0188637618120866 > ./result_6chains/node147_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_1_0 -p 422 -st none -pt topic147_1_0 -u 0.07088705761517411 > ./result_6chains/node147_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_2_0 -p 538 -st none -pt topic147_2_0 -u 0.06212350278694337 > ./result_6chains/node147_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_3_0 -p 591 -st none -pt topic147_3_0 -u 0.008246236770136556 > ./result_6chains/node147_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node147_4_0 -p 642 -st none -pt topic147_4_0 -u 0.017517374888002257 > ./result_6chains/node147_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node147_5_0 -p 841 -st none -pt topic147_5_0 -u 0.003487796702078841 > ./result_6chains/node147_5_0.txt &
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
    "./result_6chains/node147_0_0.txt 90"
    "./result_6chains/node147_0_2.txt 90"
    "./result_6chains/node147_1_0.txt 89"
    "./result_6chains/node147_1_2.txt 89"
    "./result_6chains/node147_2_0.txt 88"
    "./result_6chains/node147_2_2.txt 88"
    "./result_6chains/node147_3_0.txt 87"
    "./result_6chains/node147_3_2.txt 87"
    "./result_6chains/node147_4_0.txt 86"
    "./result_6chains/node147_4_2.txt 86"
    "./result_6chains/node147_5_0.txt 85"
    "./result_6chains/node147_5_2.txt 85"
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

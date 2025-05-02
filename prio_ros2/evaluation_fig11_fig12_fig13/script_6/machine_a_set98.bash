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
ros2 run evaluation_3_randomdag uunifast_node -n node98_0_2 -p 138 -st topic98_0_1 -pt None -u 0.011246391188747373 > ./result_6chains/node98_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_1_2 -p 290 -st topic98_1_1 -pt None -u 0.09213751558299188 > ./result_6chains/node98_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_2_2 -p 336 -st topic98_2_1 -pt None -u 0.0375384137211795 > ./result_6chains/node98_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_3_2 -p 481 -st topic98_3_1 -pt None -u 0.028107033007783028 > ./result_6chains/node98_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_4_2 -p 765 -st topic98_4_1 -pt None -u 0.0050485815122456035 > ./result_6chains/node98_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_5_2 -p 965 -st topic98_5_1 -pt None -u 0.028305725555903063 > ./result_6chains/node98_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_0_0 -p 138 -st none -pt topic98_0_0 -u 0.01710826130225901 > ./result_6chains/node98_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_1_0 -p 290 -st none -pt topic98_1_0 -u 0.009731422861018801 > ./result_6chains/node98_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_2_0 -p 336 -st none -pt topic98_2_0 -u 0.015738245318676347 > ./result_6chains/node98_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_3_0 -p 481 -st none -pt topic98_3_0 -u 0.012262665372228088 > ./result_6chains/node98_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node98_4_0 -p 765 -st none -pt topic98_4_0 -u 0.016399982100221616 > ./result_6chains/node98_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node98_5_0 -p 965 -st none -pt topic98_5_0 -u 0.0340984724376666 > ./result_6chains/node98_5_0.txt &
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
    "./result_6chains/node98_0_0.txt 90"
    "./result_6chains/node98_0_2.txt 90"
    "./result_6chains/node98_1_0.txt 89"
    "./result_6chains/node98_1_2.txt 89"
    "./result_6chains/node98_2_0.txt 88"
    "./result_6chains/node98_2_2.txt 88"
    "./result_6chains/node98_3_0.txt 87"
    "./result_6chains/node98_3_2.txt 87"
    "./result_6chains/node98_4_0.txt 86"
    "./result_6chains/node98_4_2.txt 86"
    "./result_6chains/node98_5_0.txt 85"
    "./result_6chains/node98_5_2.txt 85"
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

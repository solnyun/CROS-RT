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
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_2 -p 110 -st topic356_0_1 -pt None -u 0.03455740461373957 > ./result_6chains/node356_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_2 -p 194 -st topic356_1_1 -pt None -u 0.04054009731761049 > ./result_6chains/node356_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_2 -p 615 -st topic356_2_1 -pt None -u 0.03343412660711459 > ./result_6chains/node356_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_2 -p 742 -st topic356_3_1 -pt None -u 0.03468963443328771 > ./result_6chains/node356_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_2 -p 823 -st topic356_4_1 -pt None -u 0.03437624210057873 > ./result_6chains/node356_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_2 -p 938 -st topic356_5_1 -pt None -u 0.06238393204576618 > ./result_6chains/node356_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_0_0 -p 110 -st none -pt topic356_0_0 -u 0.04370914255244196 > ./result_6chains/node356_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_1_0 -p 194 -st none -pt topic356_1_0 -u 0.03837609477396864 > ./result_6chains/node356_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_2_0 -p 615 -st none -pt topic356_2_0 -u 0.030727934265945556 > ./result_6chains/node356_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_3_0 -p 742 -st none -pt topic356_3_0 -u 0.01810537209520538 > ./result_6chains/node356_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node356_4_0 -p 823 -st none -pt topic356_4_0 -u 0.0011483495403023514 > ./result_6chains/node356_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node356_5_0 -p 938 -st none -pt topic356_5_0 -u 0.023598153134370373 > ./result_6chains/node356_5_0.txt &
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
    "./result_6chains/node356_0_0.txt 90"
    "./result_6chains/node356_0_2.txt 90"
    "./result_6chains/node356_1_0.txt 89"
    "./result_6chains/node356_1_2.txt 89"
    "./result_6chains/node356_2_0.txt 88"
    "./result_6chains/node356_2_2.txt 88"
    "./result_6chains/node356_3_0.txt 87"
    "./result_6chains/node356_3_2.txt 87"
    "./result_6chains/node356_4_0.txt 86"
    "./result_6chains/node356_4_2.txt 86"
    "./result_6chains/node356_5_0.txt 85"
    "./result_6chains/node356_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node482_0_2 -p 80 -st topic482_0_1 -pt None -u 0.017593421658941732 > ./result_6chains/node482_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_1_2 -p 195 -st topic482_1_1 -pt None -u 0.036091309820099005 > ./result_6chains/node482_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_2_2 -p 256 -st topic482_2_1 -pt None -u 0.049382722138709506 > ./result_6chains/node482_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_3_2 -p 351 -st topic482_3_1 -pt None -u 0.0221514501610226 > ./result_6chains/node482_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_4_2 -p 368 -st topic482_4_1 -pt None -u 0.028924639313470807 > ./result_6chains/node482_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_5_2 -p 642 -st topic482_5_1 -pt None -u 0.021737051117356132 > ./result_6chains/node482_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_0_0 -p 80 -st none -pt topic482_0_0 -u 0.057958509354882615 > ./result_6chains/node482_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_1_0 -p 195 -st none -pt topic482_1_0 -u 0.04867169586185732 > ./result_6chains/node482_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_2_0 -p 256 -st none -pt topic482_2_0 -u 0.009434245088499882 > ./result_6chains/node482_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_3_0 -p 351 -st none -pt topic482_3_0 -u 0.0062508644574429395 > ./result_6chains/node482_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node482_4_0 -p 368 -st none -pt topic482_4_0 -u 0.01104252420663196 > ./result_6chains/node482_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node482_5_0 -p 642 -st none -pt topic482_5_0 -u 0.0017107204668862924 > ./result_6chains/node482_5_0.txt &
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
    "./result_6chains/node482_0_0.txt 90"
    "./result_6chains/node482_0_2.txt 90"
    "./result_6chains/node482_1_0.txt 89"
    "./result_6chains/node482_1_2.txt 89"
    "./result_6chains/node482_2_0.txt 88"
    "./result_6chains/node482_2_2.txt 88"
    "./result_6chains/node482_3_0.txt 87"
    "./result_6chains/node482_3_2.txt 87"
    "./result_6chains/node482_4_0.txt 86"
    "./result_6chains/node482_4_2.txt 86"
    "./result_6chains/node482_5_0.txt 85"
    "./result_6chains/node482_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node208_0_2 -p 58 -st topic208_0_1 -pt None -u 0.04191735590845208 > ./result_4chains/node208_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_1_2 -p 342 -st topic208_1_1 -pt None -u 0.00419222259666896 > ./result_4chains/node208_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_2_2 -p 370 -st topic208_2_1 -pt None -u 0.013368469928921545 > ./result_4chains/node208_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_3_2 -p 623 -st topic208_3_1 -pt None -u 0.1770110660632 > ./result_4chains/node208_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_0_0 -p 58 -st none -pt topic208_0_0 -u 0.03242985067356868 > ./result_4chains/node208_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_1_0 -p 342 -st none -pt topic208_1_0 -u 0.04203640250871976 > ./result_4chains/node208_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node208_2_0 -p 370 -st none -pt topic208_2_0 -u 0.0159753666735874 > ./result_4chains/node208_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node208_3_0 -p 623 -st none -pt topic208_3_0 -u 0.09490282207719666 > ./result_4chains/node208_3_0.txt &
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
    "./result_4chains/node208_0_0.txt 90"
    "./result_4chains/node208_0_2.txt 90"
    "./result_4chains/node208_1_0.txt 89"
    "./result_4chains/node208_1_2.txt 89"
    "./result_4chains/node208_2_0.txt 88"
    "./result_4chains/node208_2_2.txt 88"
    "./result_4chains/node208_3_0.txt 87"
    "./result_4chains/node208_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

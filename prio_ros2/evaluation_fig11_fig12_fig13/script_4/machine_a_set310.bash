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
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_2 -p 36 -st topic310_0_1 -pt None -u 0.042684574462053815 > ./result_4chains/node310_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_2 -p 791 -st topic310_1_1 -pt None -u 0.012545926261754325 > ./result_4chains/node310_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_2 -p 918 -st topic310_2_1 -pt None -u 0.008441183215176562 > ./result_4chains/node310_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_2 -p 919 -st topic310_3_1 -pt None -u 0.08455656975211294 > ./result_4chains/node310_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_0_0 -p 36 -st none -pt topic310_0_0 -u 0.0029802580335612228 > ./result_4chains/node310_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_1_0 -p 791 -st none -pt topic310_1_0 -u 0.02967679280737212 > ./result_4chains/node310_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node310_2_0 -p 918 -st none -pt topic310_2_0 -u 0.015462087069243347 > ./result_4chains/node310_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node310_3_0 -p 919 -st none -pt topic310_3_0 -u 0.002750341290797681 > ./result_4chains/node310_3_0.txt &
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
    "./result_4chains/node310_0_0.txt 90"
    "./result_4chains/node310_0_2.txt 90"
    "./result_4chains/node310_1_0.txt 89"
    "./result_4chains/node310_1_2.txt 89"
    "./result_4chains/node310_2_0.txt 88"
    "./result_4chains/node310_2_2.txt 88"
    "./result_4chains/node310_3_0.txt 87"
    "./result_4chains/node310_3_2.txt 87"
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

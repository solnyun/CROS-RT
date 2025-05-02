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
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_2 -p 51 -st topic416_0_1 -pt None -u 0.07055108451118186 > ./result_4chains/node416_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_2 -p 681 -st topic416_1_1 -pt None -u 0.0020156633789706335 > ./result_4chains/node416_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_2 -p 782 -st topic416_2_1 -pt None -u 0.016323760393195025 > ./result_4chains/node416_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_2 -p 850 -st topic416_3_1 -pt None -u 0.01920329721780349 > ./result_4chains/node416_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_0_0 -p 51 -st none -pt topic416_0_0 -u 0.10647498289260293 > ./result_4chains/node416_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_1_0 -p 681 -st none -pt topic416_1_0 -u 0.09304113477335382 > ./result_4chains/node416_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node416_2_0 -p 782 -st none -pt topic416_2_0 -u 0.03874958972642413 > ./result_4chains/node416_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node416_3_0 -p 850 -st none -pt topic416_3_0 -u 0.027070356006515934 > ./result_4chains/node416_3_0.txt &
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
    "./result_4chains/node416_0_0.txt 90"
    "./result_4chains/node416_0_2.txt 90"
    "./result_4chains/node416_1_0.txt 89"
    "./result_4chains/node416_1_2.txt 89"
    "./result_4chains/node416_2_0.txt 88"
    "./result_4chains/node416_2_2.txt 88"
    "./result_4chains/node416_3_0.txt 87"
    "./result_4chains/node416_3_2.txt 87"
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

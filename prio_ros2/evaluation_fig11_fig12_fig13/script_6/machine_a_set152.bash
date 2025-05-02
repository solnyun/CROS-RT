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
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_2 -p 186 -st topic152_0_1 -pt None -u 0.06707547543818537 > ./result_6chains/node152_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_2 -p 214 -st topic152_1_1 -pt None -u 0.031948049142754675 > ./result_6chains/node152_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_2 -p 446 -st topic152_2_1 -pt None -u 0.03445064473764914 > ./result_6chains/node152_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_2 -p 527 -st topic152_3_1 -pt None -u 0.012105029256327976 > ./result_6chains/node152_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_4_2 -p 704 -st topic152_4_1 -pt None -u 0.0052919983853075 > ./result_6chains/node152_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_5_2 -p 997 -st topic152_5_1 -pt None -u 0.08792623098207117 > ./result_6chains/node152_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_0_0 -p 186 -st none -pt topic152_0_0 -u 0.011743118206482661 > ./result_6chains/node152_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_1_0 -p 214 -st none -pt topic152_1_0 -u 0.0059922098950789815 > ./result_6chains/node152_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_2_0 -p 446 -st none -pt topic152_2_0 -u 0.03675999887751924 > ./result_6chains/node152_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_3_0 -p 527 -st none -pt topic152_3_0 -u 0.003176324696508609 > ./result_6chains/node152_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node152_4_0 -p 704 -st none -pt topic152_4_0 -u 0.020405868524607296 > ./result_6chains/node152_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node152_5_0 -p 997 -st none -pt topic152_5_0 -u 0.01787067273883483 > ./result_6chains/node152_5_0.txt &
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
    "./result_6chains/node152_0_0.txt 90"
    "./result_6chains/node152_0_2.txt 90"
    "./result_6chains/node152_1_0.txt 89"
    "./result_6chains/node152_1_2.txt 89"
    "./result_6chains/node152_2_0.txt 88"
    "./result_6chains/node152_2_2.txt 88"
    "./result_6chains/node152_3_0.txt 87"
    "./result_6chains/node152_3_2.txt 87"
    "./result_6chains/node152_4_0.txt 86"
    "./result_6chains/node152_4_2.txt 86"
    "./result_6chains/node152_5_0.txt 85"
    "./result_6chains/node152_5_2.txt 85"
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

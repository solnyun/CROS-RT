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
ros2 run evaluation_3_randomdag uunifast_node -n node1_0_2 -p 208 -st topic1_0_1 -pt None -u 0.0003466229453688574 > ./result_6chains/node1_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_1_2 -p 345 -st topic1_1_1 -pt None -u 0.08632926924728657 > ./result_6chains/node1_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_2_2 -p 453 -st topic1_2_1 -pt None -u 0.05489878928927577 > ./result_6chains/node1_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_3_2 -p 547 -st topic1_3_1 -pt None -u 0.03808754159052419 > ./result_6chains/node1_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_4_2 -p 564 -st topic1_4_1 -pt None -u 0.01870753529571076 > ./result_6chains/node1_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_5_2 -p 915 -st topic1_5_1 -pt None -u 0.03812284293527767 > ./result_6chains/node1_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_0_0 -p 208 -st none -pt topic1_0_0 -u 0.01000353714771629 > ./result_6chains/node1_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_1_0 -p 345 -st none -pt topic1_1_0 -u 0.029376779576986367 > ./result_6chains/node1_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_2_0 -p 453 -st none -pt topic1_2_0 -u 0.02483588327003522 > ./result_6chains/node1_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_3_0 -p 547 -st none -pt topic1_3_0 -u 0.007258029746781969 > ./result_6chains/node1_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node1_4_0 -p 564 -st none -pt topic1_4_0 -u 0.02509838067249734 > ./result_6chains/node1_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node1_5_0 -p 915 -st none -pt topic1_5_0 -u 0.014455054068695572 > ./result_6chains/node1_5_0.txt &
sleep 10
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
    "./result_6chains/node1_0_0.txt 90"
    "./result_6chains/node1_0_2.txt 90"
    "./result_6chains/node1_1_0.txt 89"
    "./result_6chains/node1_1_2.txt 89"
    "./result_6chains/node1_2_0.txt 88"
    "./result_6chains/node1_2_2.txt 88"
    "./result_6chains/node1_3_0.txt 87"
    "./result_6chains/node1_3_2.txt 87"
    "./result_6chains/node1_4_0.txt 86"
    "./result_6chains/node1_4_2.txt 86"
    "./result_6chains/node1_5_0.txt 85"
    "./result_6chains/node1_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

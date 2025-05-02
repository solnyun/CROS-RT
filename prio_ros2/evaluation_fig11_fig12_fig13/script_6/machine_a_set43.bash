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
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_2 -p 182 -st topic43_0_1 -pt None -u 0.05582816862586287 > ./result_6chains/node43_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_2 -p 293 -st topic43_1_1 -pt None -u 0.033807459943324625 > ./result_6chains/node43_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_2 -p 314 -st topic43_2_1 -pt None -u 0.020429129111735778 > ./result_6chains/node43_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_2 -p 549 -st topic43_3_1 -pt None -u 0.017064891564052914 > ./result_6chains/node43_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_2 -p 650 -st topic43_4_1 -pt None -u 0.02290661227285687 > ./result_6chains/node43_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_2 -p 724 -st topic43_5_1 -pt None -u 0.0600663439129636 > ./result_6chains/node43_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_0_0 -p 182 -st none -pt topic43_0_0 -u 0.013974079963540997 > ./result_6chains/node43_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_1_0 -p 293 -st none -pt topic43_1_0 -u 0.0023089169865112003 > ./result_6chains/node43_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_2_0 -p 314 -st none -pt topic43_2_0 -u 0.0009149357006843495 > ./result_6chains/node43_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_3_0 -p 549 -st none -pt topic43_3_0 -u 0.049578871944181646 > ./result_6chains/node43_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node43_4_0 -p 650 -st none -pt topic43_4_0 -u 0.02099744245920024 > ./result_6chains/node43_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node43_5_0 -p 724 -st none -pt topic43_5_0 -u 0.03239401816015254 > ./result_6chains/node43_5_0.txt &
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
    "./result_6chains/node43_0_0.txt 90"
    "./result_6chains/node43_0_2.txt 90"
    "./result_6chains/node43_1_0.txt 89"
    "./result_6chains/node43_1_2.txt 89"
    "./result_6chains/node43_2_0.txt 88"
    "./result_6chains/node43_2_2.txt 88"
    "./result_6chains/node43_3_0.txt 87"
    "./result_6chains/node43_3_2.txt 87"
    "./result_6chains/node43_4_0.txt 86"
    "./result_6chains/node43_4_2.txt 86"
    "./result_6chains/node43_5_0.txt 85"
    "./result_6chains/node43_5_2.txt 85"
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

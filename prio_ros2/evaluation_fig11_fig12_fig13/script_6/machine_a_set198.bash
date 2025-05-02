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
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_2 -p 695 -st topic198_0_1 -pt None -u 0.014591284232103596 > ./result_6chains/node198_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_2 -p 763 -st topic198_1_1 -pt None -u 0.013448335089254582 > ./result_6chains/node198_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_2 -p 803 -st topic198_2_1 -pt None -u 0.02070688039658522 > ./result_6chains/node198_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_2 -p 829 -st topic198_3_1 -pt None -u 0.038115968869483235 > ./result_6chains/node198_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_2 -p 885 -st topic198_4_1 -pt None -u 0.019393900128932245 > ./result_6chains/node198_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_2 -p 998 -st topic198_5_1 -pt None -u 0.01834003059858459 > ./result_6chains/node198_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_0_0 -p 695 -st none -pt topic198_0_0 -u 0.010842815369399794 > ./result_6chains/node198_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_1_0 -p 763 -st none -pt topic198_1_0 -u 0.07413198989901609 > ./result_6chains/node198_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_2_0 -p 803 -st none -pt topic198_2_0 -u 0.013117369819773461 > ./result_6chains/node198_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_3_0 -p 829 -st none -pt topic198_3_0 -u 0.03213281243120622 > ./result_6chains/node198_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node198_4_0 -p 885 -st none -pt topic198_4_0 -u 0.041677211439970774 > ./result_6chains/node198_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node198_5_0 -p 998 -st none -pt topic198_5_0 -u 0.03767867449032554 > ./result_6chains/node198_5_0.txt &
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
    "./result_6chains/node198_0_0.txt 90"
    "./result_6chains/node198_0_2.txt 90"
    "./result_6chains/node198_1_0.txt 89"
    "./result_6chains/node198_1_2.txt 89"
    "./result_6chains/node198_2_0.txt 88"
    "./result_6chains/node198_2_2.txt 88"
    "./result_6chains/node198_3_0.txt 87"
    "./result_6chains/node198_3_2.txt 87"
    "./result_6chains/node198_4_0.txt 86"
    "./result_6chains/node198_4_2.txt 86"
    "./result_6chains/node198_5_0.txt 85"
    "./result_6chains/node198_5_2.txt 85"
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

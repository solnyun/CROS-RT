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
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_2 -p 118 -st topic222_0_1 -pt None -u 0.0228966807918341 > ./result_6chains/node222_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_2 -p 154 -st topic222_1_1 -pt None -u 0.00933041040032645 > ./result_6chains/node222_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_2 -p 417 -st topic222_2_1 -pt None -u 0.05459650262293009 > ./result_6chains/node222_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_2 -p 860 -st topic222_3_1 -pt None -u 0.0010891382292649576 > ./result_6chains/node222_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_4_2 -p 889 -st topic222_4_1 -pt None -u 0.013561129417596934 > ./result_6chains/node222_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_5_2 -p 911 -st topic222_5_1 -pt None -u 0.01567712748257651 > ./result_6chains/node222_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_0_0 -p 118 -st none -pt topic222_0_0 -u 0.053480414488816685 > ./result_6chains/node222_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_1_0 -p 154 -st none -pt topic222_1_0 -u 0.09136275867157578 > ./result_6chains/node222_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_2_0 -p 417 -st none -pt topic222_2_0 -u 0.05703553945993803 > ./result_6chains/node222_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_3_0 -p 860 -st none -pt topic222_3_0 -u 0.013711614548858303 > ./result_6chains/node222_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node222_4_0 -p 889 -st none -pt topic222_4_0 -u 0.018191835073415458 > ./result_6chains/node222_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node222_5_0 -p 911 -st none -pt topic222_5_0 -u 0.02706964596096371 > ./result_6chains/node222_5_0.txt &
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
    "./result_6chains/node222_0_0.txt 90"
    "./result_6chains/node222_0_2.txt 90"
    "./result_6chains/node222_1_0.txt 89"
    "./result_6chains/node222_1_2.txt 89"
    "./result_6chains/node222_2_0.txt 88"
    "./result_6chains/node222_2_2.txt 88"
    "./result_6chains/node222_3_0.txt 87"
    "./result_6chains/node222_3_2.txt 87"
    "./result_6chains/node222_4_0.txt 86"
    "./result_6chains/node222_4_2.txt 86"
    "./result_6chains/node222_5_0.txt 85"
    "./result_6chains/node222_5_2.txt 85"
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

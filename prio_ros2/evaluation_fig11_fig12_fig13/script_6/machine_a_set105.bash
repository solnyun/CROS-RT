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
ros2 run evaluation_3_randomdag uunifast_node -n node105_0_2 -p 329 -st topic105_0_1 -pt None -u 0.017850386933572437 > ./result_6chains/node105_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_1_2 -p 352 -st topic105_1_1 -pt None -u 0.04807638414451676 > ./result_6chains/node105_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_2_2 -p 517 -st topic105_2_1 -pt None -u 0.02319261837134265 > ./result_6chains/node105_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_3_2 -p 622 -st topic105_3_1 -pt None -u 0.004974232468665268 > ./result_6chains/node105_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_4_2 -p 648 -st topic105_4_1 -pt None -u 0.005392220220099324 > ./result_6chains/node105_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_5_2 -p 828 -st topic105_5_1 -pt None -u 0.018161691355783292 > ./result_6chains/node105_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_0_0 -p 329 -st none -pt topic105_0_0 -u 0.03681805331650778 > ./result_6chains/node105_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_1_0 -p 352 -st none -pt topic105_1_0 -u 0.015523640750116974 > ./result_6chains/node105_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_2_0 -p 517 -st none -pt topic105_2_0 -u 0.03518092759760705 > ./result_6chains/node105_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_3_0 -p 622 -st none -pt topic105_3_0 -u 0.03975207558293428 > ./result_6chains/node105_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node105_4_0 -p 648 -st none -pt topic105_4_0 -u 0.05107827391005944 > ./result_6chains/node105_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node105_5_0 -p 828 -st none -pt topic105_5_0 -u 0.004122201799459137 > ./result_6chains/node105_5_0.txt &
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
    "./result_6chains/node105_0_0.txt 90"
    "./result_6chains/node105_0_2.txt 90"
    "./result_6chains/node105_1_0.txt 89"
    "./result_6chains/node105_1_2.txt 89"
    "./result_6chains/node105_2_0.txt 88"
    "./result_6chains/node105_2_2.txt 88"
    "./result_6chains/node105_3_0.txt 87"
    "./result_6chains/node105_3_2.txt 87"
    "./result_6chains/node105_4_0.txt 86"
    "./result_6chains/node105_4_2.txt 86"
    "./result_6chains/node105_5_0.txt 85"
    "./result_6chains/node105_5_2.txt 85"
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

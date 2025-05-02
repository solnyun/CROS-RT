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
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_2 -p 112 -st topic179_0_1 -pt None -u 0.0041825223645471366 > ./result_6chains/node179_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_2 -p 118 -st topic179_1_1 -pt None -u 0.01272235730013116 > ./result_6chains/node179_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_2 -p 376 -st topic179_2_1 -pt None -u 0.01348266734451059 > ./result_6chains/node179_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_2 -p 441 -st topic179_3_1 -pt None -u 0.031549125116870275 > ./result_6chains/node179_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_2 -p 531 -st topic179_4_1 -pt None -u 0.03320281369890464 > ./result_6chains/node179_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_2 -p 840 -st topic179_5_1 -pt None -u 0.010292847610046878 > ./result_6chains/node179_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_0_0 -p 112 -st none -pt topic179_0_0 -u 0.0026209660765550424 > ./result_6chains/node179_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_1_0 -p 118 -st none -pt topic179_1_0 -u 0.0050392789157440165 > ./result_6chains/node179_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_2_0 -p 376 -st none -pt topic179_2_0 -u 0.012602167004469644 > ./result_6chains/node179_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_3_0 -p 441 -st none -pt topic179_3_0 -u 0.009909318321675076 > ./result_6chains/node179_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node179_4_0 -p 531 -st none -pt topic179_4_0 -u 0.0853493757693897 > ./result_6chains/node179_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node179_5_0 -p 840 -st none -pt topic179_5_0 -u 0.06779728821687711 > ./result_6chains/node179_5_0.txt &
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
    "./result_6chains/node179_0_0.txt 90"
    "./result_6chains/node179_0_2.txt 90"
    "./result_6chains/node179_1_0.txt 89"
    "./result_6chains/node179_1_2.txt 89"
    "./result_6chains/node179_2_0.txt 88"
    "./result_6chains/node179_2_2.txt 88"
    "./result_6chains/node179_3_0.txt 87"
    "./result_6chains/node179_3_2.txt 87"
    "./result_6chains/node179_4_0.txt 86"
    "./result_6chains/node179_4_2.txt 86"
    "./result_6chains/node179_5_0.txt 85"
    "./result_6chains/node179_5_2.txt 85"
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

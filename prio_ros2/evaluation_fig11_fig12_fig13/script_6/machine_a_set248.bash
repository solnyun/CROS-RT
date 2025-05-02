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
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_2 -p 122 -st topic248_0_1 -pt None -u 0.011227718828038136 > ./result_6chains/node248_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_2 -p 125 -st topic248_1_1 -pt None -u 0.018167462544578017 > ./result_6chains/node248_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_2 -p 552 -st topic248_2_1 -pt None -u 0.013176397600910827 > ./result_6chains/node248_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_2 -p 715 -st topic248_3_1 -pt None -u 0.02831989617505673 > ./result_6chains/node248_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_2 -p 727 -st topic248_4_1 -pt None -u 0.0507428027489851 > ./result_6chains/node248_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_2 -p 828 -st topic248_5_1 -pt None -u 0.011099018077261663 > ./result_6chains/node248_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_0_0 -p 122 -st none -pt topic248_0_0 -u 0.05542360378122452 > ./result_6chains/node248_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_1_0 -p 125 -st none -pt topic248_1_0 -u 0.02369748999052207 > ./result_6chains/node248_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_2_0 -p 552 -st none -pt topic248_2_0 -u 0.00033447093793848026 > ./result_6chains/node248_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_3_0 -p 715 -st none -pt topic248_3_0 -u 0.006120270114584658 > ./result_6chains/node248_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node248_4_0 -p 727 -st none -pt topic248_4_0 -u 0.0005167929844372421 > ./result_6chains/node248_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node248_5_0 -p 828 -st none -pt topic248_5_0 -u 0.10845441861186761 > ./result_6chains/node248_5_0.txt &
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
    "./result_6chains/node248_0_0.txt 90"
    "./result_6chains/node248_0_2.txt 90"
    "./result_6chains/node248_1_0.txt 89"
    "./result_6chains/node248_1_2.txt 89"
    "./result_6chains/node248_2_0.txt 88"
    "./result_6chains/node248_2_2.txt 88"
    "./result_6chains/node248_3_0.txt 87"
    "./result_6chains/node248_3_2.txt 87"
    "./result_6chains/node248_4_0.txt 86"
    "./result_6chains/node248_4_2.txt 86"
    "./result_6chains/node248_5_0.txt 85"
    "./result_6chains/node248_5_2.txt 85"
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

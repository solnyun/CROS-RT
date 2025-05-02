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
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_2 -p 68 -st topic391_0_1 -pt None -u 0.015383534581796088 > ./result_6chains/node391_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_2 -p 475 -st topic391_1_1 -pt None -u 0.03513407149427794 > ./result_6chains/node391_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_2 -p 570 -st topic391_2_1 -pt None -u 0.01117683598925101 > ./result_6chains/node391_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_2 -p 603 -st topic391_3_1 -pt None -u 0.008012649745504807 > ./result_6chains/node391_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_2 -p 639 -st topic391_4_1 -pt None -u 0.013127527203493444 > ./result_6chains/node391_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_2 -p 831 -st topic391_5_1 -pt None -u 0.01961096333786584 > ./result_6chains/node391_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_0_0 -p 68 -st none -pt topic391_0_0 -u 0.0027971823851931643 > ./result_6chains/node391_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_1_0 -p 475 -st none -pt topic391_1_0 -u 0.008146711911023341 > ./result_6chains/node391_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_2_0 -p 570 -st none -pt topic391_2_0 -u 0.00713350938131152 > ./result_6chains/node391_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_3_0 -p 603 -st none -pt topic391_3_0 -u 0.06477392161906428 > ./result_6chains/node391_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node391_4_0 -p 639 -st none -pt topic391_4_0 -u 0.021558524923227435 > ./result_6chains/node391_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node391_5_0 -p 831 -st none -pt topic391_5_0 -u 0.00599922974711356 > ./result_6chains/node391_5_0.txt &
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
    "./result_6chains/node391_0_0.txt 90"
    "./result_6chains/node391_0_2.txt 90"
    "./result_6chains/node391_1_0.txt 89"
    "./result_6chains/node391_1_2.txt 89"
    "./result_6chains/node391_2_0.txt 88"
    "./result_6chains/node391_2_2.txt 88"
    "./result_6chains/node391_3_0.txt 87"
    "./result_6chains/node391_3_2.txt 87"
    "./result_6chains/node391_4_0.txt 86"
    "./result_6chains/node391_4_2.txt 86"
    "./result_6chains/node391_5_0.txt 85"
    "./result_6chains/node391_5_2.txt 85"
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

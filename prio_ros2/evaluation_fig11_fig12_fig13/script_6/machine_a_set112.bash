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
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_2 -p 107 -st topic112_0_1 -pt None -u 0.007906519839593562 > ./result_6chains/node112_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_2 -p 177 -st topic112_1_1 -pt None -u 0.053383273201773884 > ./result_6chains/node112_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_2 -p 188 -st topic112_2_1 -pt None -u 0.011831532306952608 > ./result_6chains/node112_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_2 -p 265 -st topic112_3_1 -pt None -u 0.03847043547914375 > ./result_6chains/node112_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_2 -p 338 -st topic112_4_1 -pt None -u 0.0035858812278661972 > ./result_6chains/node112_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_2 -p 454 -st topic112_5_1 -pt None -u 0.02476691107487381 > ./result_6chains/node112_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_0_0 -p 107 -st none -pt topic112_0_0 -u 0.007449783365685636 > ./result_6chains/node112_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_1_0 -p 177 -st none -pt topic112_1_0 -u 0.02090965837581854 > ./result_6chains/node112_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_2_0 -p 188 -st none -pt topic112_2_0 -u 0.034087821863998 > ./result_6chains/node112_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_3_0 -p 265 -st none -pt topic112_3_0 -u 0.062407785960025636 > ./result_6chains/node112_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node112_4_0 -p 338 -st none -pt topic112_4_0 -u 0.005439639126750079 > ./result_6chains/node112_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node112_5_0 -p 454 -st none -pt topic112_5_0 -u 0.02586303272381938 > ./result_6chains/node112_5_0.txt &
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
    "./result_6chains/node112_0_0.txt 90"
    "./result_6chains/node112_0_2.txt 90"
    "./result_6chains/node112_1_0.txt 89"
    "./result_6chains/node112_1_2.txt 89"
    "./result_6chains/node112_2_0.txt 88"
    "./result_6chains/node112_2_2.txt 88"
    "./result_6chains/node112_3_0.txt 87"
    "./result_6chains/node112_3_2.txt 87"
    "./result_6chains/node112_4_0.txt 86"
    "./result_6chains/node112_4_2.txt 86"
    "./result_6chains/node112_5_0.txt 85"
    "./result_6chains/node112_5_2.txt 85"
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

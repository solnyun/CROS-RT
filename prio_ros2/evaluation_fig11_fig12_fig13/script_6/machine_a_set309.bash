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
ros2 run evaluation_3_randomdag uunifast_node -n node309_0_2 -p 82 -st topic309_0_1 -pt None -u 0.054381566316371366 > ./result_6chains/node309_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_1_2 -p 280 -st topic309_1_1 -pt None -u 0.007547845974043288 > ./result_6chains/node309_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_2_2 -p 728 -st topic309_2_1 -pt None -u 0.023544621782042113 > ./result_6chains/node309_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_3_2 -p 742 -st topic309_3_1 -pt None -u 0.03618430882658327 > ./result_6chains/node309_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_4_2 -p 782 -st topic309_4_1 -pt None -u 0.007175345879051373 > ./result_6chains/node309_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_5_2 -p 856 -st topic309_5_1 -pt None -u 0.03336138622793725 > ./result_6chains/node309_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_0_0 -p 82 -st none -pt topic309_0_0 -u 0.025796125237008083 > ./result_6chains/node309_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_1_0 -p 280 -st none -pt topic309_1_0 -u 0.006907238577076202 > ./result_6chains/node309_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_2_0 -p 728 -st none -pt topic309_2_0 -u 0.032091340401768476 > ./result_6chains/node309_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_3_0 -p 742 -st none -pt topic309_3_0 -u 0.05409618136638361 > ./result_6chains/node309_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node309_4_0 -p 782 -st none -pt topic309_4_0 -u 0.0007733623554329327 > ./result_6chains/node309_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node309_5_0 -p 856 -st none -pt topic309_5_0 -u 0.031065191255397764 > ./result_6chains/node309_5_0.txt &
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
    "./result_6chains/node309_0_0.txt 90"
    "./result_6chains/node309_0_2.txt 90"
    "./result_6chains/node309_1_0.txt 89"
    "./result_6chains/node309_1_2.txt 89"
    "./result_6chains/node309_2_0.txt 88"
    "./result_6chains/node309_2_2.txt 88"
    "./result_6chains/node309_3_0.txt 87"
    "./result_6chains/node309_3_2.txt 87"
    "./result_6chains/node309_4_0.txt 86"
    "./result_6chains/node309_4_2.txt 86"
    "./result_6chains/node309_5_0.txt 85"
    "./result_6chains/node309_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_2 -p 90 -st topic444_0_1 -pt None -u 0.007757480107873527 > ./result_4chains/node444_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_2 -p 168 -st topic444_1_1 -pt None -u 0.008559671968583982 > ./result_4chains/node444_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_2 -p 535 -st topic444_2_1 -pt None -u 0.057501848616084816 > ./result_4chains/node444_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_2 -p 803 -st topic444_3_1 -pt None -u 0.04782205513134332 > ./result_4chains/node444_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_0_0 -p 90 -st none -pt topic444_0_0 -u 0.019156039965923854 > ./result_4chains/node444_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_1_0 -p 168 -st none -pt topic444_1_0 -u 0.014737803575713304 > ./result_4chains/node444_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node444_2_0 -p 535 -st none -pt topic444_2_0 -u 0.0336476266677031 > ./result_4chains/node444_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node444_3_0 -p 803 -st none -pt topic444_3_0 -u 0.09097689492173747 > ./result_4chains/node444_3_0.txt &
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
    "./result_4chains/node444_0_0.txt 90"
    "./result_4chains/node444_0_2.txt 90"
    "./result_4chains/node444_1_0.txt 89"
    "./result_4chains/node444_1_2.txt 89"
    "./result_4chains/node444_2_0.txt 88"
    "./result_4chains/node444_2_2.txt 88"
    "./result_4chains/node444_3_0.txt 87"
    "./result_4chains/node444_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

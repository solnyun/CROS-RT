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
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_2 -p 39 -st topic286_0_1 -pt None -u 0.03836707818826901 > ./result_6chains/node286_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_2 -p 385 -st topic286_1_1 -pt None -u 0.0017006304961735275 > ./result_6chains/node286_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_2 -p 412 -st topic286_2_1 -pt None -u 0.005064830700618084 > ./result_6chains/node286_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_2 -p 470 -st topic286_3_1 -pt None -u 0.02324941027636282 > ./result_6chains/node286_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_4_2 -p 530 -st topic286_4_1 -pt None -u 0.038045349735220044 > ./result_6chains/node286_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_5_2 -p 630 -st topic286_5_1 -pt None -u 0.011760981610715654 > ./result_6chains/node286_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_0 -p 39 -st none -pt topic286_0_0 -u 0.009497826797257025 > ./result_6chains/node286_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_0 -p 385 -st none -pt topic286_1_0 -u 0.03936873445813788 > ./result_6chains/node286_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_0 -p 412 -st none -pt topic286_2_0 -u 0.02520484368996595 > ./result_6chains/node286_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_0 -p 470 -st none -pt topic286_3_0 -u 0.014689880211049389 > ./result_6chains/node286_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_4_0 -p 530 -st none -pt topic286_4_0 -u 0.00828159652430624 > ./result_6chains/node286_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_5_0 -p 630 -st none -pt topic286_5_0 -u 0.0284179636062261 > ./result_6chains/node286_5_0.txt &
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
    "./result_6chains/node286_0_0.txt 90"
    "./result_6chains/node286_0_2.txt 90"
    "./result_6chains/node286_1_0.txt 89"
    "./result_6chains/node286_1_2.txt 89"
    "./result_6chains/node286_2_0.txt 88"
    "./result_6chains/node286_2_2.txt 88"
    "./result_6chains/node286_3_0.txt 87"
    "./result_6chains/node286_3_2.txt 87"
    "./result_6chains/node286_4_0.txt 86"
    "./result_6chains/node286_4_2.txt 86"
    "./result_6chains/node286_5_0.txt 85"
    "./result_6chains/node286_5_2.txt 85"
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

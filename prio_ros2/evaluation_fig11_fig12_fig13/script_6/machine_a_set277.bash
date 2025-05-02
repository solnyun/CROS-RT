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
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_2 -p 104 -st topic277_0_1 -pt None -u 0.0024759063557227567 > ./result_6chains/node277_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_2 -p 146 -st topic277_1_1 -pt None -u 0.05245185995272983 > ./result_6chains/node277_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_2 -p 414 -st topic277_2_1 -pt None -u 0.07428078436728403 > ./result_6chains/node277_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_2 -p 600 -st topic277_3_1 -pt None -u 0.041417102894727054 > ./result_6chains/node277_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_2 -p 918 -st topic277_4_1 -pt None -u 0.023824384826686973 > ./result_6chains/node277_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_2 -p 953 -st topic277_5_1 -pt None -u 0.003350121012350196 > ./result_6chains/node277_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_0_0 -p 104 -st none -pt topic277_0_0 -u 0.010821869355807201 > ./result_6chains/node277_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_1_0 -p 146 -st none -pt topic277_1_0 -u 0.002196968095265206 > ./result_6chains/node277_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_2_0 -p 414 -st none -pt topic277_2_0 -u 0.007375184108372512 > ./result_6chains/node277_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_3_0 -p 600 -st none -pt topic277_3_0 -u 0.023223446282042953 > ./result_6chains/node277_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node277_4_0 -p 918 -st none -pt topic277_4_0 -u 0.010327495040660065 > ./result_6chains/node277_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node277_5_0 -p 953 -st none -pt topic277_5_0 -u 0.04115573501099129 > ./result_6chains/node277_5_0.txt &
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
    "./result_6chains/node277_0_0.txt 90"
    "./result_6chains/node277_0_2.txt 90"
    "./result_6chains/node277_1_0.txt 89"
    "./result_6chains/node277_1_2.txt 89"
    "./result_6chains/node277_2_0.txt 88"
    "./result_6chains/node277_2_2.txt 88"
    "./result_6chains/node277_3_0.txt 87"
    "./result_6chains/node277_3_2.txt 87"
    "./result_6chains/node277_4_0.txt 86"
    "./result_6chains/node277_4_2.txt 86"
    "./result_6chains/node277_5_0.txt 85"
    "./result_6chains/node277_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node92_0_2 -p 174 -st topic92_0_1 -pt None -u 0.06802093063470055 > ./result_6chains/node92_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_1_2 -p 239 -st topic92_1_1 -pt None -u 0.01593496522247001 > ./result_6chains/node92_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_2_2 -p 245 -st topic92_2_1 -pt None -u 0.033868816347574215 > ./result_6chains/node92_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_3_2 -p 397 -st topic92_3_1 -pt None -u 0.03148806358725112 > ./result_6chains/node92_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_4_2 -p 756 -st topic92_4_1 -pt None -u 0.010382492799942564 > ./result_6chains/node92_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_5_2 -p 852 -st topic92_5_1 -pt None -u 0.05889955628027072 > ./result_6chains/node92_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_0_0 -p 174 -st none -pt topic92_0_0 -u 0.002493803262638594 > ./result_6chains/node92_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_1_0 -p 239 -st none -pt topic92_1_0 -u 0.08687572565750373 > ./result_6chains/node92_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_2_0 -p 245 -st none -pt topic92_2_0 -u 0.004017500342378855 > ./result_6chains/node92_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_3_0 -p 397 -st none -pt topic92_3_0 -u 0.0020167716549741033 > ./result_6chains/node92_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node92_4_0 -p 756 -st none -pt topic92_4_0 -u 0.010844909685776338 > ./result_6chains/node92_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node92_5_0 -p 852 -st none -pt topic92_5_0 -u 0.02126524329189812 > ./result_6chains/node92_5_0.txt &
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
    "./result_6chains/node92_0_0.txt 90"
    "./result_6chains/node92_0_2.txt 90"
    "./result_6chains/node92_1_0.txt 89"
    "./result_6chains/node92_1_2.txt 89"
    "./result_6chains/node92_2_0.txt 88"
    "./result_6chains/node92_2_2.txt 88"
    "./result_6chains/node92_3_0.txt 87"
    "./result_6chains/node92_3_2.txt 87"
    "./result_6chains/node92_4_0.txt 86"
    "./result_6chains/node92_4_2.txt 86"
    "./result_6chains/node92_5_0.txt 85"
    "./result_6chains/node92_5_2.txt 85"
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

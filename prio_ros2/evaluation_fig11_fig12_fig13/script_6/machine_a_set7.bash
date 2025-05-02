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
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_2 -p 247 -st topic7_0_1 -pt None -u 0.00819818361147151 > ./result_6chains/node7_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_2 -p 377 -st topic7_1_1 -pt None -u 0.04952448462772763 > ./result_6chains/node7_1_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_2 -p 426 -st topic7_2_1 -pt None -u 0.01950950653997635 > ./result_6chains/node7_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_2 -p 460 -st topic7_3_1 -pt None -u 0.028811852064489135 > ./result_6chains/node7_3_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_2 -p 654 -st topic7_4_1 -pt None -u 0.01786393232595493 > ./result_6chains/node7_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_2 -p 901 -st topic7_5_1 -pt None -u 0.015843581621806564 > ./result_6chains/node7_5_2.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_0_0 -p 247 -st none -pt topic7_0_0 -u 0.0073077926553142825 > ./result_6chains/node7_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_1_0 -p 377 -st none -pt topic7_1_0 -u 0.004974696992552763 > ./result_6chains/node7_1_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_2_0 -p 426 -st none -pt topic7_2_0 -u 0.007704307009108402 > ./result_6chains/node7_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_3_0 -p 460 -st none -pt topic7_3_0 -u 0.022590798320958394 > ./result_6chains/node7_3_0.txt &
sleep 10
ros2 run evaluation_3_randomdag uunifast_node -n node7_4_0 -p 654 -st none -pt topic7_4_0 -u 0.05876650207585574 > ./result_6chains/node7_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node7_5_0 -p 901 -st none -pt topic7_5_0 -u 0.018873178764040835 > ./result_6chains/node7_5_0.txt &
sleep 10
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
    "./result_6chains/node7_0_0.txt 90"
    "./result_6chains/node7_0_2.txt 90"
    "./result_6chains/node7_1_0.txt 89"
    "./result_6chains/node7_1_2.txt 89"
    "./result_6chains/node7_2_0.txt 88"
    "./result_6chains/node7_2_2.txt 88"
    "./result_6chains/node7_3_0.txt 87"
    "./result_6chains/node7_3_2.txt 87"
    "./result_6chains/node7_4_0.txt 86"
    "./result_6chains/node7_4_2.txt 86"
    "./result_6chains/node7_5_0.txt 85"
    "./result_6chains/node7_5_2.txt 85"
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
sleep 30s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999

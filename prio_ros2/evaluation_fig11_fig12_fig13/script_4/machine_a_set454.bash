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
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_2 -p 209 -st topic454_0_1 -pt None -u 0.024880389937926906 > ./result_4chains/node454_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_2 -p 573 -st topic454_1_1 -pt None -u 0.08726849542738258 > ./result_4chains/node454_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_2 -p 776 -st topic454_2_1 -pt None -u 0.039403906545915676 > ./result_4chains/node454_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_2 -p 891 -st topic454_3_1 -pt None -u 0.007037690459331206 > ./result_4chains/node454_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_0 -p 209 -st none -pt topic454_0_0 -u 0.05893515657974174 > ./result_4chains/node454_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_0 -p 573 -st none -pt topic454_1_0 -u 0.016387374656533837 > ./result_4chains/node454_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_0 -p 776 -st none -pt topic454_2_0 -u 0.07663973386814493 > ./result_4chains/node454_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_0 -p 891 -st none -pt topic454_3_0 -u 0.07405897686186477 > ./result_4chains/node454_3_0.txt &
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
    "./result_4chains/node454_0_0.txt 90"
    "./result_4chains/node454_0_2.txt 90"
    "./result_4chains/node454_1_0.txt 89"
    "./result_4chains/node454_1_2.txt 89"
    "./result_4chains/node454_2_0.txt 88"
    "./result_4chains/node454_2_2.txt 88"
    "./result_4chains/node454_3_0.txt 87"
    "./result_4chains/node454_3_2.txt 87"
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

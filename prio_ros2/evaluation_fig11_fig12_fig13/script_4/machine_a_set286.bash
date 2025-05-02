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
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_2 -p 100 -st topic286_0_1 -pt None -u 0.00022678842766932217 > ./result_4chains/node286_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_2 -p 556 -st topic286_1_1 -pt None -u 0.054384636283699356 > ./result_4chains/node286_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_2 -p 651 -st topic286_2_1 -pt None -u 0.003955462749666447 > ./result_4chains/node286_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_2 -p 876 -st topic286_3_1 -pt None -u 0.0359131452530535 > ./result_4chains/node286_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_0_0 -p 100 -st none -pt topic286_0_0 -u 0.016491252333506734 > ./result_4chains/node286_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_1_0 -p 556 -st none -pt topic286_1_0 -u 0.18135773783319997 > ./result_4chains/node286_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node286_2_0 -p 651 -st none -pt topic286_2_0 -u 0.04128311983053179 > ./result_4chains/node286_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node286_3_0 -p 876 -st none -pt topic286_3_0 -u 0.02619885501473969 > ./result_4chains/node286_3_0.txt &
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
    "./result_4chains/node286_0_0.txt 90"
    "./result_4chains/node286_0_2.txt 90"
    "./result_4chains/node286_1_0.txt 89"
    "./result_4chains/node286_1_2.txt 89"
    "./result_4chains/node286_2_0.txt 88"
    "./result_4chains/node286_2_2.txt 88"
    "./result_4chains/node286_3_0.txt 87"
    "./result_4chains/node286_3_2.txt 87"
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

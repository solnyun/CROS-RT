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
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_2 -p 511 -st topic492_0_1 -pt None -u 0.15689263252744795 > ./result_4chains/node492_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_2 -p 728 -st topic492_1_1 -pt None -u 0.014790118589658549 > ./result_4chains/node492_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_2 -p 729 -st topic492_2_1 -pt None -u 0.015305540034656492 > ./result_4chains/node492_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_2 -p 891 -st topic492_3_1 -pt None -u 0.0016388025672644023 > ./result_4chains/node492_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_0_0 -p 511 -st none -pt topic492_0_0 -u 0.06519808040025271 > ./result_4chains/node492_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_1_0 -p 728 -st none -pt topic492_1_0 -u 0.012892415697102089 > ./result_4chains/node492_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node492_2_0 -p 729 -st none -pt topic492_2_0 -u 0.0471727655999271 > ./result_4chains/node492_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node492_3_0 -p 891 -st none -pt topic492_3_0 -u 0.0030181186007013777 > ./result_4chains/node492_3_0.txt &
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
    "./result_4chains/node492_0_0.txt 90"
    "./result_4chains/node492_0_2.txt 90"
    "./result_4chains/node492_1_0.txt 89"
    "./result_4chains/node492_1_2.txt 89"
    "./result_4chains/node492_2_0.txt 88"
    "./result_4chains/node492_2_2.txt 88"
    "./result_4chains/node492_3_0.txt 87"
    "./result_4chains/node492_3_2.txt 87"
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

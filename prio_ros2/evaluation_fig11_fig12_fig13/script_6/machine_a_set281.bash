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
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_2 -p 143 -st topic281_0_1 -pt None -u 0.018499078097461374 > ./result_6chains/node281_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_2 -p 183 -st topic281_1_1 -pt None -u 0.021995114234622748 > ./result_6chains/node281_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_2 -p 257 -st topic281_2_1 -pt None -u 0.06773495662370754 > ./result_6chains/node281_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_2 -p 483 -st topic281_3_1 -pt None -u 0.002790841841380065 > ./result_6chains/node281_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_2 -p 811 -st topic281_4_1 -pt None -u 0.016442624590393223 > ./result_6chains/node281_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_2 -p 818 -st topic281_5_1 -pt None -u 0.052140971612171114 > ./result_6chains/node281_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_0_0 -p 143 -st none -pt topic281_0_0 -u 0.016398119450229898 > ./result_6chains/node281_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_1_0 -p 183 -st none -pt topic281_1_0 -u 0.01762491730707416 > ./result_6chains/node281_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_2_0 -p 257 -st none -pt topic281_2_0 -u 0.01993536106183519 > ./result_6chains/node281_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_3_0 -p 483 -st none -pt topic281_3_0 -u 0.005285327601740275 > ./result_6chains/node281_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node281_4_0 -p 811 -st none -pt topic281_4_0 -u 0.07895329643751843 > ./result_6chains/node281_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node281_5_0 -p 818 -st none -pt topic281_5_0 -u 0.018386604685870722 > ./result_6chains/node281_5_0.txt &
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
    "./result_6chains/node281_0_0.txt 90"
    "./result_6chains/node281_0_2.txt 90"
    "./result_6chains/node281_1_0.txt 89"
    "./result_6chains/node281_1_2.txt 89"
    "./result_6chains/node281_2_0.txt 88"
    "./result_6chains/node281_2_2.txt 88"
    "./result_6chains/node281_3_0.txt 87"
    "./result_6chains/node281_3_2.txt 87"
    "./result_6chains/node281_4_0.txt 86"
    "./result_6chains/node281_4_2.txt 86"
    "./result_6chains/node281_5_0.txt 85"
    "./result_6chains/node281_5_2.txt 85"
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

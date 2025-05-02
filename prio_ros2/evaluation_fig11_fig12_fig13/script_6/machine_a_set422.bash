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
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_2 -p 215 -st topic422_0_1 -pt None -u 0.03434773801894708 > ./result_6chains/node422_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_2 -p 364 -st topic422_1_1 -pt None -u 0.043069565201985904 > ./result_6chains/node422_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_2 -p 391 -st topic422_2_1 -pt None -u 0.025099357219839524 > ./result_6chains/node422_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_2 -p 641 -st topic422_3_1 -pt None -u 0.021713122374242125 > ./result_6chains/node422_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_4_2 -p 699 -st topic422_4_1 -pt None -u 0.008339299036611049 > ./result_6chains/node422_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_5_2 -p 708 -st topic422_5_1 -pt None -u 0.008993291012150975 > ./result_6chains/node422_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_0_0 -p 215 -st none -pt topic422_0_0 -u 0.011798995045973926 > ./result_6chains/node422_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_1_0 -p 364 -st none -pt topic422_1_0 -u 0.011806690241406348 > ./result_6chains/node422_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_2_0 -p 391 -st none -pt topic422_2_0 -u 0.11420774942631745 > ./result_6chains/node422_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_3_0 -p 641 -st none -pt topic422_3_0 -u 0.04155451253193958 > ./result_6chains/node422_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node422_4_0 -p 699 -st none -pt topic422_4_0 -u 0.0037380113488302974 > ./result_6chains/node422_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node422_5_0 -p 708 -st none -pt topic422_5_0 -u 0.011040923892430193 > ./result_6chains/node422_5_0.txt &
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
    "./result_6chains/node422_0_0.txt 90"
    "./result_6chains/node422_0_2.txt 90"
    "./result_6chains/node422_1_0.txt 89"
    "./result_6chains/node422_1_2.txt 89"
    "./result_6chains/node422_2_0.txt 88"
    "./result_6chains/node422_2_2.txt 88"
    "./result_6chains/node422_3_0.txt 87"
    "./result_6chains/node422_3_2.txt 87"
    "./result_6chains/node422_4_0.txt 86"
    "./result_6chains/node422_4_2.txt 86"
    "./result_6chains/node422_5_0.txt 85"
    "./result_6chains/node422_5_2.txt 85"
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

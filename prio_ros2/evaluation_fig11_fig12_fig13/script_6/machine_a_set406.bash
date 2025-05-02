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
ros2 run evaluation_3_randomdag uunifast_node -n node406_0_2 -p 277 -st topic406_0_1 -pt None -u 0.03541690028687777 > ./result_6chains/node406_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_1_2 -p 364 -st topic406_1_1 -pt None -u 0.010909045683802465 > ./result_6chains/node406_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_2_2 -p 568 -st topic406_2_1 -pt None -u 0.004527328980407586 > ./result_6chains/node406_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_3_2 -p 608 -st topic406_3_1 -pt None -u 0.03819898823626097 > ./result_6chains/node406_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_4_2 -p 642 -st topic406_4_1 -pt None -u 0.01950458747133945 > ./result_6chains/node406_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_5_2 -p 960 -st topic406_5_1 -pt None -u 0.014522304818888046 > ./result_6chains/node406_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_0_0 -p 277 -st none -pt topic406_0_0 -u 0.02389422513590267 > ./result_6chains/node406_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_1_0 -p 364 -st none -pt topic406_1_0 -u 0.00821623646191777 > ./result_6chains/node406_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_2_0 -p 568 -st none -pt topic406_2_0 -u 0.022744398604316984 > ./result_6chains/node406_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_3_0 -p 608 -st none -pt topic406_3_0 -u 0.06153038551085352 > ./result_6chains/node406_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node406_4_0 -p 642 -st none -pt topic406_4_0 -u 0.04489294248524524 > ./result_6chains/node406_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node406_5_0 -p 960 -st none -pt topic406_5_0 -u 0.002587763918517831 > ./result_6chains/node406_5_0.txt &
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
    "./result_6chains/node406_0_0.txt 90"
    "./result_6chains/node406_0_2.txt 90"
    "./result_6chains/node406_1_0.txt 89"
    "./result_6chains/node406_1_2.txt 89"
    "./result_6chains/node406_2_0.txt 88"
    "./result_6chains/node406_2_2.txt 88"
    "./result_6chains/node406_3_0.txt 87"
    "./result_6chains/node406_3_2.txt 87"
    "./result_6chains/node406_4_0.txt 86"
    "./result_6chains/node406_4_2.txt 86"
    "./result_6chains/node406_5_0.txt 85"
    "./result_6chains/node406_5_2.txt 85"
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

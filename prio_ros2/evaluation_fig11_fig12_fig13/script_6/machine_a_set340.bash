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
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_2 -p 287 -st topic340_0_1 -pt None -u 0.009298219003325225 > ./result_6chains/node340_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_2 -p 378 -st topic340_1_1 -pt None -u 0.035920308164881065 > ./result_6chains/node340_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_2 -p 591 -st topic340_2_1 -pt None -u 0.05217114957206864 > ./result_6chains/node340_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_2 -p 601 -st topic340_3_1 -pt None -u 0.08545129306327223 > ./result_6chains/node340_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_4_2 -p 863 -st topic340_4_1 -pt None -u 0.053403967175045905 > ./result_6chains/node340_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_5_2 -p 922 -st topic340_5_1 -pt None -u 0.02415329106076869 > ./result_6chains/node340_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_0_0 -p 287 -st none -pt topic340_0_0 -u 0.05660172564878185 > ./result_6chains/node340_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_1_0 -p 378 -st none -pt topic340_1_0 -u 0.0030252043101762216 > ./result_6chains/node340_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_2_0 -p 591 -st none -pt topic340_2_0 -u 0.018743696873010085 > ./result_6chains/node340_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_3_0 -p 601 -st none -pt topic340_3_0 -u 0.04598900086108204 > ./result_6chains/node340_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node340_4_0 -p 863 -st none -pt topic340_4_0 -u 0.025667886259993472 > ./result_6chains/node340_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node340_5_0 -p 922 -st none -pt topic340_5_0 -u 0.006951532380472317 > ./result_6chains/node340_5_0.txt &
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
    "./result_6chains/node340_0_0.txt 90"
    "./result_6chains/node340_0_2.txt 90"
    "./result_6chains/node340_1_0.txt 89"
    "./result_6chains/node340_1_2.txt 89"
    "./result_6chains/node340_2_0.txt 88"
    "./result_6chains/node340_2_2.txt 88"
    "./result_6chains/node340_3_0.txt 87"
    "./result_6chains/node340_3_2.txt 87"
    "./result_6chains/node340_4_0.txt 86"
    "./result_6chains/node340_4_2.txt 86"
    "./result_6chains/node340_5_0.txt 85"
    "./result_6chains/node340_5_2.txt 85"
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

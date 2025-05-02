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
ros2 run evaluation_3_randomdag uunifast_node -n node166_0_2 -p 46 -st topic166_0_1 -pt None -u 0.007046083390474023 > ./result_6chains/node166_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_1_2 -p 239 -st topic166_1_1 -pt None -u 0.014622013956903712 > ./result_6chains/node166_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_2_2 -p 365 -st topic166_2_1 -pt None -u 0.003159806865553727 > ./result_6chains/node166_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_3_2 -p 381 -st topic166_3_1 -pt None -u 0.002769997194775997 > ./result_6chains/node166_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_4_2 -p 440 -st topic166_4_1 -pt None -u 0.08291005535884824 > ./result_6chains/node166_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_5_2 -p 957 -st topic166_5_1 -pt None -u 0.09331776156711291 > ./result_6chains/node166_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_0_0 -p 46 -st none -pt topic166_0_0 -u 0.0014388769871854779 > ./result_6chains/node166_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_1_0 -p 239 -st none -pt topic166_1_0 -u 0.011623710519897135 > ./result_6chains/node166_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_2_0 -p 365 -st none -pt topic166_2_0 -u 0.0017574262770245208 > ./result_6chains/node166_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_3_0 -p 381 -st none -pt topic166_3_0 -u 0.033250789758711485 > ./result_6chains/node166_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node166_4_0 -p 440 -st none -pt topic166_4_0 -u 0.025192879767660437 > ./result_6chains/node166_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node166_5_0 -p 957 -st none -pt topic166_5_0 -u 0.0192243822659241 > ./result_6chains/node166_5_0.txt &
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
    "./result_6chains/node166_0_0.txt 90"
    "./result_6chains/node166_0_2.txt 90"
    "./result_6chains/node166_1_0.txt 89"
    "./result_6chains/node166_1_2.txt 89"
    "./result_6chains/node166_2_0.txt 88"
    "./result_6chains/node166_2_2.txt 88"
    "./result_6chains/node166_3_0.txt 87"
    "./result_6chains/node166_3_2.txt 87"
    "./result_6chains/node166_4_0.txt 86"
    "./result_6chains/node166_4_2.txt 86"
    "./result_6chains/node166_5_0.txt 85"
    "./result_6chains/node166_5_2.txt 85"
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

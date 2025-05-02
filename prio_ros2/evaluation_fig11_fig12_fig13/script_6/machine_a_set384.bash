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
ros2 run evaluation_3_randomdag uunifast_node -n node384_0_2 -p 137 -st topic384_0_1 -pt None -u 0.0030690914869623276 > ./result_6chains/node384_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_1_2 -p 153 -st topic384_1_1 -pt None -u 0.011465956310186709 > ./result_6chains/node384_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_2_2 -p 168 -st topic384_2_1 -pt None -u 0.0006510650453739053 > ./result_6chains/node384_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_3_2 -p 359 -st topic384_3_1 -pt None -u 0.03346516885820387 > ./result_6chains/node384_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_4_2 -p 571 -st topic384_4_1 -pt None -u 0.0005265920384425506 > ./result_6chains/node384_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_5_2 -p 581 -st topic384_5_1 -pt None -u 0.025279195915347524 > ./result_6chains/node384_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_0_0 -p 137 -st none -pt topic384_0_0 -u 0.12433063761437235 > ./result_6chains/node384_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_1_0 -p 153 -st none -pt topic384_1_0 -u 0.00562186203684284 > ./result_6chains/node384_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_2_0 -p 168 -st none -pt topic384_2_0 -u 0.022341908656662024 > ./result_6chains/node384_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_3_0 -p 359 -st none -pt topic384_3_0 -u 0.003890575980250055 > ./result_6chains/node384_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node384_4_0 -p 571 -st none -pt topic384_4_0 -u 0.054697430156854486 > ./result_6chains/node384_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node384_5_0 -p 581 -st none -pt topic384_5_0 -u 0.0010207512350876267 > ./result_6chains/node384_5_0.txt &
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
    "./result_6chains/node384_0_0.txt 90"
    "./result_6chains/node384_0_2.txt 90"
    "./result_6chains/node384_1_0.txt 89"
    "./result_6chains/node384_1_2.txt 89"
    "./result_6chains/node384_2_0.txt 88"
    "./result_6chains/node384_2_2.txt 88"
    "./result_6chains/node384_3_0.txt 87"
    "./result_6chains/node384_3_2.txt 87"
    "./result_6chains/node384_4_0.txt 86"
    "./result_6chains/node384_4_2.txt 86"
    "./result_6chains/node384_5_0.txt 85"
    "./result_6chains/node384_5_2.txt 85"
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

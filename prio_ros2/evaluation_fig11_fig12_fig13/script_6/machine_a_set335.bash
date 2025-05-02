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
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_2 -p 49 -st topic335_0_1 -pt None -u 0.04508178708928168 > ./result_6chains/node335_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_2 -p 138 -st topic335_1_1 -pt None -u 0.024206989531042444 > ./result_6chains/node335_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_2 -p 198 -st topic335_2_1 -pt None -u 0.02594327094568566 > ./result_6chains/node335_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_2 -p 749 -st topic335_3_1 -pt None -u 0.0032918715774064855 > ./result_6chains/node335_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_2 -p 779 -st topic335_4_1 -pt None -u 0.03213577091075821 > ./result_6chains/node335_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_2 -p 831 -st topic335_5_1 -pt None -u 0.0058927950069783495 > ./result_6chains/node335_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_0_0 -p 49 -st none -pt topic335_0_0 -u 0.0179920724823312 > ./result_6chains/node335_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_1_0 -p 138 -st none -pt topic335_1_0 -u 0.00618782052570116 > ./result_6chains/node335_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_2_0 -p 198 -st none -pt topic335_2_0 -u 0.009946777330796852 > ./result_6chains/node335_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_3_0 -p 749 -st none -pt topic335_3_0 -u 0.0064525717342575895 > ./result_6chains/node335_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node335_4_0 -p 779 -st none -pt topic335_4_0 -u 0.044068057715985626 > ./result_6chains/node335_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node335_5_0 -p 831 -st none -pt topic335_5_0 -u 0.006573492671230179 > ./result_6chains/node335_5_0.txt &
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
    "./result_6chains/node335_0_0.txt 90"
    "./result_6chains/node335_0_2.txt 90"
    "./result_6chains/node335_1_0.txt 89"
    "./result_6chains/node335_1_2.txt 89"
    "./result_6chains/node335_2_0.txt 88"
    "./result_6chains/node335_2_2.txt 88"
    "./result_6chains/node335_3_0.txt 87"
    "./result_6chains/node335_3_2.txt 87"
    "./result_6chains/node335_4_0.txt 86"
    "./result_6chains/node335_4_2.txt 86"
    "./result_6chains/node335_5_0.txt 85"
    "./result_6chains/node335_5_2.txt 85"
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

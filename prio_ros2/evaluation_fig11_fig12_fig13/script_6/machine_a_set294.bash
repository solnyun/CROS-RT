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
ros2 run evaluation_3_randomdag uunifast_node -n node294_0_2 -p 42 -st topic294_0_1 -pt None -u 0.0237793957290639 > ./result_6chains/node294_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_1_2 -p 570 -st topic294_1_1 -pt None -u 0.024630541452403953 > ./result_6chains/node294_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_2_2 -p 571 -st topic294_2_1 -pt None -u 0.01748368018480806 > ./result_6chains/node294_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_3_2 -p 823 -st topic294_3_1 -pt None -u 0.08126444408226499 > ./result_6chains/node294_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_4_2 -p 863 -st topic294_4_1 -pt None -u 0.006134013517579723 > ./result_6chains/node294_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_5_2 -p 977 -st topic294_5_1 -pt None -u 0.0023477701764244427 > ./result_6chains/node294_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_0_0 -p 42 -st none -pt topic294_0_0 -u 0.03021063918468525 > ./result_6chains/node294_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_1_0 -p 570 -st none -pt topic294_1_0 -u 0.03463085168379765 > ./result_6chains/node294_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_2_0 -p 571 -st none -pt topic294_2_0 -u 8.066012280100177e-05 > ./result_6chains/node294_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_3_0 -p 823 -st none -pt topic294_3_0 -u 0.0012543977784041926 > ./result_6chains/node294_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node294_4_0 -p 863 -st none -pt topic294_4_0 -u 0.031084377474955793 > ./result_6chains/node294_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node294_5_0 -p 977 -st none -pt topic294_5_0 -u 0.062359943094477156 > ./result_6chains/node294_5_0.txt &
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
    "./result_6chains/node294_0_0.txt 90"
    "./result_6chains/node294_0_2.txt 90"
    "./result_6chains/node294_1_0.txt 89"
    "./result_6chains/node294_1_2.txt 89"
    "./result_6chains/node294_2_0.txt 88"
    "./result_6chains/node294_2_2.txt 88"
    "./result_6chains/node294_3_0.txt 87"
    "./result_6chains/node294_3_2.txt 87"
    "./result_6chains/node294_4_0.txt 86"
    "./result_6chains/node294_4_2.txt 86"
    "./result_6chains/node294_5_0.txt 85"
    "./result_6chains/node294_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_2 -p 81 -st topic82_0_1 -pt None -u 0.12770059870255207 > ./result_6chains/node82_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_2 -p 164 -st topic82_1_1 -pt None -u 0.019814281091626196 > ./result_6chains/node82_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_2 -p 264 -st topic82_2_1 -pt None -u 0.03815953503228342 > ./result_6chains/node82_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_2 -p 343 -st topic82_3_1 -pt None -u 0.040016279483920086 > ./result_6chains/node82_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_2 -p 432 -st topic82_4_1 -pt None -u 0.03487621341275936 > ./result_6chains/node82_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_2 -p 682 -st topic82_5_1 -pt None -u 0.02321787966679881 > ./result_6chains/node82_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_0_0 -p 81 -st none -pt topic82_0_0 -u 0.018885517955649522 > ./result_6chains/node82_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_1_0 -p 164 -st none -pt topic82_1_0 -u 0.027578576342609795 > ./result_6chains/node82_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_2_0 -p 264 -st none -pt topic82_2_0 -u 0.014867501128727645 > ./result_6chains/node82_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_3_0 -p 343 -st none -pt topic82_3_0 -u 0.006714436266852308 > ./result_6chains/node82_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node82_4_0 -p 432 -st none -pt topic82_4_0 -u 0.003188498641938514 > ./result_6chains/node82_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node82_5_0 -p 682 -st none -pt topic82_5_0 -u 0.08144271678677885 > ./result_6chains/node82_5_0.txt &
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
    "./result_6chains/node82_0_0.txt 90"
    "./result_6chains/node82_0_2.txt 90"
    "./result_6chains/node82_1_0.txt 89"
    "./result_6chains/node82_1_2.txt 89"
    "./result_6chains/node82_2_0.txt 88"
    "./result_6chains/node82_2_2.txt 88"
    "./result_6chains/node82_3_0.txt 87"
    "./result_6chains/node82_3_2.txt 87"
    "./result_6chains/node82_4_0.txt 86"
    "./result_6chains/node82_4_2.txt 86"
    "./result_6chains/node82_5_0.txt 85"
    "./result_6chains/node82_5_2.txt 85"
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

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
ros2 run evaluation_3_randomdag uunifast_node -n node392_0_2 -p 35 -st topic392_0_1 -pt None -u 0.07162121130319282 > ./result_6chains/node392_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_1_2 -p 684 -st topic392_1_1 -pt None -u 0.03345550120764201 > ./result_6chains/node392_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_2_2 -p 812 -st topic392_2_1 -pt None -u 0.014577693490504112 > ./result_6chains/node392_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_3_2 -p 833 -st topic392_3_1 -pt None -u 0.014387017540134106 > ./result_6chains/node392_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_4_2 -p 872 -st topic392_4_1 -pt None -u 0.04179696831391522 > ./result_6chains/node392_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_5_2 -p 964 -st topic392_5_1 -pt None -u 0.06137047977020098 > ./result_6chains/node392_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_0_0 -p 35 -st none -pt topic392_0_0 -u 0.00034919157793622535 > ./result_6chains/node392_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_1_0 -p 684 -st none -pt topic392_1_0 -u 0.0065179103362404955 > ./result_6chains/node392_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_2_0 -p 812 -st none -pt topic392_2_0 -u 0.07285335751353023 > ./result_6chains/node392_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_3_0 -p 833 -st none -pt topic392_3_0 -u 0.013938483062653495 > ./result_6chains/node392_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node392_4_0 -p 872 -st none -pt topic392_4_0 -u 0.010992670836572987 > ./result_6chains/node392_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node392_5_0 -p 964 -st none -pt topic392_5_0 -u 0.011202378288637474 > ./result_6chains/node392_5_0.txt &
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
    "./result_6chains/node392_0_0.txt 90"
    "./result_6chains/node392_0_2.txt 90"
    "./result_6chains/node392_1_0.txt 89"
    "./result_6chains/node392_1_2.txt 89"
    "./result_6chains/node392_2_0.txt 88"
    "./result_6chains/node392_2_2.txt 88"
    "./result_6chains/node392_3_0.txt 87"
    "./result_6chains/node392_3_2.txt 87"
    "./result_6chains/node392_4_0.txt 86"
    "./result_6chains/node392_4_2.txt 86"
    "./result_6chains/node392_5_0.txt 85"
    "./result_6chains/node392_5_2.txt 85"
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

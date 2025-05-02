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
ros2 run evaluation_3_randomdag uunifast_node -n node386_0_2 -p 169 -st topic386_0_1 -pt None -u 0.01765524272740171 > ./result_6chains/node386_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_1_2 -p 176 -st topic386_1_1 -pt None -u 0.04270512029468071 > ./result_6chains/node386_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_2_2 -p 231 -st topic386_2_1 -pt None -u 0.0879943050522089 > ./result_6chains/node386_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_3_2 -p 370 -st topic386_3_1 -pt None -u 0.00444316477079762 > ./result_6chains/node386_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_4_2 -p 630 -st topic386_4_1 -pt None -u 0.044522721346116 > ./result_6chains/node386_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_5_2 -p 794 -st topic386_5_1 -pt None -u 0.016616497205222368 > ./result_6chains/node386_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_0_0 -p 169 -st none -pt topic386_0_0 -u 0.0025017095106248943 > ./result_6chains/node386_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_1_0 -p 176 -st none -pt topic386_1_0 -u 0.0024013698527944882 > ./result_6chains/node386_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_2_0 -p 231 -st none -pt topic386_2_0 -u 0.008199135758405807 > ./result_6chains/node386_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_3_0 -p 370 -st none -pt topic386_3_0 -u 0.013580979665855974 > ./result_6chains/node386_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_4_0 -p 630 -st none -pt topic386_4_0 -u 0.04115421307080133 > ./result_6chains/node386_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_5_0 -p 794 -st none -pt topic386_5_0 -u 0.015663853951258 > ./result_6chains/node386_5_0.txt &
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
    "./result_6chains/node386_0_0.txt 90"
    "./result_6chains/node386_0_2.txt 90"
    "./result_6chains/node386_1_0.txt 89"
    "./result_6chains/node386_1_2.txt 89"
    "./result_6chains/node386_2_0.txt 88"
    "./result_6chains/node386_2_2.txt 88"
    "./result_6chains/node386_3_0.txt 87"
    "./result_6chains/node386_3_2.txt 87"
    "./result_6chains/node386_4_0.txt 86"
    "./result_6chains/node386_4_2.txt 86"
    "./result_6chains/node386_5_0.txt 85"
    "./result_6chains/node386_5_2.txt 85"
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
